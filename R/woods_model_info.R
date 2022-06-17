.miParameters <- data.frame(parameter = c('mtry'),
                            class = c('numeric'),
                            label = c('mtry'))


.miGrid <- function(x, y, len = NULL, search = 'grid') {
    expand.grid(mtry = 2:5)
}


.miFit <- function(x, y, wts, param, lev, last, weights, classProbs, ...) {
    woods::woods(y = y,
                 x = as.data.frame(x),
                 n_tree = 500,
                 mtry = param$mtry)
}


.miPredict <- function(modelFit, newdata, preProc = NULL, submodels = NULL) {
    predict(object = modelFit,
            newdata = as.data.frame(newdata))
}


.miSort <- function(x) {
    x[order(x$mtry), ]
}


.miLevels <- function(x) {
    x$levels
}


#' @export
woodsModelInfo <- list(type = c('Classification', 'Regression'),
                       library = 'woods',
                       loop = NULL,
                       parameters = .miParameters,
                       grid = .miGrid,
                       fit = .miFit,
                       predict = .miPredict,
                       prob = NULL,
                       sort = .miSort,
                       levels = .miLevels)
