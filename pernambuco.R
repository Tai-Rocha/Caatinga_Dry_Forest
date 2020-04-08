
############################
## Extrac values to point
###########################

# Library pckgs

library(raster)
library(maptools)

# Read csv input table

pontos <- read.csv(file.choose(), header=T)


## Read and crop variables to Pernambuco state
## List the variables in the folder

list<-list.files(path="predictors/proj_current/",
                 pattern="asc",
                 full.names=TRUE)

### Build a stack (one object with all layers) 
variables<-stack(list)

