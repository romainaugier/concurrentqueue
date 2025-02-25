include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(PROJECT_C_API "${PROJECT_NAME}_c_api")

file(GLOB_RECURSE SOURCES *.cpp)

add_library(${PROJECT_C_API} STATIC ${SOURCES})

target_include_directories(${PROJECT_C_API} PUBLIC
    $<INSTALL_INTERFACE:include>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
)

target_compile_definitions(${PROJECT_C_API} PUBLIC -DMOODYCAMEL_STATIC)
set_target_properties(${PROJECT_C_API} PROPERTIES DEBUG_POSTFIX "d")

if(UNIX)
    target_compile_options(${PROJECT_C_API} PUBLIC "-fPIC")
endif()

install(
    FILES concurrentqueue.h
    DESTINATION include/concurrentqueue
)

install(
    TARGETS ${PROJECT_C_API}
    EXPORT ${PROJECT_C_API}Targets
    ARCHIVE DESTINATION lib
    INCLUDES DESTINATION include
)

install(
    EXPORT ${PROJECT_C_API}Targets
    FILE ${PROJECT_C_API}Targets.cmake
    NAMESPACE concurrentqueue::
    DESTINATION cmake
)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_C_API}Config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_C_API}Config.cmake"
    PATH_VARS CMAKE_INSTALL_LIBDIR CMAKE_INSTALL_INCLUDEDIR
    INSTALL_DESTINATION lib/cmake/${PROJECT_C_API}
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_C_API}ConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY AnyNewerVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_C_API}Config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_C_API}ConfigVersion.cmake"
    DESTINATION cmake
)