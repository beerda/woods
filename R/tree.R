tree <- function(data, cfg) {
    data <- cfg$prepare_tree_data(data)
    root <- node(data, cfg)

    structure(list(root = root),
              class = 'tree')
}


#' @export
is.tree <- function(x) {
    inherits(x, 'tree') &&
        is.list(x) &&
        !is.null(root)
}


#' @export
print.tree <- function(x, ...) {
    print(x$root, '')
}
