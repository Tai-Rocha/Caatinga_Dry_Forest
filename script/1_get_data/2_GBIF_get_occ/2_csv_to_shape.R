#############################################################
## Convert GBIF list (gbig_arbustu_arbore.csv) to shapefile 
## Author script : Tainá Rocha
## Date : 22 May 2021
#############################################################


#Library
library(raster)
library(rgdal)
library(sf)
library(tidyverse)
library(dplyr)

#### Read CSV

gbif_arbusto_arboreo <- read.csv("./data/sp_list_version_jun_2021/0309500-200613084148143.csv", sep = "\t")


## Using relocate to set Long before Lat

gbif_arbusto_arboreo <- gbif_arbusto_arboreo |>  
                        relocate(decimalLongitude, .before = decimalLatitude )


## Get long and lat from your data.frame. Make sure that the order is in lon/lat.

xy <- gbif_arbusto_arboreo[,c(22,23)]

## Covert non numerical string to NA

xy_2 <- na_if(xy, "")

xy_3 <- na_if(xy_2, "COORDINATE_ROUNDED;GEODETIC_DATUM_ASSUMED_WGS84")

xy_4 <- na_if(xy_3, "F. Zenteno-R")

xy_5 <- na_if(xy_4, "Rio de Janeiro Botanical Garden")

## Remove NAs

xy_6 <- xy_5 %>% drop_na()

##
gbif_spatial <- SpatialPointsDataFrame(coords = gbif_arbusto_arboreo[22,23], data = gbif_arbusto_arboreo[22,23],
                                 proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))



class(gbif_arbusto_arboreo[22,23])
# Convert a shape using sf pckg
st_write(gbif_arbusto_arboreo, "gbif_arbusto_arboreo.shp") # I tried to save as .shp but the output was saved as .dbf 

# Read shape with sf pckg
shape_gbif <- read_sf("./gbif_arbusto_arboreo.dbf")





## Save againg

writeOGR(gbif_arbusto_arboreo,"./data/shape/gbif_arbusto_arboreo.shp", driver="ESRI Shapefile")

#shape_gbif <- readOGR("./gbif_arbusto_arboreo.dbf", "gbif_arbusto_arboreo") # I tried to read via rgdal, but not work

