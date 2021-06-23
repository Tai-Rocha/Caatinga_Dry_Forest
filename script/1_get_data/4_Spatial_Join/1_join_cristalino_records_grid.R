##########################################
## Spatial Joing
## 
## Author scripts : Tainá Rocha
## Date: 23 May 2021
##########################################


## Library
library(sf)
library(raster)
library(rgdal)

### Gbif records inside Cistalino  shape

cristalino_gbif_shp <- readOGR("./data/sp_list_version_jun_2021/gbif_cristalino_arbus_arbor.shp")

sf_cristalino_gbif <- st_as_sf(cristalino_gbif_shp)


## Grid 5km 
grid_10 <- readOGR("./data/Shape_Grid/grid_10km.shp")

sf_grid_10km <- st_as_sf(grid_10)

##
join <- st_join(sf_cristalino_gbif, sf_grid_10km, join = st_within , suffix = c("decimalLon", "decimalLat"),
                     prepared = TRUE, left = TRUE)

st_write(join, "./data/Shape_Join_CristalinoPoints_Grid10/join_PointsCristalino_Grid10.shp", driver = "ESRI Shapefile")

