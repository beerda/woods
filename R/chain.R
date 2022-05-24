#' Chained execution of a list of functions
#'
#' The first function in list `l` is executed with the given `arg` then the result
#' is passed to the second function and so on for each function in the list.
#'
#' @param l A list of function to be executed in chain
#' @param arg the argument passed to the first function
#' @param ... further arguments passed to all functions
#' @return The result of the last function in the list
#' @author Michal Burda
#' @export
chain <- function(l, arg, ...) {
    Reduce(f = function(arg, fun) fun(arg, ...),
           x = l,
           init = arg)
}
