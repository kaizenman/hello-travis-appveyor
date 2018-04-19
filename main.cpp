#include <iostream>

void CrossPlatformHelloFunc()
{
#ifdef _WIN32
	//define something for Windows (32-bit and 64-bit, this part is common)
	std::cout << "Hello, Windows!" << std::endl;
	system("pause");
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
    std::cout << "Hello, MacOsX" << std::endl;
	// Other kinds of Mac OS
#else
#   error "Unknown Apple platform"
#endif
#elif __ANDROID__
	// Android
#endif
}

void function()
{

}

int main() {
	CrossPlatformHelloFunc();
}
