from setuptools import setup, Extension
import numpy

extensions = [
    Extension("c_funcpdf", sources=["c_funcpdf.pyx"],
              extra_link_args=["gr3dmod.o"],
              include_dirs=[numpy.get_include()],
              define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")])
]

for e in extensions:
    e.cython_directives ={'language_level': "3"}

setup(
    ext_modules=extensions,
)
