cmake_minimum_required(VERSION 2.6)

PROJECT(kohello C)

ADD_DEFINITIONS(-g -O2 -fsigned-char -freg-struct-return -Wall -W -Wshadow -Wstrict-prototypes -Wpointer-arith -Wcast-qual -Winline -Werror)

# Build the module

ADD_CUSTOM_COMMAND(OUTPUT hello.ko
	COMMAND make -C ${KERNEL_SRCDIR} M=${CMAKE_CURRENT_SOURCE_DIR}
                   DEPENDS kohello.c function.c
                   COMMENT "Building hello.ko"
                  )

ADD_CUSTOM_TARGET(kohello ALL DEPENDS hello.ko)


# Installation of the module
SET(module_install_path /lib/modules/${KERNEL_RELEASE}/kernel/extra/hello)
INSTALL(FILES hello.ko
        DESTINATION ${module_install_path}
        PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)



