set(CPACK_PACKAGE_RELOCATABLE "")
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE)
set(CPACK_RESOURCE_FILE_README ${CMAKE_CURRENT_SOURCE_DIR}/README.md)
set(CPACK_PACKAGING_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX})

set(CPACK_RPM_PACKAGE_SUMMARY "${CPACK_PACKAGE_NAME}")
set(CPACK_RPM_PACKAGE_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION_SUMMARY}")
# This prevents the default %post from running which causes binaries to be
# striped. Without this, MaxCtrl will not work on all systems as the
# binaries will be stripped.
set(CPACK_RPM_SPEC_INSTALL_POST "/bin/true")
set(CPACK_RPM_SPEC_MORE_DEFINE "%define ignore \#")		
set(CPACK_RPM_USER_FILELIST    "${IGNORED_DIRS}")
set(CPACK_RPM_PRE_UNINSTALL_SCRIPT_FILE ${CMAKE_CURRENT_BINARY_DIR}/rpm/prerm)
set(CPACK_RPM_POST_INSTALL_SCRIPT_FILE ${CMAKE_CURRENT_BINARY_DIR}/rpm/postinst)
set(CPACK_RPM_POST_UNINSTALL_SCRIPT_FILE ${CMAKE_CURRENT_BINARY_DIR}/rpm/postrm)

set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "${CPACK_PACKAGE_DESCRIPTION}\n ${CPACK_PACKAGE_DESCRIPTION_SUMMARY}")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE ${CMAKE_SYSTEM_PROCESSOR})
set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_CURRENT_BINARY_DIR}/deb/postinst;${CMAKE_CURRENT_BINARY_DIR}/deb/prerm;${CMAKE_CURRENT_BINARY_DIR}/deb/postrm")


if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux") # uname -s. Linux, Windows, and Darwin
	SET(GOOS linux)
elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
	SET(GOOS windows)
elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Darwin")
	SET(GOOS darwin)
elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Android")
	SET(GOOS android)
else()
	message(ERROR "unsupport system ${CMAKE_SYSTEM_NAME}")
endif()

if (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "x86_64") # uname -p
	SET(GOARCH amd64)
elseif (${CMAKE_SYSTEM_PROCESSOR} STREQUAL "i386")
	SET(GOARCH 386)
else()
	message(ERROR "unsupport arch ${CMAKE_SYSTEM_NAME}")
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/rpm/postinst.in
		${CMAKE_CURRENT_BINARY_DIR}/rpm/postinst)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/rpm/prerm.in
		${CMAKE_CURRENT_BINARY_DIR}/rpm/prerm)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/rpm/postrm.in
		${CMAKE_CURRENT_BINARY_DIR}/rpm/postrm)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/deb/postinst.in
		${CMAKE_CURRENT_BINARY_DIR}/deb/postinst)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/deb/prerm.in
		${CMAKE_CURRENT_BINARY_DIR}/deb/prerm)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/misc/deb/postrm.in
		${CMAKE_CURRENT_BINARY_DIR}/deb/postrm)
 
function(add_go_executable NAME)
	FILE(GLOB GO_SOURCE RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}" "*.go")
	SET(out_file ${CMAKE_CURRENT_BINARY_DIR}/${NAME})

	ADD_CUSTOM_COMMAND(
		OUTPUT ${out_file}
		DEPENDS ${GO_SOURCE}
		COMMAND env GOPATH=$ENV{GOPATH} CGO_ENABLE=${CGO_ENABLE} GOOS=${GOOS} GOARCH=${GOARCH}
			go build -o ${out_file} ${CMAKE_GO_FLAGS} ${GO_SOURCE}
		COMMENT "building ${out_file}"
		WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
		VERBATIM # to support \t for example
	)

	ADD_CUSTOM_TARGET(${NAME} ALL
		DEPENDS ${out_file}
		COMMENT "add add_custom_target ${NAME}"
	)
endfunction(add_go_executable)


