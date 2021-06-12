setup_conan()

add_executable(hello
  main.cpp
)
target_link_libraries(hello
  PRIVATE project_options
  PRIVATE project_warnings
  PRIVATE libhello
  PRIVATE CONAN_PKG::fmt
)

install(TARGETS hello DESTINATION ${CMAKE_SOURCE_DIR}/target)
