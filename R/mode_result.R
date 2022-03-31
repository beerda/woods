#' Create the leaf node result by obtaining the mode, i.e., the most frequent
#' value in data
#'
#' @param data the instance of the `woods_data` S3 class
#' @return the list with the mode as `value` and `"mode"` as `label`
#' @author Michal Burda
#' @export
mode_result <- function(data) {
    uniq <- unique(data$y)
    value <- uniq[which.max(tabulate(match(data$y, uniq)))]

    list(label = paste('mode', value),
         value = value)
}
