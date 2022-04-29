#'
#' @return
#' @author michal burda
#' @export
cutpoint_condition <- function(var, cutpoint, type, criterion, ...) {
    structure(list(label = paste(var, '<=', cutpoint),
                   var = var,
                   cutpoint = cutpoint,
                   type = type,
                   criterion = criterion,
                   ...),
              class = 'cutpoint_condition')
}


#' @export
is.cutpoint_condition <- function(x) {
    inherits(x, 'cutpoint_condition') &&
        is.list(x) &&
        !is.null(x$label) &&
        !is.null(x$var) &&
        !is.null(x$cutpoint) &&
        !is.null(x$type) &&
        !is.null(x$criterion)
}
