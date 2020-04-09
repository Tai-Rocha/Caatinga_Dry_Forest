############################
## Extrac values to point
###########################

# Library pckgs

library(raster)
library(maptools)
library(rgdal)

# Read csv input table

pontos <- read.csv("./data/pe.csv", sep = ",")

## Read Pernambuco shapefile

PE <- readOGR("./data/shape_pe/26MUE250GC_SIR.shp")

## Read and crop variables to Pernambuco state

## List worldclim variables in the folder

list_worldclim<-list.files(path="./data/variables_worldclim/",
                 pattern="asc",
                 full.names=TRUE)

### Build a stack (one object with all layers) 
variables_wc <- stack(list_worldclim)


## Crop
wc_pe <- crop(variables_wc, PE)

## extract


## Write 

write.table(pts, file = ".dados/wc_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")


## List inpe variables (altitude and slope) in the folder

list_inpe<-list.files(path="./data/variables_inpe/",
                           pattern="asc",
                           full.names=TRUE)

### Build a stack (one object with all layers) 
variables_inpe<-stack(list_inpe)

## Crop
inpe_pe <- crop(variables_inpe, PE)

## Write 

write.table(pts, file = ".dados/inpe_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")



