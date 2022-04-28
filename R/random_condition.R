#'
#' @return
#' @author Michal Burda
#' @export
random_condition <- function(data, cfg) {
    cutpoint_condition(var = sample(colnames(data$x), 1),
                       cutpoint = sample(data$x[[by]], 1),
                       type = 'random',
                       criterion = NULL)
}
