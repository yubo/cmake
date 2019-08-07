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


