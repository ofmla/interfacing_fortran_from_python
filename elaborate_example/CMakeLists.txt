cmake_minimum_required(VERSION 3.16)

# Set basic project properties
project(pygravmod3d
    VERSION 0.1
    DESCRIPTION "A wonderful Fortran project built with CMake"
    LANGUAGES Fortran
)

# Set up install directories
include(GNUInstallDirs)
set(INSTALL_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}/pygravmod3d")
set(INSTALL_MODULEDIR "${INSTALL_INCLUDEDIR}/fmod")

# Include project specific CMake functions
include(cmake/pygravmod3d.cmake)

# Include user customizable config settings
include(config.cmake)

# Configure the build type (see cmake/pygravmod3d.cmake)
configure_build_type()

# Configure the compiler flags (see cmake/pygravmod3d.cmake)
configure_compiler_flags()

# Build library
add_subdirectory(src)

# Build applications
add_subdirectory(app)

# Build tests
enable_testing()
add_subdirectory(test)


#
# Install package config find, so that other CMake project can find this project
#
include(CMakePackageConfigHelpers)

# If project uses customized finders, they should be installed with it
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/pygravmod3d
)
endif()

# Install project, add namespace
install(
    EXPORT pygravmod3d-targets
    FILE "pygravmod3d-targets.cmake"
    NAMESPACE "pygravmod3d::"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/pygravmod3d"
)

# Create and install CMake package config file
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/pygravmod3d-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/pygravmod3d-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/pygravmod3d"
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/pygravmod3d-config-version.cmake"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY SameMajorVersion
)
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/cmake/pygravmod3d-config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/pygravmod3d-config-version.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/pygravmod3d"
)
