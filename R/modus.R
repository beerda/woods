#' Get the most frequent value
#'
#' @return The modus (mode), i.e., the most frequent value
#' @author Michal Burda
#' @export
modus <- function(x, na.rm = FALSE) {
    if (na.rm) {
        x <- na.omit(x)
    }
    uniqv <- unique(x)
    uniqv[which.max(tabulate(match(x, uniqv)))]
}
