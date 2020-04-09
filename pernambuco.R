############################################
## Data prepare for Extrac values to point
############################################

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
wc_pe <- crop (variables_wc, PE)

## Extract values from worldclim variables to ponit
vals_wc <- extract(wc_pe, pontos)
summary(vals_wc)

## Write table

write.table(vals_wc, file = ".dados/wc_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")


## List inpe variables (altitude and slope) in the folder

list_inpe<-list.files(path="./data/variables_inpe/",
                           pattern="asc",
                           full.names=TRUE)

### Build a stack (one object with all layers) 
variables_inpe<-stack(list_inpe)

## Crop
inpe_pe <- crop(variables_inpe, PE)

## Extract values from worldclim variables to ponit
vals_inpe<- extract(inpe_pe, pontos)
summary(vals_wc)

## Write table

write.table(vals_inpe, file = ".dados/inpe_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")


########################### End
