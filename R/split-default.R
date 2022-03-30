#'
#' @return
#' @author Michal Burda
#' @export
split.default <- function(def, data, cfg) {
    list(left = list(y = data$y[def],
                     x = data$x[def, ]),
         right = list(y = data$y[!def],
                      x = data$x[!def, ]))
}
