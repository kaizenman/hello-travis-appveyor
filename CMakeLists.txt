cmake_minimum_required(VERSION 3.5)
project(hello_world)

set(CMAKE_CXX_STANDARD 11)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)


find_package(OpenGL)
INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})

set(SOURCE_FILES main.cpp)

if(WIN32)
add_executable(run_windows ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(run_windows ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES})
endif()

if(APPLE)
add_executable(run_darwin ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(run_darwin ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES})
endif()

if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()
if(LINUX)
add_executable(run_linux ${SOURCE_FILES})
TARGET_LINK_LIBRARIES(run_linux ${OPENGL_LIBRARIES} ${GLUT_LIBRARIES})
endif()


