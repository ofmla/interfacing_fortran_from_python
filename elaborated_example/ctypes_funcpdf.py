from ctypes import CDLL, byref, c_double, c_int, c_char_p, POINTER
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import fileio
import sys

# Load shared library
path = Path.home()
name = "libpygravmod3d"
if sys.platform.startswith("linux"):
    name = f"{name}.so"
elif sys.platform == "darwin":
    name = f"{name}.dylib"
else:
    raise ImportError(f"Your OS is not supported: {sys.platform}")

name = "opt/elaborated_example/lib/"+name
lib = CDLL(str(path / name))

    
if __name__ == "__main__":
    x, y, z = fileio.read_xy_or_xyz("./data/synthetic_xyz.dat")
    xrec, yrec = fileio.read_xy_or_xyz("./data/grid_xy.dat")[0:-1]
    values = fileio.read_txt_file("./data/input.dat")
    f = np.zeros_like(xrec)
    
    lib.c_funcpdf.argtypes = [
        POINTER(c_int),
        POINTER(c_int),
        POINTER(c_int),
        POINTER(c_int),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        POINTER(c_double),
        c_char_p,
    ]
    lib.c_funcpdf.restype = None
    
    # The input [byte] string - which we leave unchanged.
    in_ptr = c_char_p(b'inner')
    in_ptr = None
    
    # Now we should process the data somehow...
    lib.c_funcpdf(byref(c_int(1)),
         byref(c_int(len(xrec))),
         byref(c_int(len(x))),
         byref(c_int(len(xrec))),
         byref(c_double(values[-4])),
         byref(c_double(values[-3])),
         byref(c_double(values[-2])),
         byref(c_double(values[-1])),
         z.ctypes.data_as(POINTER(c_double)),
         x.ctypes.data_as(POINTER(c_double)),
         y.ctypes.data_as(POINTER(c_double)),
         xrec.ctypes.data_as(POINTER(c_double)),
         yrec.ctypes.data_as(POINTER(c_double)),
         f.ctypes.data_as(POINTER(c_double)),
         in_ptr)
         
    # Generate grid data
    x = np.unique(xrec)
    y = np.unique(yrec)
    X, Y = np.meshgrid(y, x)

    grid = np.reshape(f, X.shape,)#order='F')
    plt.pcolormesh(Y,X,grid, shading='auto')
    plt.gca().set_aspect("equal")
    plt.colorbar()
    plt.show()

