from setuptools import setup, Extension
from Cython.Distutils import build_ext
import numpy

extensions = [
    Extension("c_funcpdf", sources=["c_funcpdf.pyx"],
              extra_link_args=["gr3dmod.o"]),  # Add the source file here
]

setup(
    cmdclass = {'build_ext': build_ext},
    ext_modules=extensions,
    include_dirs=[numpy.get_include()]
)

