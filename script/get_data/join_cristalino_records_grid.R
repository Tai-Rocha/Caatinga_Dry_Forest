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

cristalino_gbif_shp <- readOGR("./data/shape/cristalino_records_arbu_arbo_gbif.shp")

sf_cristalino_gbif <- st_as_sf(cristalino_gbif_shp)


## Grid 5km 
grid_5 <- readOGR("./data/shape/grid_5km.shp")

sf_grid_5km <- st_as_sf(grid_5)

##
join_test <- st_join(sf_cristalino_gbif, sf_grid_5km, join = st_within , suffix = c("decimalLon", "decimalLat"),
                     prepared = TRUE, left = TRUE)

st_write(join_test, "./data/shape/join_cristalino_grid.shp", driver = "ESRI Shapefile")

