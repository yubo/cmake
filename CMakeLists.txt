# https://cmake.org/cmake/help/v3.15/cpack_gen/deb.html#cpack_gen:CPack%20DEB%20Generator
cmake_minimum_required(VERSION 2.8)
project(demo NONE)

set(APP_NAME "hello1"		CACHE STRING "app name")
set(CPACK_GENERATOR "RPM"	CACHE STRING "RPM/DEB")
set(CGO_ENABLE "0"		CACHE STRING "cgo enable")
set(CMAKE_INSTALL_PREFIX /opt/${APP_NAME} CACHE STRING "install prefix")

set(CPACK_PACKAGE_NAME ${APP_NAME})
set(CPACK_PACKAGE_VERSION "0.1.2")
set(CPACK_PACKAGE_RELEASE 1)
set(CPACK_PACKAGE_CONTACT "yubo@yubo.org")
set(CPACK_PACKAGE_VENDOR "yubo.org")
set(CPACK_PACKAGE_DESCRIPTION "cmake example")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "CPack Component Installation Example")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}-${CPACK_PACKAGE_RELEASE}.${CMAKE_SYSTEM_NAME}.${CMAKE_SYSTEM_PROCESSOR}")

set(IGNORED_DIRS
  "%ignore /opt"
  "%ignore ${CMAKE_INSTALL_PREFIX}"
  "%ignore ${CMAKE_INSTALL_PREFIX}/bin"
  "%ignore ${CMAKE_INSTALL_PREFIX}/docs")
set(CPACK_RPM_PACKAGE_GROUP "System Environment/Daemons")
set(CPACK_RPM_PACKAGE_URL "http://www.yubo.org")
set(CPACK_RPM_PACKAGE_LICENSE "BSD-3")
set(CPACK_RPM_PACKAGE_REQUIRES "")
# DEBIAN
set(CPACK_DEBIAN_PACKAGE_DEPENDS "libc6 (>= 2.7)")

include(scripts/general.cmake)

if (${APP_NAME} STREQUAL "hello1" OR ${APP_NAME} STREQUAL "hello2")
	add_subdirectory(cmd/${APP_NAME})
else()
	message( FATAL_ERROR "invalid APP_NAME, CMake will exit." )
endif()

install(DIRECTORY docs USE_SOURCE_PERMISSIONS DESTINATION ${CMAKE_INSTALL_PREFIX}) 
include(CPack)
