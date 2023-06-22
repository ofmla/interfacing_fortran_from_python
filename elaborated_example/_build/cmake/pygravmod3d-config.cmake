
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was pygravmod3d-config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

# Global config options
# Set any variable here, you want to communicate to packages using yours
#set(pygravmod3d_WITH_OMP )

include(CMakeFindDependencyMacro)

# Just in case the project provides / installs own FindPackage modules
if(EXISTS ${CMAKE_CURRENT_LIST_DIR}/Modules)
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/Modules)
endif()

if(NOT TARGET pygravmod3d::pygravmod3d)
    include("${CMAKE_CURRENT_LIST_DIR}/pygravmod3d-targets.cmake")
endif()
