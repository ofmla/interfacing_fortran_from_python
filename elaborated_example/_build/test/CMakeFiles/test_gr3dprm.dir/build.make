# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /Users/oscarmojica/miniforge3/envs/devito/lib/python3.10/site-packages/cmake/data/CMake.app/Contents/bin/cmake

# The command to remove a file.
RM = /Users/oscarmojica/miniforge3/envs/devito/lib/python3.10/site-packages/cmake/data/CMake.app/Contents/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build

# Include any dependencies generated for this target.
include test/CMakeFiles/test_gr3dprm.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include test/CMakeFiles/test_gr3dprm.dir/compiler_depend.make

# Include the progress variables for this target.
include test/CMakeFiles/test_gr3dprm.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/test_gr3dprm.dir/flags.make

test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o: test/CMakeFiles/test_gr3dprm.dir/flags.make
test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o: ../test/test_gr3dprm.f90
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building Fortran object test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o"
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test && /opt/homebrew/bin/gfortran $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -c /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/test/test_gr3dprm.f90 -o CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o

test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing Fortran source to CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.i"
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test && /opt/homebrew/bin/gfortran $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -E /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/test/test_gr3dprm.f90 > CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.i

test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling Fortran source to assembly CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.s"
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test && /opt/homebrew/bin/gfortran $(Fortran_DEFINES) $(Fortran_INCLUDES) $(Fortran_FLAGS) -S /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/test/test_gr3dprm.f90 -o CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.s

# Object files for target test_gr3dprm
test_gr3dprm_OBJECTS = \
"CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o"

# External object files for target test_gr3dprm
test_gr3dprm_EXTERNAL_OBJECTS =

test/test_gr3dprm: test/CMakeFiles/test_gr3dprm.dir/test_gr3dprm.f90.o
test/test_gr3dprm: test/CMakeFiles/test_gr3dprm.dir/build.make
test/test_gr3dprm: src/libpygravmod3d.dylib
test/test_gr3dprm: test/CMakeFiles/test_gr3dprm.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking Fortran executable test_gr3dprm"
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/test_gr3dprm.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/test_gr3dprm.dir/build: test/test_gr3dprm
.PHONY : test/CMakeFiles/test_gr3dprm.dir/build

test/CMakeFiles/test_gr3dprm.dir/clean:
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test && $(CMAKE_COMMAND) -P CMakeFiles/test_gr3dprm.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/test_gr3dprm.dir/clean

test/CMakeFiles/test_gr3dprm.dir/depend:
	cd /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/test /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test /Users/oscarmojica/Desktop/interfacing_fortran_from_python/elaborate_example/_build/test/CMakeFiles/test_gr3dprm.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/test_gr3dprm.dir/depend
