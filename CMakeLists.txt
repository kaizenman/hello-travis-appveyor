cmake_minimum_required(VERSION 3.5)
project(hello_world)

set(CMAKE_CXX_STANDARD 11)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(SOURCE_FILES main.cpp)

if(WIN32)
  set(DYNAMIC_LIBRARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set(STATIC_LIBRARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/lib")

  # FREE GLUT
  set(OPENGL_GLUT_INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../freeglut-3.0.0/include")
  
  # GLEW
  set(OPENGL_GLEW_INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../glew-2.1.0/include")

  # GLFW
  set(OPENGL_GLFW_INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../glfw/include")

  include_directories(${OPENGL_GLUT_INCLUDE_DIR})
  include_directories(${OPENGL_GLEW_INCLUDE_DIR})
  include_directories(${OPENGL_GLFW_INCLUDE_DIR})

  set(ALL_LIBS
     freeglut
     glew32
  )

 # add_library(freeglut_static STATIC main.cpp)
 # add_library(glew32 STATIC main.cpp)
 # add_library(glfw3 STATIC main.cpp)
 link_directories(${DYNAMIC_LIBRARY_DIR})
 link_directories(${STATIC_LIBRARY_DIR})

  # OPENGL
  add_executable(run_windows ${SOURCE_FILES})
  TARGET_LINK_LIBRARIES(run_windows ${ALL_LIBS})


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


