include(FetchContent)
FetchContent_Declare(
  conan
  GIT_REPOSITORY https://github.com/conan-io/cmake-conan.git
  GIT_TAG        v0.16.1
)
FetchContent_GetProperties(conan)
if(NOT conan_POPULATED)
  FetchContent_Populate(conan)
endif()
include(${conan_SOURCE_DIR}/conan.cmake)

function(check_conan)
  find_program(CONAN_PATH conan)
  if(${CONAN_PATH} STREQUAL "CONAN_PATH-NOTFOUND")
    message(FATAL_ERROR "Conan is missing! You should install it, as the build system uses. Try to install it with 'pip install conan'")
  endif()
endfunction()

macro(setup_conan)
  check_conan()

  cmake_parse_arguments(setup_conan "" "FILE" "" ${ARGN})

  if(setup_conan_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "setup_conan was called with invalid parameters")
  endif()

  if(NOT setup_conan_FILE)
    message("File is not set for install, will use default")
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/conanfile.txt)
      set(setup_conan_FILE conanfile.txt)
    endif()
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/conanfile.py)
      set(setup_conan_FILE conanfile.py)
    endif()
    message("Default is " ${setup_conan_FILE})
  else()
    message("Installing from " ${setup_conan_FILE})
  endif()

  if(setup_conan_FILE)
    set(conan_buildtype ${CMAKE_BUILD_TYPE})
    if(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
      set(conan_buildtype "Release")
    endif()
    conan_cmake_run(CONANFILE ${setup_conan_FILE} BUILD missing BASIC_SETUP BUILD_TYPE ${conan_buildtype} CMAKE_TARGETS INSTALL_FOLDER ${CMAKE_CURRENT_BINARY_DIR})
    include(${CMAKE_CURRENT_BINARY_DIR}/conanbuildinfo.cmake)
  endif()

  unset(setup_conan)
  unset(setup_conan_UNPARSED_ARGUMENTS)
  unset(setup_conan_FILE)
  unset(conan_buildtype)
endmacro()
