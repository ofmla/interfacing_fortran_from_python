import cffi
import numpy as np
import matplotlib.pyplot as plt
from pathlib import Path
import sys

# Create CFFI interface
ffi = cffi.FFI()

# Load shared library
path = Path.home()
name = "libpygravmod3d-openmp"
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
    void funcpdf(int*, int*, int*, int*, double*, double*, double*, double*, double*,
                 double*, double*, double*, double*, double*, const char*);
""")

def read_xy_or_xyz(filename):
    """Read XY or XYZ file and return x, y, z coordinates.

    Args:
        filename: Name of the XY or XYZ data file.

    Returns:
        x_coords: NumPy array containing the x-coordinates.
        y_coords: NumPy array containing the y-coordinates.
        z_coords: NumPy array containing the z-coordinates (None for XY files).
    """
    coords = []
    with open(filename, 'r') as f:
        for line in f:
            try:
                parts = line.split()
                x = float(parts[0])
                y = float(parts[1])
                z = float(parts[2]) if len(parts) == 3 else None
            except (TypeError, IOError, IndexError, ValueError):
                raise ValueError('Incorrect file format')
            coords.append([x, y, z])

    if not coords:
        raise ValueError("File is empty")

    coordinates = np.array(coords, dtype=np.float64)
    x_coords = np.copy(coordinates[:, 0])
    y_coords = np.copy(coordinates[:, 1])
    z_coords = np.copy(coordinates[:, 2])

    return x_coords, y_coords, z_coords


def read_txt_file(filename):
    """
    Read a text file containing numerical values and return a list of the values.

    Args:
        filename (str): The name of the text file to be read.

    Returns:
        list: A list of numerical values extracted from the file.
    """
    values = []

    with open(filename, 'r') as f:
        for line in f:
            try:
                value = float(line.strip())
                values.append(value)
            except ValueError:
                raise ValueError('Incorrect file format')

    return values


if __name__ == "__main__":
    x, y, z = read_xy_or_xyz("./data/synthetic_xyz.dat")
    xrec, yrec = read_xy_or_xyz("./data/grid_xy.dat")[0:-1]
    values = read_txt_file("./data/input.dat")
    f = np.zeros_like(xrec)

    # The input [byte] string - which we leave unchanged.
    in_ptr = ffi.new("char[]", b'inner')
    in_ptr = ffi.NULL

    # Now we should process the data somehow...
    lib.funcpdf(
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

