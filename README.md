
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
fit <- woods(y ~ a + b, data = d, n_tree = 2)
print(fit)
#> Call: woods.formula(formula = y ~ a + b, data = d, n_tree = 2)
#> Split: sum of squared error
#> Leaves: mean
#> 
#> Model:
#> [[1]]
#> 3 (mean)
#> 
#> [[2]]
#> 3 (mean)
```

Analogously we run the algorithm e.g. on iris dataset:

``` r
fit <- woods(Species ~ Sepal.Length + Sepal.Width, data = iris, n_tree = 2)
print(fit)
#> Call: woods.formula(formula = Species ~ Sepal.Length + Sepal.Width, 
#>     data = iris, n_tree = 2)
#> Split: information gain
#> Leaves: mode
#> 
#> Model:
#> [[1]]
#> Sepal.Length <= 5.4 (cutpoint_condition)
#>     Sepal.Length <= 4.8 (cutpoint_condition)
#>         setosa (mode, n=16)
#>         Sepal.Width <= 2.5 (cutpoint_condition)
#>             Sepal.Length <= 4.9 (cutpoint_condition)
#>                 versicolor (mode, n=2)
#>                 versicolor (mode, n=3)
#>             Sepal.Width <= 2.7 (cutpoint_condition)
#>                 versicolor (mode, n=1)
#>                 Sepal.Width <= 3.9 (cutpoint_condition)
#>                     Sepal.Width <= 3 (cutpoint_condition)
#>                         Sepal.Length <= 5 (cutpoint_condition)
#>                             setosa (mode, n=2)
#>                             versicolor (mode, n=1)
#>                         setosa (mode, n=26)
#>                     setosa (mode, n=1)
#>     Sepal.Width <= 3.8 (cutpoint_condition)
#>         Sepal.Length <= 7 (cutpoint_condition)
#>             Sepal.Length <= 5.5 (cutpoint_condition)
#>                 Sepal.Width <= 2.6 (cutpoint_condition)
#>                     versicolor (mode, n=5)
#>                     setosa (mode, n=1)
#>                 Sepal.Width <= 3.4 (cutpoint_condition)
#>                     Sepal.Width <= 2.3 (cutpoint_condition)
#>                         Sepal.Width <= 2.2 (cutpoint_condition)
#>                             Sepal.Length <= 6 (cutpoint_condition)
#>                                 versicolor (mode, n=2)
#>                                 versicolor (mode, n=1)
#>                             versicolor (mode, n=1)
#>                         Sepal.Width <= 3.3 (cutpoint_condition)
#>                             Sepal.Width <= 2.6 (cutpoint_condition)
#>                                 Sepal.Width <= 2.5 (cutpoint_condition)
#>                                     Sepal.Length <= 5.6 (cutpoint_condition)
#>                                         versicolor (mode, n=1)
#>                                         virginica (mode, n=4)
#>                                     Sepal.Length <= 5.8 (cutpoint_condition)
#>                                         versicolor (mode, n=2)
#>                                         virginica (mode, n=1)
#>                                 Sepal.Width <= 2.9 (cutpoint_condition)
#>                                     Sepal.Length <= 6.2 (cutpoint_condition)
#>                                         Sepal.Width <= 2.8 (cutpoint_condition)
#>                                             Sepal.Width <= 2.7 (cutpoint_condition)
#>                                                 Sepal.Length <= 5.6 (cutpoint_condition)
#>                                                     versicolor (mode, n=1)
#>                                                     versicolor (mode, n=5)
#>                                                 Sepal.Length <= 5.8 (cutpoint_condition)
#>                                                     Sepal.Length <= 5.7 (cutpoint_condition)
#>                                                         versicolor (mode, n=3)
#>                                                         virginica (mode, n=1)
#>                                                     versicolor (mode, n=3)
#>                                             versicolor (mode, n=5)
#>                                         Sepal.Length <= 6.4 (cutpoint_condition)
#>                                             Sepal.Length <= 6.3 (cutpoint_condition)
#>                                                 virginica (mode, n=3)
#>                                                 Sepal.Width <= 2.7 (cutpoint_condition)
#>                                                     virginica (mode, n=1)
#>                                                     Sepal.Width <= 2.8 (cutpoint_condition)
#>                                                         virginica (mode, n=2)
#>                                                         versicolor (mode, n=1)
#>                                             versicolor (mode, n=3)
#>                                     Sepal.Length <= 5.6 (cutpoint_condition)
#>                                         versicolor (mode, n=2)
#>                                         Sepal.Width <= 3 (cutpoint_condition)
#>                                             Sepal.Length <= 5.7 (cutpoint_condition)
#>                                                 versicolor (mode, n=1)
#>                                                 Sepal.Length <= 6.6 (cutpoint_condition)
#>                                                     Sepal.Length <= 6.5 (cutpoint_condition)
#>                                                         Sepal.Length <= 5.9 (cutpoint_condition)
#>                                                             versicolor (mode, n=2)
#>                                                             Sepal.Length <= 6.1 (cutpoint_condition)
#>                                                                 Sepal.Length <= 6 (cutpoint_condition)
#>                                                                     virginica (mode, n=1)
#>                                                                     versicolor (mode, n=2)
#>                                                                 virginica (mode, n=3)
#>                                                         versicolor (mode, n=1)
#>                                                     Sepal.Length <= 6.7 (cutpoint_condition)
#>                                                         versicolor (mode, n=2)
#>                                                         virginica (mode, n=1)
#>                                             Sepal.Length <= 6.3 (cutpoint_condition)
#>                                                 Sepal.Length <= 5.9 (cutpoint_condition)
#>                                                     versicolor (mode, n=1)
#>                                                     versicolor (mode, n=2)
#>                                                 Sepal.Length <= 6.9 (cutpoint_condition)
#>                                                     Sepal.Length <= 6.5 (cutpoint_condition)
#>                                                         virginica (mode, n=4)
#>                                                         Sepal.Length <= 6.8 (cutpoint_condition)
#>                                                             Sepal.Width <= 3.1 (cutpoint_condition)
#>                                                                 versicolor (mode, n=3)
#>                                                                 virginica (mode, n=3)
#>                                                             Sepal.Width <= 3.1 (cutpoint_condition)
#>                                                                 virginica (mode, n=3)
#>                                                                 virginica (mode, n=1)
#>                                                     versicolor (mode, n=1)
#>                             Sepal.Length <= 6 (cutpoint_condition)
#>                                 versicolor (mode, n=1)
#>                                 virginica (mode, n=2)
#>                     setosa (mode, n=1)
#>             virginica (mode, n=12)
#>         setosa (mode, n=3)
#> 
#> [[2]]
#> Sepal.Length <= 5.5 (cutpoint_condition)
#>     Sepal.Length <= 5.4 (cutpoint_condition)
#>         Sepal.Length <= 4.9 (cutpoint_condition)
#>             Sepal.Width <= 2.5 (cutpoint_condition)
#>                 Sepal.Length <= 4.5 (cutpoint_condition)
#>                     setosa (mode, n=1)
#>                     Sepal.Width <= 2.4 (cutpoint_condition)
#>                         versicolor (mode, n=1)
#>                         virginica (mode, n=1)
#>                 setosa (mode, n=19)
#>             Sepal.Length <= 5 (cutpoint_condition)
#>                 Sepal.Width <= 2.3 (cutpoint_condition)
#>                     versicolor (mode, n=2)
#>                     setosa (mode, n=8)
#>                 Sepal.Length <= 5.1 (cutpoint_condition)
#>                     Sepal.Width <= 2.5 (cutpoint_condition)
#>                         versicolor (mode, n=1)
#>                         setosa (mode, n=8)
#>                     Sepal.Length <= 5.3 (cutpoint_condition)
#>                         setosa (mode, n=5)
#>                         Sepal.Width <= 3 (cutpoint_condition)
#>                             versicolor (mode, n=1)
#>                             setosa (mode, n=5)
#>         Sepal.Width <= 2.4 (cutpoint_condition)
#>             versicolor (mode, n=3)
#>             Sepal.Width <= 2.6 (cutpoint_condition)
#>                 versicolor (mode, n=2)
#>                 setosa (mode, n=2)
#>     Sepal.Length <= 5.6 (cutpoint_condition)
#>         Sepal.Width <= 2.8 (cutpoint_condition)
#>             Sepal.Width <= 2.7 (cutpoint_condition)
#>                 versicolor (mode, n=2)
#>                 virginica (mode, n=1)
#>             versicolor (mode, n=3)
#>         Sepal.Length <= 5.8 (cutpoint_condition)
#>             Sepal.Length <= 5.7 (cutpoint_condition)
#>                 Sepal.Width <= 2.5 (cutpoint_condition)
#>                     virginica (mode, n=1)
#>                     Sepal.Width <= 3 (cutpoint_condition)
#>                         versicolor (mode, n=5)
#>                         setosa (mode, n=2)
#>                 Sepal.Width <= 2.7 (cutpoint_condition)
#>                     Sepal.Width <= 2.6 (cutpoint_condition)
#>                         versicolor (mode, n=1)
#>                         versicolor (mode, n=4)
#>                     Sepal.Width <= 2.8 (cutpoint_condition)
#>                         virginica (mode, n=1)
#>                         setosa (mode, n=1)
#>             Sepal.Width <= 3.4 (cutpoint_condition)
#>                 Sepal.Length <= 5.9 (cutpoint_condition)
#>                     Sepal.Width <= 3 (cutpoint_condition)
#>                         versicolor (mode, n=2)
#>                         versicolor (mode, n=1)
#>                     Sepal.Width <= 2.3 (cutpoint_condition)
#>                         Sepal.Length <= 6 (cutpoint_condition)
#>                             versicolor (mode, n=2)
#>                             versicolor (mode, n=2)
#>                         Sepal.Width <= 2.9 (cutpoint_condition)
#>                             Sepal.Length <= 6.1 (cutpoint_condition)
#>                                 Sepal.Width <= 2.6 (cutpoint_condition)
#>                                     virginica (mode, n=1)
#>                                     versicolor (mode, n=5)
#>                                 Sepal.Length <= 6.8 (cutpoint_condition)
#>                                     Sepal.Length <= 6.7 (cutpoint_condition)
#>                                         Sepal.Width <= 2.8 (cutpoint_condition)
#>                                             Sepal.Width <= 2.5 (cutpoint_condition)
#>                                                 Sepal.Length <= 6.3 (cutpoint_condition)
#>                                                     versicolor (mode, n=2)
#>                                                     virginica (mode, n=1)
#>                                                 Sepal.Length <= 6.4 (cutpoint_condition)
#>                                                     virginica (mode, n=6)
#>                                                     versicolor (mode, n=1)
#>                                             Sepal.Length <= 6.3 (cutpoint_condition)
#>                                                 Sepal.Length <= 6.2 (cutpoint_condition)
#>                                                     versicolor (mode, n=1)
#>                                                     virginica (mode, n=1)
#>                                                 versicolor (mode, n=2)
#>                                         versicolor (mode, n=1)
#>                                     virginica (mode, n=4)
#>                             Sepal.Length <= 6 (cutpoint_condition)
#>                                 Sepal.Width <= 3 (cutpoint_condition)
#>                                     virginica (mode, n=1)
#>                                     versicolor (mode, n=1)
#>                                 Sepal.Length <= 6.9 (cutpoint_condition)
#>                                     Sepal.Width <= 3.1 (cutpoint_condition)
#>                                         Sepal.Length <= 6.1 (cutpoint_condition)
#>                                             versicolor (mode, n=2)
#>                                             Sepal.Length <= 6.5 (cutpoint_condition)
#>                                                 virginica (mode, n=4)
#>                                                 Sepal.Width <= 3 (cutpoint_condition)
#>                                                     Sepal.Length <= 6.7 (cutpoint_condition)
#>                                                         versicolor (mode, n=3)
#>                                                         virginica (mode, n=1)
#>                                                     Sepal.Length <= 6.7 (cutpoint_condition)
#>                                                         versicolor (mode, n=3)
#>                                                         virginica (mode, n=3)
#>                                         Sepal.Length <= 6.3 (cutpoint_condition)
#>                                             Sepal.Length <= 6.2 (cutpoint_condition)
#>                                                 virginica (mode, n=1)
#>                                                 virginica (mode, n=3)
#>                                             Sepal.Width <= 3.2 (cutpoint_condition)
#>                                                 Sepal.Length <= 6.4 (cutpoint_condition)
#>                                                     versicolor (mode, n=2)
#>                                                     virginica (mode, n=3)
#>                                                 virginica (mode, n=2)
#>                                     Sepal.Width <= 3 (cutpoint_condition)
#>                                         virginica (mode, n=4)
#>                                         versicolor (mode, n=2)
#>                 virginica (mode, n=3)
```

The fitted woods model may be used to classify the new data as follows:

``` r
predict(fit, iris)
#>   [1] setosa     setosa     setosa     setosa     setosa     setosa    
#>   [7] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [13] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [19] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [25] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [31] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [37] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [43] setosa     setosa     setosa     setosa     setosa     setosa    
#>  [49] setosa     setosa     versicolor virginica  virginica  versicolor
#>  [55] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [61] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [67] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [73] virginica  versicolor versicolor versicolor versicolor versicolor
#>  [79] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [85] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [91] versicolor versicolor versicolor versicolor versicolor versicolor
#>  [97] versicolor versicolor versicolor versicolor versicolor versicolor
#> [103] virginica  virginica  virginica  virginica  versicolor virginica 
#> [109] virginica  virginica  virginica  virginica  virginica  virginica 
#> [115] virginica  virginica  virginica  virginica  virginica  versicolor
#> [121] virginica  versicolor virginica  virginica  virginica  virginica 
#> [127] versicolor versicolor virginica  virginica  virginica  virginica 
#> [133] virginica  virginica  virginica  virginica  virginica  virginica 
#> [139] virginica  virginica  versicolor virginica  versicolor virginica 
#> [145] virginica  versicolor virginica  virginica  virginica  versicolor
#> Levels: setosa versicolor virginica
```

## Using `woods` with `caret`

``` r
library(caret)
#> Loading required package: ggplot2
#> Loading required package: lattice
library(doParallel)
#> Loading required package: foreach
#> Loading required package: iterators
#> Loading required package: parallel

