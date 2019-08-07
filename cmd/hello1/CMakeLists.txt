add_go_executable(hello1)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/hello1
	DESTINATION bin
)
