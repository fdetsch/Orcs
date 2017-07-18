#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP _Orcs_dimC(SEXP);
extern SEXP _Orcs_ncolC(SEXP);
extern SEXP _Orcs_nrowC(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"_Orcs_dimC",  (DL_FUNC) &_Orcs_dimC,  1},
    {"_Orcs_ncolC", (DL_FUNC) &_Orcs_ncolC, 1},
    {"_Orcs_nrowC", (DL_FUNC) &_Orcs_nrowC, 1},
    {NULL, NULL, 0}
};

void R_init_Orcs(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