set.seed(335)
cl <- makePSOCKcluster(24)
registerDoParallel(cl)

# setup the cross-validation parameters
trControl <- trainControl(method = 'repeatedcv',
                        number = 10,
                        repeats = 1)

# cross-validate performance of the random forest as implemented by L. Breiman (the randomForest package)
rfFit <- train(Species ~ .,
               data = iris,
               method = 'rf',
               trControl = trControl)
print(rfFit)
#> Random Forest 
#> 
#> 150 samples
#>   4 predictor
#>   3 classes: 'setosa', 'versicolor', 'virginica' 
#> 
#> No pre-processing
#> Resampling: Cross-Validated (10 fold, repeated 1 times) 
#> Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
#> Resampling results across tuning parameters:
#> 
#>   mtry  Accuracy   Kappa
#>   2     0.9600000  0.94 
#>   3     0.9600000  0.94 
#>   4     0.9533333  0.93 
#> 
#> Accuracy was used to select the optimal model using the largest value.
#> The final value used for the model was mtry = 2.

# cross-validate performance of woods
woodsFit <- train(Species ~ .,
                  data = iris,
                  method = woodsModelInfo,
                  trControl = trControl)
print(woodsFit)
#> 150 samples
#>   4 predictor
#>   3 classes: 'setosa', 'versicolor', 'virginica' 
#> 
#> No pre-processing
#> Resampling: Cross-Validated (10 fold, repeated 1 times) 
#> Summary of sample sizes: 135, 135, 135, 135, 135, 135, ... 
#> Resampling results across tuning parameters:
#> 
#>   mtry  Accuracy   Kappa
#>   2     0.9533333  0.93 
#>   3     0.9466667  0.92 
#>   4     0.9466667  0.92 
#> 
#> Accuracy was used to select the optimal model using the largest value.
#> The final value used for the model was mtry = 2.

stopCluster(cl)
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
