import cffi
import numpy as np
from numpy.ctypeslib import as_ctypes

ffi = cffi.FFI()
ffi.cdef("""
    void csum_columns(double* a, int n_r_a, int n_c_a, double* sum_col);
""")
lib = ffi.dlopen("./mod_sum.so")

a = np.array([[1, 2, 3], [1, 2, 3]], dtype=np.float64)
sum_col = np.empty(a.shape[1], dtype=np.float64)
c_a = ffi.cast("double*", a.ctypes.data)
c_n_r_a = ffi.cast("int", a.shape[0])
c_n_c_a = ffi.cast("int", a.shape[1])
c_sum_col = ffi.cast("double*", sum_col.ctypes.data)
lib.csum_columns(c_a, c_n_r_a, c_n_c_a, c_sum_col)
print(sum_col)
