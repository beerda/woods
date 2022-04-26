
<!-- README.md is generated from README.Rmd. Please edit that file -->

# woods

Experimental R package for double random forests

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
#> 
#> Attaching package: 'woods'
#> The following object is masked from 'package:base':
#> 
#>     split
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
#> a <= 6 (sse_split)
#>  a <= 2 (sse_split)
#>      1 (mean)
#>      3 (mean)
#>  5 (mean)
#> 
#> [[2]]
#> b <= 9 (sse_split)
#>  b <= 3 (sse_split)
#>      1 (mean)
#>      3 (mean)
#>  5 (mean)
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
#> Sepal.Length <= 5.7 (ig_split)
#>  setosa (mode, n=71)
#>  Sepal.Width <= 3.2 (ig_split)
#>      Sepal.Length <= 5.8 (ig_split)
#>          versicolor (mode, n=5)
#>          virginica (mode, n=58)
#>      Sepal.Length <= 5.8 (ig_split)
#>          setosa (mode, n=5)
#>          Sepal.Length <= 6.3 (ig_split)
#>              virginica (mode, n=5)
#>              virginica (mode, n=6)
#> 
#> [[2]]
#> Sepal.Length <= 5.6 (ig_split)
#>  Sepal.Width <= 2.8 (ig_split)
#>      versicolor (mode, n=17)
#>      setosa (mode, n=53)
#>  Sepal.Length <= 5.7 (ig_split)
#>      versicolor (mode, n=9)
#>      Sepal.Length <= 5.8 (ig_split)
#>          virginica (mode, n=5)
#>          virginica (mode, n=66)
```
