library(rmake)
library(tidyverse)



computationGrid <- expand.grid(METHOD = c('woods', 'rf'),
                               DATA = c('iris|Species|class',
                                        'GermanCredit|Class|class',
                                        'CO2|uptake|regr',
                                        'ChickWeight|weight|regr',
                                        'Sacramento|price|regr',
                                        'scat|Species|class',
                                        'segmentationData|Class|class',
                                        'BostonHousing|medv|regr',
                                        'BreastCancer|Class|class',
                                        'DNA|Class|class',
                                        'Glass|Type|class',
                                        'Ionosphere|Class|class',
                                        'PimaIndiansDiabetes|diabetes|class',
                                        'Satellite|classes|class',
                                        'Servo|Class|class',
                                        'Shuttle|Class|class',
                                        'Sonar|Class|class',
                                        'Soybean|Class|class',
                                        'Vehicle|Class|class',
                                        'Zoo|type|class'),
                               stringsAsFactors = FALSE) %>%
    separate('DATA', c('DATA', 'TARGET', 'TYPE')) %>%
    filter(TYPE == 'class')

computationTemplate <- c('TOUCH.ME' %>>%
    rRule('compute.R', params = list(method = '$[METHOD]', data = '$[DATA]', target = '$[TARGET]')) %>>%
    'trained_$[TYPE]_$[METHOD]_on_$[DATA].rds')



#reportGrid <- computationGrid[duplicated(computationGrid$DATA), -1]

#reportTemplate <- c(paste0('trained_$[TYPE]_', unique(computationGrid$METHOD), '_on_$[DATA].rds') %>>%
    #markdownRule('report.Rmd') %>>% 'report_$[DATA].pdf')



computations <- expandTemplate(computationTemplate, computationGrid)
#reports <- expandTemplate(reportTemplate, reportGrid)
job <- c(computations,
         terminals(computations) %>>% markdownRule('summary.Rmd') %>>% 'summary.pdf')

makefile(job, "Makefile")
