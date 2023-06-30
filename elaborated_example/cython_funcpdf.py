import numpy as np
from c_funcpdf import FuncPDF
import matplotlib.pyplot as plt


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

    # Create FuncPDF instance
    func_pdf = FuncPDF()

    # Call the funcpdf method
    result = func_pdf.funcpdf(1, len(xrec), len(x), len(xrec), values[-4], values[-3], values[-2], values[-1], z, x, y, xrec, yrec)
    
    # or
    #pl_opt = "inner"
    #result = func_pdf.funcpdf(1, len(xrec), len(x), len(xrec), values[-4], values[-3], values[-2], values[-1], z, x, y, xrec, yrec, pl_opt)

    # Generate grid data
    x = np.unique(xrec)
    y = np.unique(yrec)
    X, Y = np.meshgrid(y, x)

    # Plot the 'result' array
    grid = np.reshape(result, X.shape,)#order='F')
    plt.pcolormesh(Y,X,grid, shading='auto')
    plt.gca().set_aspect("equal")
    plt.colorbar()
    plt.show()

