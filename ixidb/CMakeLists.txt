cmake_minimum_required(VERSION 3.19)

project("ixidb" LANGUAGES CXX)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_C_COMPILER /usr/bin/gcc-14)
set(CMAKE_CXX_COMPILER /usr/bin/g++-14)


include(CTest)

add_subdirectory("src")
add_subdirectory("tools")

find_package(PkgConfig REQUIRED)

if(BUILD_TESTING)
	find_package(Catch2 CONFIG REQUIRED)
	add_subdirectory("test")
endif()

