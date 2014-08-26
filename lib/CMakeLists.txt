cmake_minimum_required(VERSION 2.6)


add_definitions(-DPACKAGE_STRING="libhello")
ADD_DEFINITIONS(-g -O2 )
ADD_LIBRARY(hello SHARED libhello.c)
