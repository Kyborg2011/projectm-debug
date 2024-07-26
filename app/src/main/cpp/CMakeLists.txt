# Sets the minimum CMake version required for this project.
cmake_minimum_required(VERSION 3.22.1)

project("projectm_debug")

set( lib_src_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../../../../distribution )

add_library( projectM-4
        SHARED
        IMPORTED )

set_target_properties( projectM-4
        PROPERTIES IMPORTED_LOCATION
        ${lib_src_DIR}/libprojectM/lib/${ANDROID_ABI}/libprojectM-4d.so )

include_directories( ${lib_src_DIR}/libprojectM/include
        ${CMAKE_CURRENT_SOURCE_DIR} )

add_library( ${CMAKE_PROJECT_NAME} SHARED
        native-lib.cpp )

target_link_libraries( ${CMAKE_PROJECT_NAME}
        projectM-4
        android
        log )