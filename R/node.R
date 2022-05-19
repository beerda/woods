node <- function(data, cfg) {
    # max tree height reached?
    if (!is.na(cfg$max_height) && cfg$max_height <= 1) { # max_height is decreasing in child nodes
        return(leaf(data, cfg))
    }

    # too small node?
    if (length(data$y) < cfg$node_size) {
        return(leaf(data, cfg))
    }

    # target is constant?
    if (is_constant(data$y)) {
        return(leaf(data, cfg))
    }

    data <- remove_constants(data)

    # all input columns are constant?
    if (ncol(data$x) <= 0) {
        return(leaf(data, cfg))
    }

    node_data <- cfg$prepare_node_data(data)
    split_def <- cfg$find_best_split(node_data, cfg)

    # failed to split the data?
    if (is.null(split_def)) {
        return(leaf(data, cfg))
    }

    splitted <- split_data(split_def, data, cfg)

    # any of the children is smaller than node_size?
    if (length(splitted$left$y) < cfg$node_size || length(splitted$right$y) < cfg$node_size) {
        return(leaf(data, cfg))
    }

    cfg$max_height <- cfg$max_height - 1

    structure(list(split = split_def,
                   left = node(splitted$left, cfg),
                   right = node(splitted$right, cfg)),
              class = 'node')
}


leaf <- function(data, cfg) {
    structure(list(result = cfg$create_result(data)),
              class = c('node', 'leaf'))
}


#' @export
is.node <- function(x) {
    inherits(x, 'node')
}


#' @export
is.leafnode <- function(x) {
    inherits(x, 'node') && inherits(x, 'leaf')
}


#' @export
print.node <- function(x, prefix = '', ...) {
    if (!is.null(x$split)) {
        cat(prefix, x$split$label, ' (', class(x$split)[1], ')', '\n', sep = '')
        prefix <- paste0(prefix, '    ')
        print(x$left, prefix)
        print(x$right, prefix)

    } else {
        cat(prefix, x$result$label, '\n', sep = '')
    }
}
