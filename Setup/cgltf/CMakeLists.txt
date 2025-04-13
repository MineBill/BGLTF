cmake_minimum_required(VERSION 3.20)
project("CGLTF-Native")

include(../BeefLibSetupHelper/Helper.cmake)

add_library(cgltf cgltf.c)

CopyLibrary(cgltf "../../dist")