#include <iostream>
#include <iomanip>
#include <cstdlib>

extern "C"
{
    void csum_columns(double* arr, int rows, int cols, double* sarr);
}

int main()
{
    const int rows = 2;
    const int cols = 3;

    double* xarray = new double[rows * cols];
    double* yarray = new double[cols];

    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            xarray[i * cols + j] = j + 1.0;
        }
    }

    csum_columns(xarray, rows, cols, yarray);

    std::cout << std::fixed << std::setprecision(1);
    for (int i = 0; i < cols; i++)
    {
        std::cout << yarray[i] << " ";
    }
    std::cout << "\n"; // Add a newline

    // Deallocate memory
    delete[] xarray;
    delete[] yarray;

    return 0;
}

