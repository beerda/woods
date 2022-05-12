#include <Rcpp.h>
#include <math.h>
#include <stdio.h>

using namespace Rcpp;


double entropy(size_t* freq, size_t array_size, size_t data_size) {
    double res = 0;
    for (size_t i = 0; i < array_size; i++) {
        double p = 1.0 * freq[i] / data_size;
        double r = p * log2(p);
        if (isnan(r))
            r = 0;

        res -= r;
    }

    return res;
}


// [[Rcpp::export(name=".igr_by_indices")]]
double igr_by_indices(IntegerVector x, LogicalVector indices)
{
    CharacterVector levels = x.attr("levels");
    size_t trueCount = 0;
    size_t freqTrue[levels.size()];
    size_t freqFalse[levels.size()];
    size_t freqAll[levels.size()];

    for (size_t i = 0; i < levels.size(); i++) {
        freqTrue[i] = 0;
        freqFalse[i] = 0;
        freqAll[i] = 0;
    }

    for (size_t i = 0; i < x.size(); i++) {
        if (indices[i]) {
            freqTrue[x[i] - 1]++;
            trueCount++;
        } else {
            freqFalse[x[i] - 1]++;
        }
    }

    for (size_t i = 0; i < levels.size(); i++) {
        freqAll[i] = freqTrue[i] + freqFalse[i];
    }

    size_t props[2];
    props[0] = trueCount;
    props[1] = x.size() - trueCount;
    double before = entropy(freqAll, levels.size(), x.size());
    double after = (1.0 * props[0] / x.size()) * entropy(freqTrue, levels.size(), trueCount)
        + (1.0 * props[1] / x.size()) * entropy(freqFalse, levels.size(), x.size() - trueCount);
    double si = entropy(props, 2, x.size());

    return (before - after) / si;
}
