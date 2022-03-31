#'
#' @return
#' @author Michal Burda
#' @export
split.default <- function(def, data, cfg) {
    list(left = data[def, ],
         right = data[!def, ])
}
