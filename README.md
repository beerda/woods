
<!-- README.md is generated from README.Rmd. Please edit that file -->

# woods

Experimental R package for double random forests

## Implemented Features

-   creation of a binary decision tree based on data
-   both numerical and categorical inputs are allowed (categorical
    inputs are transformed to sets of dummy 0/1 variables)
-   numerical target allowed:
    -   node splitting by the Sum of Squared Error (SSE)
    -   leaf node – average value
-   categorical target allowed:
    -   node splitting by the Information Gain Ratio (IGR)
    -   leaf node – mode (the most frequent value)
-   bootstrapping available to create sets of trees (a forest)

## Installation

To install the development version from GitHub, type the following
commands within the R session:

``` r
install.packages("devtools")
devtools::install_github("beerda/woods")
```

## Usage

Firstly, load the package to start using the `woods` library:

``` r
library(woods)
```

Then create some input data:

``` r
d <- data.frame(y = 1:5, a = 2 * (1:5), b = 3 * (1:5))
print(d)
#>   y  a  b
#> 1 1  2  3
#> 2 2  4  6
#> 3 3  6  9
#> 4 4  8 12
#> 5 5 10 15
```

To train the `woods` model with columns `a`, `b` being the independent
variables and `y` being the target, the following command has to be
executed:

``` r
fit <- woods(y ~ a + b, data = d)
print(fit)
#> Call: woods.formula(formula = y ~ a + b, data = d)
#> Split: sum of squared error
#> Leaves: mean
#> 
#> Model:
#> [[1]]
#> a <= 2 (cutpoint_condition)
#>     1 (mean)
#>     a <= 6 (cutpoint_condition)
#>         3 (mean)
#>         5 (mean)
#> 
#> [[2]]
#> b <= 9 (cutpoint_condition)
#>     b <= 3 (cutpoint_condition)
#>         1 (mean)
#>         3 (mean)
#>     5 (mean)
```

Analogously we run the algorithm e.g. on iris dataset:

``` r
fit <- woods(Species ~ Sepal.Length + Sepal.Width, data = iris, node_size = 5)
print(fit)
#> Call: woods.formula(formula = Species ~ Sepal.Length + Sepal.Width, 
#>     data = iris, node_size = 5)
#> Split: information gain
#> Leaves: mode
#> 
#> Model:
#> [[1]]
#> Sepal.Length <= 5.4 (cutpoint_condition)
#>     setosa (mode, n=54)
#>     Sepal.Width <= 3.8 (cutpoint_condition)
#>         virginica (mode, n=89)
#>         setosa (mode, n=7)
#> 
#> [[2]]
#> Sepal.Length <= 5.4 (cutpoint_condition)
#>     setosa (mode, n=56)
#>     Sepal.Width <= 3.4 (cutpoint_condition)
#>         Sepal.Length <= 7 (cutpoint_condition)
#>             Sepal.Length <= 5.5 (cutpoint_condition)
#>                 versicolor (mode, n=5)
#>                 versicolor (mode, n=70)
#>             Sepal.Length <= 7.3 (cutpoint_condition)
#>                 virginica (mode, n=5)
#>                 virginica (mode, n=6)
#>         virginica (mode, n=8)
```

The fitted woods model may be used to classify the new data as follows:

``` r
predict(fit, iris)
#>   [1] setosa    setosa    setosa    setosa    setosa    setosa    setosa   
#>   [8] setosa    setosa    setosa    setosa    setosa    setosa    setosa   
#>  [15] setosa    setosa    setosa    setosa    virginica setosa    setosa   
#>  [22] setosa    setosa    setosa    setosa    setosa    setosa    setosa   
#>  [29] setosa    setosa    setosa    setosa    setosa    setosa    setosa   
#>  [36] setosa    virginica setosa    setosa    setosa    setosa    setosa   
#>  [43] setosa    setosa    setosa    setosa    setosa    setosa    setosa   
#>  [50] setosa    virginica virginica virginica virginica virginica virginica
#>  [57] virginica setosa    virginica setosa    setosa    virginica virginica
#>  [64] virginica virginica virginica virginica virginica virginica virginica
#>  [71] virginica virginica virginica virginica virginica virginica virginica
#>  [78] virginica virginica virginica virginica virginica virginica virginica
#>  [85] setosa    virginica virginica virginica virginica virginica virginica
#>  [92] virginica virginica setosa    virginica virginica virginica virginica
#>  [99] setosa    virginica virginica virginica virginica virginica virginica
#> [106] virginica setosa    virginica virginica virginica virginica virginica
#> [113] virginica virginica virginica virginica virginica virginica virginica
#> [120] virginica virginica virginica virginica virginica virginica virginica
#> [127] virginica virginica virginica virginica virginica virginica virginica
#> [134] virginica virginica virginica virginica virginica virginica virginica
#> [141] virginica virginica virginica virginica virginica virginica virginica
#> [148] virginica virginica virginica
#> Levels: setosa versicolor virginica
```

## Fuzzy Transform

-   a kernel-based approximation of function `f` (from discrete values)
-   domains have to be bounded
-   input domains are partitioned by fuzzy sets
-   each fuzzy set of the partition is assigned with:
    -   0-order f-transform: an average value of the original function
        `f`
    -   1-order f-transform: a linear function fitted to the values of
        `f`
    -   n-order f-transform: a polynomial function fitted to the values
        of `f`
-   fitting is based on weighting by the membership degrees of inputs to
    the fuzzy sets of the partitions

<!-- -->

    y ^
      |                             _____
      |           __*____         */    *\
      |          /       \_       /       \
      |       * /         *\__*__/         \*
      |      __/                            \
      |   __/
      |  /*
      | /
      |/
      +------------------------------------------>
                                                 x
          _    _    _    _    _    _    _    _  
         / \  / \  / \  / \  / \  / \  / \  / \  
        /   \/   \/   \/   \/   \/   \/   \/   \  
       /    /\   /\   /\   /\   /\   /\   /\    \  
