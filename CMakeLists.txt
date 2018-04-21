cmake_minimum_required(VERSION 3.5)
project(hello_world)

set(CMAKE_CXX_STANDARD 11)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(SOURCE_FILES main.cpp)

if(WIN32)
  set(DYNAMIC_LIBRARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/bin")
  set(STATIC_LIBRARY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/.lib")

  set(INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../.include")
  include_directories(${INCLUDE_DIR})
  set(ALL_LIBS
     freeglut
     glew32
     glfw3
  )

 link_directories(${DYNAMIC_LIBRARY_DIR})
 link_directories(${STATIC_LIBRARY_DIR})

  # OPENGL
  add_executable(run_windows ${SOURCE_FILES})
  TARGET_LINK_LIBRARIES(run_windows ${ALL_LIBS})


endif()

if(APPLE)
  add_executable(run_darwin ${SOURCE_FILES})
  find_package(OpenGL REQUIRED)
  include_directories(${OPENGL_INCLUDE_DIRS})
  target_link_libraries(run_darwin glfw ${OPENGL_LIBRARIES})
endif()

if(UNIX AND NOT APPLE)
    set(LINUX TRUE)
endif()
if(LINUX)
  add_executable(run_linux ${SOURCE_FILES})
  find_package(OpenGL REQUIRED)
  add_definitions(${OPENGL_DEFINITIONS})
  find_package(X11 REQUIRED)
  # note that the order is important for setting the libs
  # use pkg-config --libs $(pkg-config --print-requires --print-requires-private glfw3) in a terminal to confirm
  set(LIBS glfw3 X11 Xrandr Xinerama Xi Xxf86vm Xcursor)
  set(INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../.include")
  include_directories(${OPENGL_INCLUDE_DIRS} ${INCLUDE_DIR})
  target_link_libraries(run_linux ${LIBS} ${OPENGL_LIBRARIES})
endif()


