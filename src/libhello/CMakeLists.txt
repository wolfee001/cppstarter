setup_conan(FILE conanfile.txt)

add_library(libhello
  implementation/hello.cpp
)
target_link_libraries(libhello
  PRIVATE project_options
  PRIVATE project_warnings
  PRIVATE CONAN_PKG::fmt
)
target_include_directories(libhello INTERFACE interface)

add_subdirectory(bindings)