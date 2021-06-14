cmake_minimum_required(VERSION 3.18)

project(helloproject)

#--------------
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

include(cmake/CompilerWarnings.cmake)
add_library(project_warnings INTERFACE)
set_project_warnings(project_warnings)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

include(cmake/Conan.cmake)

include(cmake/StaticAnalyzers.cmake)
setup_static_analyzers()
#--------------

add_subdirectory(src)
