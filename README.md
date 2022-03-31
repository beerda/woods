
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
```

So far, the algorithm creates only some random output:

``` r
print(fit)
#> Call:
#> woods.formula(formula = y ~ a + b, data = d)
#> 
#> Model:
#> [[1]]
#> a <= 6
#>  a <= 2
#>      mode 1
#>      mode 2
#>  b <= 12
#>      mode 4
#>      mode 5
#> 
#> [[2]]
#> a <= 6
#>  mode 1
#>  mode 4
```
