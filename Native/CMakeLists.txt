cmake_minimum_required(VERSION 3.20)
project("CGLTF-Native")

set(CMAKE_DEBUG_POSTFIX d)

macro(set_option option value)
  set(${option} ${value} CACHE "" INTERNAL FORCE)
endmacro()

set_option(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

add_library(cgltf cgltf.c)

add_custom_target(copy_libs ALL
    COMMENT "Copying library files"
)

function(copy_library target destination)
    if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
        set(PLATFORM_SUFFIX "Win64")
    elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        set(PLATFORM_SUFFIX "Linux64")
    else()
        message(FATAL_ERROR "Unsupported platform: ${CMAKE_SYSTEM_NAME}")
    endif()
    add_custom_command(TARGET copy_libs POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_SOURCE_DIR}/${destination}/$<CONFIG>-${PLATFORM_SUFFIX}"
        COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${target}> "${CMAKE_SOURCE_DIR}/${destination}/$<CONFIG>-${PLATFORM_SUFFIX}"
        COMMENT "Copying ${target} library to ${CMAKE_SOURCE_DIR}/${destination}/$<CONFIG>-${PLATFORM_SUFFIX}"
    )
endfunction()

copy_library(cgltf "../dist")