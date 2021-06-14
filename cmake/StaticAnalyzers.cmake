macro(setup_static_analyzers)
  cmake_parse_arguments(setup_static_analyzers "OFF;CPPCHECK;CLANG_TIDY" "" "" ${ARGN})
  if(setup_static_analyzers_OFF AND (
      setup_static_analyzers_CPPCHECK OR
      setup_static_analyzers_CLANG_TIDY
  ))
    message(FATAL_ERROR "You should use either OFF or a set of checkers when setting up static analyzers")
  endif()
  if(setup_static_analyzers_UNPARSED_ARGUMENTS)
    message(FATAL_ERROR "setup_static_analyzers was called with invalid parameters: " ${setup_static_analyzers_UNPARSED_ARGUMENTS}
    ". Valid arguments are OFF, CPPCHECK, CLANG_TIDY")
  endif()

  if(STATIC_ANALYZERS AND NOT ${setup_static_analyzers_OFF})
    if(${setup_static_analyzers_CPPCHECK} OR NOT ${ARGC})
      find_program(CPPCHECK cppcheck)
      if(${CPPCHECK} STREQUAL "CPPCHECK-NOTFOUND")
        message("Cannot find CPPCHECK program. CPPCHECK is not configured.")
      else()
        set(CMAKE_CXX_CPPCHECK
          ${CPPCHECK}
          --suppress=missingIncludeSystem
          --enable=warning,style,performance,portability,information
          --inconclusive
          --std=c++17
          --quiet
          --inline-suppr
        )
        message("CPPCHECK is on")
      endif()
    endif()
    if(${setup_static_analyzers_CLANG_TIDY} OR NOT ${ARGC})
    find_program(CLANGTIDY clang-tidy)
      if(${CLANGTIDY} STREQUAL "CLANGTIDY-NOTFOUND")
        message("Cannot find CLANG_TIDY program. CLANG_TIDY is not configured.")
      else()
        if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
          set(CMAKE_CXX_CLANG_TIDY ${CLANGTIDY})
        else()
          set(CMAKE_CXX_CLANG_TIDY "${CLANGTIDY};--extra-arg=-Wno-error=unknown-warning-option")
        endif()
        message("CLANG_TIDY is on")
      endif()
    endif()
  else()
    unset(CMAKE_CXX_CPPCHECK)
    unset(CMAKE_CXX_CLANG_TIDY)
  endif()

  unset(setup_static_analyzers)
  unset(setup_static_analyzers_UNPARSED_ARGUMENTS)
  unset(setup_static_analyzers_OFF)
  unset(setup_static_analyzers_CPPCHECK)
  unset(setup_static_analyzers_CLANG_TIDY)
endmacro()