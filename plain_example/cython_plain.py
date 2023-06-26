import numpy as np
from mod_sum import sum_columns

a = np.array([[1, 2, 3], [1, 2, 3]], dtype=np.float64)
sum_col = sum_columns(a)
print(sum_col)

