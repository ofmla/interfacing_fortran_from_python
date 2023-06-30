import numpy as np
cimport numpy as np
from cpython.bytes cimport PyBytes_AS_STRING

cdef extern from "c_funcpdf.h":
    void c_funcpdf(
        int* ista, int* iend, int* n, int* m,
        double* sd, double* alpha, double* dx, double* dy,
        double* z, double* xprm, double* yprm,
        double* xrec, double* yrec, double* f,
        void* cpl_opt
    )

cdef class FuncPDF:
    def funcpdf(self, int ista, int iend, int n, int m, double sd, double alpha,
                double dx, double dy, np.ndarray[np.float64_t, ndim=1] z,
                np.ndarray[np.float64_t, ndim=1] xprm, np.ndarray[np.float64_t, ndim=1] yprm,
                np.ndarray[np.float64_t, ndim=1] xrec, np.ndarray[np.float64_t, ndim=1] yrec,
                str pl_opt=None):
        cdef int c_ista = ista
        cdef int c_iend = iend
        cdef int c_n = n
        cdef int c_m = m
        cdef double c_sd = sd
        cdef double c_alpha = alpha
        cdef double c_dx = dx
        cdef double c_dy = dy
        cdef double* c_z = <double *>z.data
        cdef double* c_xprm = <double *>xprm.data
        cdef double* c_yprm = <double *>yprm.data
        cdef double* c_xrec = <double *>xrec.data
        cdef double* c_yrec = <double *>yrec.data

        cdef np.ndarray[np.float64_t, ndim=1] c_f_np = np.empty(m, dtype=np.float64)
        cdef double* c_f = <double *>c_f_np.data

        cdef bytes c_pl_opt

        if pl_opt is not None:
            c_pl_opt = pl_opt.encode()
            c_funcpdf(&c_ista, &c_iend, &c_n, &c_m, &c_sd, &c_alpha, &c_dx, &c_dy,
                      c_z, c_xprm, c_yprm, c_xrec, c_yrec, c_f, <void *>PyBytes_AS_STRING(c_pl_opt))
        else:
            c_funcpdf(&c_ista, &c_iend, &c_n, &c_m, &c_sd, &c_alpha, &c_dx, &c_dy,
                      c_z, c_xprm, c_yprm, c_xrec, c_yrec, c_f, NULL)

        return c_f_np

