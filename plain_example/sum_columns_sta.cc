#include <iostream>
#include <iomanip>

const int ROWS = 2;
const int COLS = 3;

extern "C"
{
    void csum_columns(double arr[ROWS][COLS], int i, int j, double sarr[COLS]);
}

int main() {
    double xarray[ROWS][COLS], yarray[COLS];

    for (int i =0; i < ROWS; i++) {
        for (int j =0; j < COLS; j++) {
            xarray[i][j] = j + 1.0;
        }
    }

    csum_columns(xarray, ROWS, COLS, yarray);

    std::cout << std:: fixed << std::setprecision(1);
    for (int i = 0; i < COLS; i++) {
        std::cout << yarray[i] << " ";
    }

    std:: cout << "\n"; // Add a newline

    return 0;
}