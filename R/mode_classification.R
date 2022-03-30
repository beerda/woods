#'
#' @return
#' @author Michal Burda
#' @export
mode_classification <- function(data) {
    uniq <- unique(data$y)
    value <- uniq[which.max(tabulate(match(data$y, uniq)))]

    list(label = paste('mode', value),
         value = value)
}
