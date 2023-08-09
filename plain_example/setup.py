from setuptools import setup, Extension
import numpy

extensions = [
    Extension("mod_sum", sources=["mod_sum.pyx"],
              extra_link_args=["mod_sum.o"],
              include_dirs=[numpy.get_include()],
              define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_7_API_VERSION")])
]

for e in extensions:
    e.cython_directives ={'language_level': "3"}

setup(
    ext_modules=extensions,
)
