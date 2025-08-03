cmake_minimum_required(VERSION 3.19)

# Enable vcpkg before project() command
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake"
    CACHE STRING "Vcpkg toolchain file")

project(ixidb VERSION 0.1.0 LANGUAGES CXX)

# Add code coverage option
option(CODE_COVERAGE "Enable coverage reporting" OFF)

# Require C++23
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Export compilation database for tools
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Configure coverage
if(CODE_COVERAGE AND CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
    message(STATUS "Enabling coverage reporting with gcov")
    add_compile_options(-O0 -g --coverage)
    add_link_options(--coverage)
endif()

# Add dependencies
find_package(PkgConfig REQUIRED)

# Enable testing
include(CTest)
if(BUILD_TESTING)
    find_package(Catch2 CONFIG REQUIRED)
endif()

# Set output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Add subdirectories
add_subdirectory(lib)    # Library code
add_subdirectory(src)    # Main executable
add_subdirectory(tools)  # Additional tools
if(BUILD_TESTING)
    add_subdirectory(tests)
endif()

# Installation rules
include(GNUInstallDirs)
install(DIRECTORY include/ 
        DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
        FILES_MATCHING PATTERN "*.hpp")

# Create symlink for compile commands (useful for clangd)
execute_process(
    COMMAND ${CMAKE_COMMAND} -E create_symlink 
    ${CMAKE_BINARY_DIR}/compile_commands.json
    ${CMAKE_SOURCE_DIR}/compile_commands.json
)
