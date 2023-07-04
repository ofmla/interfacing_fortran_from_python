import numpy as np
from c_funcpdf import FuncPDF
import matplotlib.pyplot as plt
import fileio

    
if __name__ == "__main__":
    x, y, z = fileio.read_xy_or_xyz("./data/synthetic_xyz.dat")
    xrec, yrec = fileio.read_xy_or_xyz("./data/grid_xy.dat")[0:-1]
    values = fileio.read_txt_file("./data/input.dat")

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

