import cffi
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import sys
import fileio

# Create CFFI interface
ffi = cffi.FFI()

# Load shared library
path = Path.home()
name = "libpygravmod3d"
if sys.platform.startswith("linux"):
    name = f"{name}.so"
elif sys.platform == "darwin":
    name = f"{name}.dylib"
else:
    raise ImportError(f"Your OS is not supported: {sys.platform}")

name = "opt/elaborated_example/lib/" + name
lib = ffi.dlopen(str(path / name))

# Define CFFI types
ffi.cdef("""
    void c_funcpdf(int*, int*, int*, int*, double*, double*, double*, double*, double*,
                   double*, double*, double*, double*, double*, const char*);
""")


if __name__ == "__main__":
    x, y, z = fileio.read_xy_or_xyz("./data/synthetic_xyz.dat")
    xrec, yrec = fileio.read_xy_or_xyz("./data/grid_xy.dat")[0:-1]
    values = fileio.read_txt_file("./data/input.dat")
    f = np.zeros_like(xrec)

    # The input [byte] string - which we leave unchanged.
    in_ptr = ffi.new("char[]", b'inner')
    in_ptr = ffi.NULL

    # Now we should process the data somehow...
    lib.c_funcpdf(
        ffi.new("int*", 1),
        ffi.new("int*", len(xrec)),
        ffi.new("int*", len(x)),
        ffi.new("int*", len(xrec)),
        ffi.new("double*", values[-4]),
        ffi.new("double*", values[-3]),
        ffi.new("double*", values[-2]),
        ffi.new("double*", values[-1]),
        ffi.cast("double*", z.ctypes.data),
        ffi.cast("double*", x.ctypes.data),
        ffi.cast("double*", y.ctypes.data),
        ffi.cast("double*", xrec.ctypes.data),
        ffi.cast("double*", yrec.ctypes.data),
        ffi.cast("double*", f.ctypes.data),
        in_ptr
    )

    # Generate grid data
    x = np.unique(xrec)
    y = np.unique(yrec)
    X, Y = np.meshgrid(y, x)

    grid = np.reshape(f, X.shape)
    plt.pcolormesh(Y, X, grid, shading='auto')
    plt.gca().set_aspect("equal")
    plt.colorbar()
    plt.show()

