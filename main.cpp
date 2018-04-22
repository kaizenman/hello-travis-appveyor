#ifdef __APPLE__
#   include <OpenGL/gl.h>
#   include <GLFW/glfw3.h>
#elif _WIN32
#   include <Windows.h>
#   include <GL/glew.h>
#   include <gl/glu.h>
#   include <GLFW/glfw3.h>
#   include <GL/freeglut.h>
#elif __linux__
#   include <GL/gl.h>
#   include <GLFW/glfw3.h>
#endif
#include <iostream>

void CrossPlatformHelloFunc()
{
#ifdef _WIN32
	//define something for Windows (32-bit and 64-bit, t  his part is common)
	std::cout << "Hello, Windows!" << std::endl;
#ifdef _WIN64
	//define something for Windows (64-bit only)
#else
	//define something for Windows (32-bit only)
#endif
#elif __linux__ 
	std::cout << "Hello, Linux!" << std::endl;
#elif __unix__
	// Unix
#elif defined(_POSIX_VERSION)
	// POSIX
#elif __APPLE__
#include "TargetConditionals.h"
#if TARGET_IPHONE_SIMULATOR
	// iOS Simulator
#elif TARGET_OS_IPHONE
	// iOS device
#elif TARGET_OS_MAC
    std::cout << "Hello, MacOSX" << std::endl;
	// Other kinds of Mac OS
#else
#   error "Unknown Apple platform"
#endif
#elif __ANDROID__
	// Android
#endif
}

int main(int argc, char ** argv) {
  CrossPlatformHelloFunc();
  if (!glfwInit()) {
      fprintf( stderr, "Failed to initialize GLFW\n");
      return -1;
    }

#ifdef __APPLE__
  /* We need to explicitly ask for a 3.2 context on OS X */
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
#endif
  glfwWindowHint(GLFW_CLIENT_API, GLFW_OPENGL_API);

#ifdef __linux__
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
#endif
  // Open a window and create its OpenGL context
  GLFWwindow* window;
  window = glfwCreateWindow(1024, 768, "Turtorial 1", NULL, NULL);
  if (window == NULL) {
    fprintf(stderr, "Failed to open GLFW window");
    glfwTerminate();
    return -1;
  }

  glfwMakeContextCurrent(window);

  while(glfwGetKey(window, GLFW_KEY_ESCAPE) != GLFW_PRESS && glfwWindowShouldClose(window) == 0)
  {
    /* Render here */
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); // clear the buffers

    /* Swap front and back buffers */
    glfwSwapBuffers(window);

    /* Poll for and process events */
    glfwPollEvents();
  }

  glfwTerminate();
  return 0;
}