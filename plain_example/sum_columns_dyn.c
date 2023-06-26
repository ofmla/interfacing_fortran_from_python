#include <stdio.h>
#include <stdlib.h>

extern void csum_columns(double* arr, int rows, int cols, double* sarr);

int main()
{
    const int rows = 2;
    const int cols = 3;

    double* xarray = malloc(rows * cols * sizeof(double));
    double* yarray = malloc(cols * sizeof(double));

    // Populate xarray
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            xarray[i * cols + j] = j + 1.0;
        }
    }

    csum_columns(xarray, rows, cols, yarray);

    for (int i = 0; i < cols; i++)
    {
        printf("%.1f ", yarray[i]);
    }
    printf("\n"); // Add a newline

    // Deallocate memory
    free(xarray);
    free(yarray);

    return 0;
}

