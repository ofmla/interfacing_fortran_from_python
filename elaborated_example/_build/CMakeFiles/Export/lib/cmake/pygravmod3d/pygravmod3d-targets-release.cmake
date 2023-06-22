#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "pygravmod3d::pygravmod3d" for configuration "Release"
set_property(TARGET pygravmod3d::pygravmod3d APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(pygravmod3d::pygravmod3d PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libpygravmod3d.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libpygravmod3d.dylib"
  )

list(APPEND _IMPORT_CHECK_TARGETS pygravmod3d::pygravmod3d )
list(APPEND _IMPORT_CHECK_FILES_FOR_pygravmod3d::pygravmod3d "${_IMPORT_PREFIX}/lib/libpygravmod3d.dylib" )

# Import target "pygravmod3d::pygravmod3d_openmp" for configuration "Release"
set_property(TARGET pygravmod3d::pygravmod3d_openmp APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(pygravmod3d::pygravmod3d_openmp PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libpygravmod3d-openmp.dylib"
  IMPORTED_SONAME_RELEASE "@rpath/libpygravmod3d-openmp.dylib"
  )

list(APPEND _IMPORT_CHECK_TARGETS pygravmod3d::pygravmod3d_openmp )
list(APPEND _IMPORT_CHECK_FILES_FOR_pygravmod3d::pygravmod3d_openmp "${_IMPORT_PREFIX}/lib/libpygravmod3d-openmp.dylib" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
