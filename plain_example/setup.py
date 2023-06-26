from setuptools import setup, Extension
from Cython.Distutils import build_ext
import numpy

extensions = [
    Extension("mod_sum", sources=["mod_sum.pyx"],
              extra_link_args=["mod_sum.o"]),  # Add the source file here
]

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules=extensions,
    include_dirs=[numpy.get_include()]
)

