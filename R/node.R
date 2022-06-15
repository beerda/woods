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
    fits <- create_transformation_fits(cfg$transformations, node_data)
    node_data <- transform_data(fits, node_data)
    split_def <- cfg$find_best_split(node_data, cfg)

    # failed to split the data?
    if (is.null(split_def)) {
        return(leaf(data, cfg))
    }

    trans_data <- transform_data(fits, data)
    indices <- split_indices(split_def, trans_data, cfg)
    splitted <- split_data(indices, data, cfg)

    # any of the children is smaller than node_size?
    if (length(splitted$left$y) < cfg$node_size || length(splitted$right$y) < cfg$node_size) {
        return(leaf(data, cfg))
    }

    cfg$max_height <- cfg$max_height - 1

    transformation <- NULL
    if (!is.null(fits[[split_def$var]])) {
        transformation <-  fits[split_def$var]
    }

    structure(list(split = split_def,
                   transformation = transformation,
                   left = node(splitted$left, cfg),
                   right = node(splitted$right, cfg)),
              class = 'node')
}


leaf <- function(data, cfg) {
    structure(list(result = cfg$create_result(data)),
              class = c('node', 'leaf'))
}


create_transformation_fits <- function(transformations, data) {
    res <- lapply(transformations, function(f) f(data))

    res[lengths(res) > 0]
}


transform_data <- function(fits, data) {
    if (length(fits) <= 0) {
        return(data)
    }

    preds <- lapply(fits, function(f) predict(f, data$x))
    data$x <- do.call(cbind, c(list(data$x), preds))

    data
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
        cat(prefix,
            x$split$label,
            ' (', class(x$split)[1], ')',
            '\n',
            sep = '')
        prefix <- paste0(prefix, '    ')
        print(x$left, prefix)
        print(x$right, prefix)

    } else {
        cat(prefix, x$result$label, '\n', sep = '')
    }
}
