#' Create the leaf node result by obtaining the mean value
#'
#' @param data the instance of the `woods_data` S3 class
#' @return the list with the mean as `value` and `"mean"` as `label`
#' @author Michal Burda
#' @export
mean_result <- function(data) {
    value <- mean(data$y)

    list(label = paste('mean', value),
         value = value)
}
