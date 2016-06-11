#
# Copyright 2015 Xiaomi Corporation. All rights reserved.
# Use of this source code is governed by a BSD-style
# license that can be found in the LICENSE file.
#
# Authors:    Yu Bo <yubo@xiaomi.com>
#
cmake_minimum_required(VERSION 2.6)


add_definitions(-DPACKAGE_STRING="libhello")
ADD_DEFINITIONS(-g -O2 )

SET(SOURCES libhello.c)
ADD_LIBRARY(hello SHARED ${SOURCES})
ADD_LIBRARY(hello-static STATIC ${SOURCES})
SET_TARGET_PROPERTIES(hello-static PROPERTIES OUTPUT_NAME hello)
