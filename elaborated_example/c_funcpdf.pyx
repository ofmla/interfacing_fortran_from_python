from numpy cimport ndarray
from numpy import empty

cdef extern void c_funcpdf(
    int* ista, int* iend, int* n, int* m,
    double* sd, double* alpha, double* dx, double* dy,
    double* z, double* xprm, double* yprm,
    double* xrec, double* yrec, double* f,
    const char* cpl_opt)

cdef class FuncPDF:
    def funcpdf(self, int ista, int iend, int n, int m, double sd, double alpha,
                double dx, double dy, ndarray[double, ndim=1] z,
                ndarray[double, ndim=1] xprm, ndarray[double, ndim=1] yprm,
                ndarray[double, ndim=1] xrec, ndarray[double, ndim=1] yrec,
                str pl_opt=None):

        cdef double* c_z = <double *>z.data
        cdef double* c_xprm = <double *>xprm.data
        cdef double* c_yprm = <double *>yprm.data
        cdef double* c_xrec = <double *>xrec.data
        cdef double* c_yrec = <double *>yrec.data

        cdef ndarray[double, ndim=1] c_f_np = empty(m)
        cdef double* c_f = <double *>c_f_np.data

        cdef bytes c_pl_opt

        if pl_opt is not None:
            c_pl_opt = pl_opt.encode()
            c_funcpdf(&ista, &iend, &n, &m, &sd, &alpha, &dx, &dy,
                      c_z, c_xprm, c_yprm, c_xrec, c_yrec, c_f, c_pl_opt)
        else:
            c_funcpdf(&ista, &iend, &n, &m, &sd, &alpha, &dx, &dy,
                      c_z, c_xprm, c_yprm, c_xrec, c_yrec, c_f, NULL)

        return c_f_np

