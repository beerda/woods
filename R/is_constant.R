#'
#' @return
#' @author Michal Burda
#' @export
is_constant <- function(x) {
    all(duplicated(x)[-1])
}
