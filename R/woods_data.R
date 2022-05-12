#' Create the data structure used internally in the [woods()] algorithm.
#'
#' @param y the response vector
#' @param x the independent variables as data.frame
#' @return the S3 object of class `woods_data`
#' @author Michal Burda
#' @export
woods_data <- function(y, x) {
    assert_that(is.atomic(y) && !is.null(y))
    assert_that(is.data.frame(x))

    # ensure colnames exist
    if (is.null(colnames(x))) {
        colnames(x) <- paste0('col.', seq_along(x))
    }

    # make all x's columns numeric
    df <- list()
    for (i in colnames(x)) {
        v <- x[[i]]
        if (is.numeric(v)) {
            df[[i]] <- v
        } else if (is.logical(v) || is.ordered(v)) {
            df[[i]] <- as.integer(v)
        } else if (is.factor(v)) {
            for (l in levels(v)) {
                name <- paste(i, l, sep = '.')
                if (name %in% names(df)) {
                    stop('Cannot dichotomize factor "', i, '": ', ' column "', name, '" already exists')
                }
                df[[name]] <- as.integer(v == l)
            }
        } else {
            stop('Cannot convert the column "', i, '" to numeric')
        }
    }
    df <- as.data.frame(df)
    attr(df, 'row.names') <- attr(x, 'row.names')

    # ensure colnames are unique
    assert_that(all(!duplicated(colnames(x))))

    # ensure y is either numeric or a factor
    if (!is.factor(y) && !is.numeric(y)) {
        y <- factor(y)
    }

    structure(list(y = y, x = df),
              class = 'woods_data')
}


#' @export
is.woods_data <- function(x) {
    inherits(x, 'woods_data')
}


#' @export
`[.woods_data` <- function(x, i, j, drop=FALSE) {
    if (drop) warning('drop ignored')

    x$y <- x$y[i]
    x$x <- x$x[i, j, drop=FALSE]

    x
}
