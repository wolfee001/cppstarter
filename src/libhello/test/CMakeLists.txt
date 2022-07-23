setup_static_analyzers(OFF)

setup_conan()

add_executable(libhello_test
    libhello_test.cpp
    test_greeter.cpp
)

target_link_libraries(libhello_test
    PRIVATE project_options
    PRIVATE project_warnings
    PRIVATE libhello
    PRIVATE CONAN_PKG::gtest
)

include(GoogleTest)
gtest_discover_tests(libhello_test)

add_test(NAME libhello_test COMMAND libhello_test)

install(TARGETS libhello_test RUNTIME DESTINATION ${CMAKE_SOURCE_DIR}/target/tests)
