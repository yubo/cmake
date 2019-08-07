add_go_executable(hello2)
install(PROGRAMS ${CMAKE_CURRENT_BINARY_DIR}/hello2
	DESTINATION bin
	COMPONENT hello2
)
