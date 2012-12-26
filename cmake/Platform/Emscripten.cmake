# This file is a 'toolchain description file' for CMake.
# It teaches CMake about the Emscripten compiler, so that CMake can generate Unix Makefiles
# from CMakeLists.txt that invoke emcc.

# To use this toolchain file with CMake, invoke CMake with the following command line parameters
# cmake -DEMSCRIPTEN=1 
#       -DCMAKE_TOOLCHAIN_FILE=<EmscriptenRoot>/cmake/Platform/Emscripten.cmake
#       -DCMAKE_MODULE_PATH=<EmscriptenRoot>/cmake
#       -DCMAKE_BUILD_TYPE=<Debug|RelWithDebInfo|Release|MinSizeRel>
#       -G "Unix Makefiles"
#       <path/to/CMakeLists.txt> # Note, pass in here ONLY the path to the file, not the filename 'CMakeLists.txt' itself.

# After that, build the generated Makefile with the command 'make'. On Windows, you may download and use 'mingw32-make' instead.

# the name of the target operating system
set(CMAKE_SYSTEM_NAME Emscripten)
set(CMAKE_SYSTEM_VERSION 1)

if ("${EMSCRIPTEN_ROOT_PATH}" STREQUAL "")
	set(CMAKE_FIND_ROOT_PATH "$ENV{EMSCRIPTEN}")
else()
	set(CMAKE_FIND_ROOT_PATH "${EMSCRIPTEN_ROOT_PATH}")
endif()

# Specify the compilers to use for C and C++
if ("${CMAKE_C_COMPILER}" STREQUAL "")
	set(CMAKE_C_COMPILER "emcc.exe")
	set(CMAKE_CXX_COMPILER "em++.exe")
	set(CMAKE_AR "emar.exe")
	set(CMAKE_RANLIB "emranlib.exe")
endif()

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Specify the program to use when building static libraries. Force Emscripten-related command line options to clang.
set(CMAKE_CXX_ARCHIVE_CREATE "${CMAKE_CXX_COMPILER} -o <TARGET> -emit-llvm <LINK_FLAGS> <OBJECTS>")
set(CMAKE_C_ARCHIVE_CREATE "${CMAKE_C_COMPILER} -o <TARGET> -emit-llvm <LINK_FLAGS> <OBJECTS>")

# Set a global EMSCRIPTEN variable that can be used in client CMakeLists.txt to detect when building using Emscripten.
# There seems to be some kind of bug with CMake, so you might need to define this manually on the command line with "-DEMSCRIPTEN=1".
set(EMSCRIPTEN 1)

# Set initial flags
set(CMAKE_C_FLAGS_INIT                "-Wall")
set(CMAKE_C_FLAGS_DEBUG_INIT          "-g")
set(CMAKE_C_FLAGS_MINSIZEREL_INIT     "-O2 -DNDEBUG")
set(CMAKE_C_FLAGS_RELEASE_INIT        "-O2 -DNDEBUG")
set(CMAKE_C_FLAGS_RELWITHDEBINFO_INIT "-O2 -g")

set(CMAKE_CXX_FLAGS_INIT                "-Wall")
set(CMAKE_CXX_FLAGS_DEBUG_INIT          "-g")
set(CMAKE_CXX_FLAGS_MINSIZEREL_INIT     "-O2 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE_INIT        "-O2 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO_INIT "-O2 -g")
