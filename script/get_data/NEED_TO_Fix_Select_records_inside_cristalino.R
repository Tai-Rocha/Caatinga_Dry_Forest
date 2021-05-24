#############################################################
## Select only records inside Cristalino shape counties
## Using sf pckg funtions
## Author script : Tainá Rocha
## Date: 22 May 2021
#############################################################
#Library

library(sf)
library(raster)
library(rgdal)

### Gibif  records

gbif_shp <- readOGR("./data/rgbif_arbusto_arboreo/gbif_arbusto_arboreo.shp")

gbif_sf <- st_as_sf(gbif_shp)

## Cristalino Shape

cristalino_shp <- readOGR("./data/shape/mun_caatinga_cristalino.shp")
cristalino_sf <- st_as_sf(cristalino_shp)


## sg unin = dissolve

gbif_dissolve <- st_union(gbif_sf)

records_cristalino <- st_intersection(gbif_dissolve, cristalino_sf)

records_cristalino_2 <- st_collection_extract(records_cristalino, "POINT")


st_write(records_cristalino_2, "./data/shape/cristalino_records.shp", driver = "ESRI Shapefile")

plot(records_cristalino_2)







