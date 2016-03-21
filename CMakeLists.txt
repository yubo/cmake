cmake_minimum_required(VERSION 2.6)

execute_process(COMMAND uname -r
	OUTPUT_VARIABLE KERNEL_RELEASE
	OUTPUT_STRIP_TRAILING_WHITESPACE)

find_path(KERNEL_SRCDIR Makefile PATHS
	/lib/modules/${KERNEL_RELEASE}/source
	/lib/modules/${KERNEL_RELEASE}/build)

message(STATUS "Kernel release: ${KERNEL_RELEASE}")
message(STATUS "Kernel source: ${KERNEL_SRCDIR}")

set(CPACK_GENERATOR "RPM;DEB")
set(CPACK_PACKAGE_NAME "cmake_example")
set(CPACK_PACKAGE_CONTACT "yubo@yubo.org")
set(CPACK_PACKAGE_VENDOR "yubo.org")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "cmake example - CPack Component Installation Example")
set(CPACK_PACKAGE_VERSION "0.1.0")
set(CPACK_PACKAGE_DESCRIPTION "cmake example")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${KERNEL_RELEASE}-${CPACK_PACKAGE_VERSION}.${CMAKE_SYSTEM_PROCESSOR}")
set(CPACK_RPM_CHANGELOG_FILE "${PROJECT_SOURCE_DIR}/ChangeLog")
include(CPack)

add_subdirectory(hello)
add_subdirectory(lib)
