import numpy as np
cimport numpy as np

cdef extern void csum_columns(double* arr, int rows, int cols, double* sarr)

def sum_columns(np.ndarray[np.float64_t, ndim=2] arr):
    cdef int rows = arr.shape[0]
    cdef int cols = arr.shape[1]
    cdef np.ndarray[np.float64_t, ndim=1] sum_col = np.empty(cols, dtype=np.float64)
    
    csum_columns(&arr[0, 0], rows, cols, &sum_col[0])
    
    return sum_col

