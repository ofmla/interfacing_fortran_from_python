# interfacing_fortran_from_python
Tutorial -- Interfacing Fortran and Python: Using cffi, ctypes and cython


In this tutorial you will get a basic knowledge on different alternatives of calling Fortran code from Python. The tutorial focuses on the explicit C interface route, that is,
coding explicit C interface in Fortran and calling that with Python libraries like ctypes, cffi, etc. Although there are several automatic wrapper generation tools available (see, for instance, [here](https://fortranwiki.org/fortran/show/Python)), they wont be covered by the course.

Opting for the explicit C interface route, the first thing to do is write a wrapper to your Fortran function(s) or subroutine(s) using *iso_c_binding*. Then build your own shared library so that it can be used by Python. 

## What do you need

To complete the steps outlined in this tutorial, you need a Linux system with Fortran development related packages and Python installed.

The repository contains two folders, one with a simple example and the other with a more complicated one.

## Plain example

In the first case, it is used the Fortran SUM intrinsic function to compute the sum of columns in a 2-d array, since it is something very simple, the shared library building process can be managed with simple commands. Examples of compilation using several compilers are provided below:

+ Linux + nvfortran 23.5-0
```
nvfortran -O3 -march=native -fpic -c mod_sum.f90
nvfortran -shared -o mod_sum.so mod_sum.o
```

+ Linux + ifort
```
ifort -O3 -march=native -fpic -c mod_sum.f90
ifort -shared -o mod_sum.so mod_sum.o
```

+ Linux + ifx
```
ifx -O3 -march=native -fpic -c mod_sum.f90
ifx -shared -o mod_sum.so mod_sum.o
```

The python binding of the Fortran subroutine, using the [pythom module ctypes](https://docs.python.org/3/library/ctypes.html), is define in `ctypes_sum.py`:
```
python ctypes_sum.py
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

The python binding of the Fortran *funcpdf* subroutine, using the [pythom module ctypes](https://docs.python.org/3/library/ctypes.html), is define in `ctypes_funcpdf.py`:
```
python ctypes_funcpdf.py
```