function(make_nodejs_binding libs_to_link install_destination)
  set(target_name "addon")
  file(GLOB_RECURSE wrapper_sources "wrapper/*.cpp")
  set(BUILD_DEPENDENCY_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build_dependencies")

  file(MAKE_DIRECTORY ${BUILD_DEPENDENCY_DIR})
  execute_process(
    COMMAND npm install node-addon-api cmake-js
    WORKING_DIRECTORY ${BUILD_DEPENDENCY_DIR}
  )
  execute_process(
    COMMAND node -p "require('node-addon-api').include"
    WORKING_DIRECTORY ${BUILD_DEPENDENCY_DIR}
    OUTPUT_VARIABLE NODE_ADDON_API_DIR
  )
  execute_process(
    COMMAND npx cmake-js print-configure
    WORKING_DIRECTORY ${BUILD_DEPENDENCY_DIR}
    OUTPUT_VARIABLE CMAKE_JS_CONFIGURE
  )
  string(REGEX REPLACE ".*'-DCMAKE_JS_INC=([^']+).*" "\\1" CMAKE_JS_INC ${CMAKE_JS_CONFIGURE})
  string(REPLACE "\n" "" NODE_ADDON_API_DIR ${NODE_ADDON_API_DIR})
  string(REPLACE "\"" "" NODE_ADDON_API_DIR ${NODE_ADDON_API_DIR})

  add_library(${target_name} SHARED
    ${wrapper_sources}
  )

  target_link_libraries(${target_name}
    PRIVATE ${libs_to_link}
  )

  set_target_properties(${target_name} PROPERTIES
    PREFIX ""
    SUFFIX ".node"
    POSITION_INDEPENDENT_CODE ON
  )
  if(APPLE)
    set_target_properties(${target_name} PROPERTIES
      LINK_FLAGS "-undefined dynamic_lookup -bind_at_load"
    )
    target_compile_definitions(${target_name}
      PRIVATE "_DARWIN_USE_64_BIT_INODE=1"
    )
  else()
    set_target_properties(${target_name} PROPERTIES
      LINK_FLAGS "-z now"
    )
  endif()

  target_include_directories(${target_name}
    PRIVATE ${NODE_ADDON_API_DIR}
    PRIVATE ${CMAKE_JS_INC}
  )

  target_compile_definitions(${target_name}
    PRIVATE "NAPI_VERSION=3"
    PRIVATE "BUILDING_NODE_EXTENSION"
    PRIVATE "_LARGEFILE_SOURCE"
    PRIVATE "_FILE_OFFSET_BITS=64"
  )

  set(addon_dir ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  if(NOT addon_dir)
    set(addon_dir ${CMAKE_CURRENT_BINARY_DIR})
  endif()

  add_custom_command(TARGET ${target_name}
    POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E rm -f addon.node *.tgz
    COMMAND ${CMAKE_COMMAND} -E copy ${addon_dir}/${target_name}.node ${CMAKE_CURRENT_SOURCE_DIR}/package/${target_name}.node
    COMMAND npm pack
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/package
  )

  install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/package/ DESTINATION ${install_destination} FILES_MATCHING PATTERN "*.tgz")

endfunction()
