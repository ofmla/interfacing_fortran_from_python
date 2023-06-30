#ifndef CFUNCPDF_H
#define CFUNCPDF_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

void c_funcpdf(int32_t* ista, int32_t* iend, int32_t* n, int32_t* m, double* sd, double* alpha, double* dx, double* dy, double* z, double* xprm, double* yprm, double* xrec, double* yrec, double* f, void* cpl_opt);

#ifdef __cplusplus
}
#endif

#endif /* CFUNCPDF_H */

