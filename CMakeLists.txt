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
  find_package(PkgConfig REQUIRED)
  find_package(OpenGL REQUIRED)
  add_definitions(${OPENGL_DEFINITIONS})
  find_package(X11 REQUIRED)




  # =============SOME WEIRED SHIT HAPPENS SO WE NEED TO FIND RANDR 
    set(XRANDR_ROOT_DIR
      "${XRANDR_ROOT_DIR}"
	  CACHE
	  PATH
      "Directory to search for Xrandr")

    find_package(PkgConfig QUIET)
    if(PKG_CONFIG_FOUND)
	    pkg_check_modules(PC_LIBXRANDR xrandr)
    endif()

    find_library(XRANDR_LIBRARY
	    NAMES
	    Xrandr
	    PATHS
	    ${PC_LIBXRANDR_LIBRARY_DIRS}
	    ${PC_LIBXRANDR_LIBDIR}
	    HINTS
	    "${XRANDR_ROOT_DIR}"
	    PATH_SUFFIXES
	    lib
	    )

    get_filename_component(_libdir "${XRANDR_LIBRARY}" PATH)

    find_path(XRANDR_INCLUDE_DIR
	    NAMES
	    Xrandr.h
	    PATHS
	    ${PC_LIBXRANDR_INCLUDE_DIRS}
	    ${PC_LIBXRANDR_INCLUDEDIR}
	    HINTS
	    "${_libdir}"
	    "${_libdir}/.."
	    "${XRANDR_ROOT_DIR}"
	    PATH_SUFFIXES
	    X11
	    X11/extensions
	    )

    include(FindPackageHandleStandardArgs)
    find_package_handle_standard_args(XRANDR
	    DEFAULT_MSG
	    XRANDR_LIBRARY
	    XRANDR_INCLUDE_DIR
	    )

    if(XRANDR_FOUND)
	    list(APPEND XRANDR_LIBRARIES ${XRANDR_LIBRARY})
	    list(APPEND XRANDR_INCLUDE_DIRS ${XRANDR_INCLUDE_DIR})
	    mark_as_advanced(XRANDR_ROOT_DIR)
    endif()

    mark_as_advanced(XRANDR_INCLUDE_DIR
	    XRANDR_LIBRARY)

 # ======================= END ======================================














  #pkg_check_modules(FOO REQUIRED glfw3 X11 Xrandr Xinerama Xi Xxf86vm Xcursor GL)
  # note that the order is important for setting the libs
  # use pkg-config --libs $(pkg-config --print-requires --print-requires-private glfw3) in a terminal to confirm
  set(LIBS glfw3 X11 Xrandr Xinerama Xi Xxf86vm Xcursor GL dl libpthread-stubs0-dev libm17n-dev)
  set(INCLUDE_DIR "{CMAKE_CURRENT_SOURCE_DIR}/../.include")
  include_directories(${OPENGL_INCLUDE_DIRS} ${INCLUDE_DIR})
  target_link_libraries(run_linux ${LIBS} ${OPENGL_LIBRARIES})
endif()


