from ctypes import CDLL, byref, c_int
import numpy as np
from numpy.ctypeslib import as_ctypes

lib = CDLL("mod_sum.so")

a = np.array([[1, 2, 3], [1, 2, 3]], dtype=np.float64)
sum_col = np.empty(a.shape[1], dtype=np.float64)
c_a = as_ctypes(a)
c_n_r_a = c_int(a.shape[0])
c_n_c_a = c_int(a.shape[1])
c_sum_col = as_ctypes(sum_col)
lib.csum_columns(byref(c_a), c_n_r_a, c_n_c_a, byref(c_sum_col))
print(sum_col)