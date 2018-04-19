cmake_minimum_required(VERSION 3.5)
project(hello_world)

set(CMAKE_CXX_STANDARD 11)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(SOURCE_FILES main.cpp)

if(WIN32)
add_executable(run_windows ${SOURCE_FILES})
endif()

if(APPLE)
add_executable(run_darwin ${SOURCE_FILES})
endif()

if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()
if(LINUX)
add_executable(run_linux ${SOURCE_FILES})
endif()


