#include <stdio.h>

extern void csum_columns(double arr[2][3], int rows, int cols, double sarr[]);

int main()
{
    const int rows = 2;
    const int cols = 3;

    double xarray[rows][cols];
    double yarray[cols];

    // Populate xarray
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            xarray[i][j] = j + 1.0;
        }
    }

    csum_columns(xarray, rows, cols, yarray);

    for (int i = 0; i < cols; i++)
    {
        printf("%.1f ", yarray[i]);
    }
    printf("\n"); // Add a newline

    return 0;
}

