# Collect source files for library
set(f90-sources
    grav_kinds.f90
    gr3dmod.f90
)


# Build library
add_library(pygravmod3d ${f90-sources})
set_target_properties(pygravmod3d PROPERTIES OUTPUT_NAME pygravmod3d)
if(WITH_OPENMP)
    find_package(OpenMP)
    if (OPENMP_FOUND)
        if (${CMAKE_BUILD_TYPE} MATCHES "Debug")
            message(FATAL_ERROR "Cant use OpenMP for the Debug build. Please review the CMake options")
        endif()
        add_library(pygravmod3d_openmp ${f90-sources})
        set_target_properties(pygravmod3d_openmp PROPERTIES OUTPUT_NAME pygravmod3d-openmp)
        target_compile_definitions(pygravmod3d_openmp PRIVATE WITH_OPENMP)
        target_compile_options(pygravmod3d_openmp PUBLIC "${OpenMP_Fortran_FLAGS}")
        target_link_options(pygravmod3d_openmp PUBLIC "${OpenMP_Fortran_FLAGS}")
        target_link_libraries(pygravmod3d_openmp pygravmod3d)
    endif()
endif()

# Store generated mod-files in a separate folder
set(moddir "${CMAKE_CURRENT_BINARY_DIR}/fmod")
set_target_properties(pygravmod3d PROPERTIES
    Fortran_MODULE_DIRECTORY "${moddir}"
)
if(WITH_OPENMP)
    set_target_properties(
        pygravmod3d_openmp
        PROPERTIES Fortran_MODULE_DIRECTORY "${moddir}"
    )
endif()

# Add mod-file directory to include search path for targets depending on the library
target_include_directories(pygravmod3d PUBLIC
    $<BUILD_INTERFACE:${moddir}>
    $<INSTALL_INTERFACE:${INSTALL_MODULEDIR}>
)
if(WITH_OPENMP)
    target_include_directories(
        pygravmod3d_openmp PUBLIC
        $<BUILD_INTERFACE:${moddir}>
        $<INSTALL_INTERFACE:${INSTALL_MODULEDIR}>
    )
endif()

# Install the library
install(TARGETS pygravmod3d
    EXPORT pygravmod3d-targets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_INCLUDEDIR}"
)

if(WITH_OPENMP)
    install(
        TARGETS pygravmod3d_openmp
        EXPORT pygravmod3d-targets
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
        PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_INCLUDEDIR}"
    )
endif()

# Install the folder with the modfiles (needed by projects using the library)
install(DIRECTORY "${moddir}/" DESTINATION "${INSTALL_MODULEDIR}")
