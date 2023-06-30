# interfacing_fortran_from_python
Tutorial -- Interfacing Fortran and Python: Using cffi, ctypes and cython


In this tutorial you will get a basic knowledge on different alternatives of calling Fortran code from Python. The tutorial focuses on the explicit C interface route, that is,
coding explicit C interface in Fortran and calling that with Python libraries like ctypes, cffi, etc. Although there are several automatic wrapper generation tools available (see, for instance, [here](https://fortranwiki.org/fortran/show/Python)), they wont be covered by the course.

Opting for the explicit C interface route, the first thing to do is write a wrapper to your Fortran function(s) or subroutine(s) using *iso_c_binding*. Then build your own shared library so that it can be used by Python. 

## What do you need

To complete the steps outlined in this tutorial, you need a Linux system with Fortran/C development related packages and Python installed. On `Debian` based systems you can install the required packages using:
```
sudo apt-get update
# Install required dependencies
sudo apt-get install build-essential \
                     cmake \
                     gfortran \
                     gcc \
                     g++

# Install optional dependencies
sudo apt-get install python3 \
                     python3-dev \
                     cython3
```

The repository contains two folders, one with a simple example and the other with a more complicated one.

## Plain example

In the first case, it is used the Fortran SUM intrinsic function to compute the sum of columns in a 2-d array, since it is something very simple, the shared library building process can be managed with simple commands. Examples of compilation using several compilers are provided below:

+ Linux + nvfortran 23.5-0
```
nvfortran -O3 -march=native -fpic -c mod_sum_c.f90 -o mod_sum.o
nvfortran -shared -o mod_sum.so mod_sum.o
```

+ Linux + ifort
```
ifort -O3 -march=native -fpic -c mod_sum_c.f90 -o mod_sum.o
ifort -shared -o mod_sum.so mod_sum.o
```

+ Linux + ifx
```
ifx -O3 -march=native -fpic -c mod_sum_c.f90 -o mod_sum.o
ifx -shared -o mod_sum.so mod_sum.o
```

The examples of calling the Fortran subroutine using the [pythom module ctypes](https://docs.python.org/3/library/ctypes.html), [CFFI](https://cffi.readthedocs.io/en/latest/) and [cython](https://cython.org) are defined in `ctypes_plain.py`, `cffi_plain.py` and `cython_plain.py`, respectively. In the last case, you have to compile the fortran module first (as shown in the first command line of the previous examples), and then run the following command before you can use the corresponding module
```
CC=icx python setup.py build_ext --inplace
```

Note you need to set `CC` with the proper compiler. This command is used to build a Python extension. The `build_ext` command compiles the C source files of the extension module and generates the corresponding shared library file. By using the `--inplace` option, the shared library file is placed in the current directory alongside the Python source files, making it accessible for importing and using in Python scripts without the need for installation.

By running any of these scripts you will get the same result, e.g.:
```
python ctypes_plain.py
[2. 4. 6.]
```

## Elaborated example

For the complex case I chose to use a [library](https://github.com/ofmla/gravmod3d) that I created not long ago to compute the gravitational attraction caused by a rectangular prism with density that varies as a function of depth following a parabolic function (I used this code for my doctoral work :books:). The library can be built, tested and installed using the usual [CMake](https://cmake.org/) workflow:
```
  mkdir _build
  cd _build
  FC=gfortran cmake -DCMAKE_INSTALL_PREFIX=$HOME/opt/elaborated_example ..
  make
  ctest
  make install
```
If you have ninja available, it can be used instead of make:
```
  mkdir _build
  cd _build
  FC=gfortran cmake -GNinja -DCMAKE_INSTALL_PREFIX=$HOME/opt/elaborated_example ..
  ninja
  ctest
  ninja install
```
The installation folder is customized via the ``-DCMAKE_INSTALL_PREFIX`` option.
Adjust the value of the `FC` environment variable according to the compiler
you use.
Using ``-DWITH_OPENMP:BOOL=ON`` will build two versions of the library, a serial version and another with support for shared memory parallelization using the [OpenMP](https://en.wikipedia.org/wiki/OpenMP) threading standard.

As in the simple case, three examples are available: `ctypes_funcpdf.py`, `cffi_funcpdf.py` and `cython_funcpdf.py`. For using [cython](https://cython.org) we follow the same steps as before: 

+ Compile the source files (files in `src` folder) to object files. The sequence of commands looks like this:
```
gfortran -O3 -march=native -fpic -c grav_kinds.mod.f90 -o grav_kinds.o
gfortran -O3 -march=native -fpic -c gr3dmod.f90 -o gr3dmod.o
```
+ Define function to be imported from C and the wrapper for calling it from Python (`c_funcpdf.pyx`)
+ Use distutils to compile shared library for Python (`python setup.py build_ext --inplace`)

Once the shared library is generated, we can import the corresponding Python module into our Python code (`cython_funcpdf.py`) and use the functions or classes defined in the extension module, which are implemented in C.
