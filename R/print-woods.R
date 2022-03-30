#'
#' @return
#' @author Michal Burda
#' @export
print.woods <- function(x, ...) {
    cat('Call:\n')
    print(x$call)
    cat('\nModel:\n')
    print(x$model)
}
