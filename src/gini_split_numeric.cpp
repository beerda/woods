#include <Rcpp.h>
#include <math.h>
#include <stdio.h>
#include <cstdlib>

using namespace Rcpp;

// [[Rcpp::export(name=".gini_split_numeric")]]
List gini_split_numeric(NumericVector x, IntegerVector order, IntegerVector y, size_t nlevels)
{
    // - we test for split condition x <= value (left) in contrast to x > value (right)
    // - assume "order" contains indices of x in ascending order

    size_t leftN = 0;
    size_t rightN = order.size();
    size_t* leftCount = new size_t[nlevels];
    size_t* rightCount = new size_t[nlevels];
    size_t leftSum = 0;
    size_t rightSum = 0;

    for (size_t i = 0; i < nlevels; ++i) {
        leftCount[i] = 0;
        rightCount[i] = 0;
    }
    for (long int i = 0; i < order.size(); ++i) {
        rightCount[y[i]]++;
    }
    for (size_t i = 0; i < nlevels; ++i) {
        rightSum += rightCount[i] * rightCount[i];
    }

    double bestImpurity = 1;
    size_t bestIndex = 0;

    for (long int i = 0; i < order.size() - 1; ++i) {
        int yval = y[order[i]];

        size_t prevLeft = 0;
        if (i > 0) {
            prevLeft = leftCount[yval];
        }

        leftCount[yval]++;
        leftN++;
        rightCount[yval]--;
        rightN--;

        leftSum = leftSum - prevLeft * prevLeft + leftCount[yval] * leftCount[yval];
        double leftGini = 1.0 * leftSum / (leftN * leftN);

        rightSum = rightSum - (rightCount[yval] + 1) * (rightCount[yval] + 1) + (rightCount[yval]) * (rightCount[yval]);
        double rightGini = 1.0 * rightSum / (rightN * rightN);

        double impurity = ((1 - leftGini) * leftN + (1 - rightGini) * rightN) / (leftN + rightN);

        if (i >= order.size() - 2 || x[order[i]] != x[order[i + 1]]) {
            if (impurity < bestImpurity || (impurity == bestImpurity && rand() % 2 == 0)) {
                bestImpurity = impurity;
                bestIndex = i;
            }
        }
    }

    delete[] rightCount;

    return Rcpp::List::create(Rcpp::Named("value") = x[order[bestIndex]],
                              Rcpp::Named("gini") = bestImpurity);
}
