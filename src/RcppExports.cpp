// Generated by using Rcpp::compileAttributes() -> do not edit by hand
// Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#include <Rcpp.h>

using namespace Rcpp;

#ifdef RCPP_USE_GLOBAL_ROSTREAM
Rcpp::Rostream<true>&  Rcpp::Rcout = Rcpp::Rcpp_cout_get();
Rcpp::Rostream<false>& Rcpp::Rcerr = Rcpp::Rcpp_cerr_get();
#endif

// gini_split_numeric
List gini_split_numeric(NumericVector x, IntegerVector order, IntegerVector y, size_t nlevels);
RcppExport SEXP _woods_gini_split_numeric(SEXP xSEXP, SEXP orderSEXP, SEXP ySEXP, SEXP nlevelsSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< NumericVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type order(orderSEXP);
    Rcpp::traits::input_parameter< IntegerVector >::type y(ySEXP);
    Rcpp::traits::input_parameter< size_t >::type nlevels(nlevelsSEXP);
    rcpp_result_gen = Rcpp::wrap(gini_split_numeric(x, order, y, nlevels));
    return rcpp_result_gen;
END_RCPP
}
// igr_by_indices
double igr_by_indices(IntegerVector x, LogicalVector indices);
RcppExport SEXP _woods_igr_by_indices(SEXP xSEXP, SEXP indicesSEXP) {
BEGIN_RCPP
    Rcpp::RObject rcpp_result_gen;
    Rcpp::RNGScope rcpp_rngScope_gen;
    Rcpp::traits::input_parameter< IntegerVector >::type x(xSEXP);
    Rcpp::traits::input_parameter< LogicalVector >::type indices(indicesSEXP);
    rcpp_result_gen = Rcpp::wrap(igr_by_indices(x, indices));
    return rcpp_result_gen;
END_RCPP
}

static const R_CallMethodDef CallEntries[] = {
    {"_woods_gini_split_numeric", (DL_FUNC) &_woods_gini_split_numeric, 4},
    {"_woods_igr_by_indices", (DL_FUNC) &_woods_igr_by_indices, 2},
    {NULL, NULL, 0}
};

RcppExport void R_init_woods(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
