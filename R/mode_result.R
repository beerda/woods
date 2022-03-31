#'
#' @return
#' @author Michal Burda
#' @export
mode_result <- function(data) {
    uniq <- unique(data$y)
    value <- uniq[which.max(tabulate(match(data$y, uniq)))]

    list(label = paste('mode', value),
         value = value)
}
