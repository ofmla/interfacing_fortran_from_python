""" File IO utilities"""
import numpy as np


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
