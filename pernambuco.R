############################################
## Data prepare for Extrac values to point
############################################

# Library pckgs

library(raster)
library(rgdal)

# Read csv input table

pontos <- read.csv("./data/tables/pe.csv", sep = ",")

## Read Pernambuco shapefile

PE <- readOGR("./data/shape_pe/26MUE250GC_SIR.shp")

## Read and crop variables to Pernambuco state

## List inpe variables (altitude and slope) in the folder

list_inpe<-list.files(path="./data/variables_inpe/",
                      pattern="tif",
                      full.names=TRUE)

### Build a stack (one object with all layers) 
variables_inpe<-stack(list_inpe)

## Crop

inpe_pe <- crop(variables_inpe, PE)
plot(inpe_pe)


## Extract values from inpe variables to ponit

vals_inpe<- extract(inpe_pe, pontos[,-1])

sum_inpe_vals <- summary(vals_inpe)

## Write table

write.table(vals_inpe, file = "./results/inpe_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")
write.table(sum_inpe_vals, file = "./results/sum_inpe_vals.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")

## List worldclim variables in the folder

list_worldclim<-list.files(path="./data/variables_worldclim/",
                 pattern="tif",
                 full.names=TRUE)

### Build a stack (one object with all layers) 
variables_wc <- stack(list_worldclim)

## Crop
wc_pe <- crop (variables_wc, PE)
plot(wc_pe)

## Extract values from worldclim variables to ponit
vals_wc <- extract(wc_pe, pontos[,-1])
sum_wc_vals <- summary(vals_wc)

## Write table

write.table(vals_wc, file = "./results/wc_values.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")
write.table(sum_wc_vals, file = "./results/sum_wc_vals.csv", col.names = TRUE, row.names=FALSE, na="", sep = ",")


########################### End
