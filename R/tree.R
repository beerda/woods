tree <- function(data, cfg) {
    data <- cfg$prepare_tree_data(data)
    root <- node(data, cfg)

    structure(list(root = root),
              class = 'tree')
}


#' @export
print.tree <- function(x, ...) {
    print(x$root, '')
}
