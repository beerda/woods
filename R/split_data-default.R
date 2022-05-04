#' Split data to `left` and `right` part accordingly to the logical vector
#'
#' @param def a logical vector indicating which data rows belong to the `left` part of the split
#' @param data the instance of the `woods_data` S3 class
#' @param cfg the configuration list (not needed for this function)
#' @return a list with `left` and `right` data (`left` data are those indicated as `TRUE` in the
#'     `def` vector, `right` data correspond to `FALSE` in the `def` vector)
#' @author Michal Burda
#' @export
split_data.default <- function(def, data, cfg) {
    assert_that(is.vector(def) && is.logical(def))
    assert_that(is.woods_data(data))

    list(left = data[def, ],
         right = data[!def, ])
}
