#ifdef __APPLE__
#   include <OpenGL/gl.h>
#   include <OpenGL/glu.h>
#   include <GLUT/glut.h>
#else
#   include <Windows.h>
#   include <GL/glew.h>
#   include <gl/glu.h>
#   include <GL/freeglut.h>
#endif
#include <iostream>

void CrossPlatformHelloFunc()
{
#ifdef _WIN32
	//define something for Windows (32-bit and 64-bit, this part is common)
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

void init();
void display();
void reshape(int w, int h);
void keyboard(unsigned char key, int x, int y);

int main(int argc, char ** argv) {
  CrossPlatformHelloFunc();
  glutInit(&argc, argv);
  glutInitWindowSize(512, 512);
#ifdef __APPLE_
  glutInitDisplayMOde(GLUT_3_2_CORE_PROFILE | GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
#else
  glutInitContextVersion(3, 2);
  glutInitContextProfile(GLUT_CORE_PROFILE);
  glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_DEPTH);
#endif
  glutCreateWindow("OpenGL Template");
  glewExperimental = GL_TRUE;
  
  glewInit();

  init();

  // Register Callback functions
  glutDisplayFunc(display);
  glutKeyboardFunc(keyboard);
  glutReshapeFunc(reshape);

  glutMainLoop();

  return 0;
}

void init()
{

}

void reshape(int w, int h)
{

}

void display()
{
}

void keyboard(unsigned char key, int x, int y)
{
  switch (key) {
  case 033: // Escape key
  case 'q':
  case 'Q':
    exit(EXIT_SUCCESS);
    break;
  }
}