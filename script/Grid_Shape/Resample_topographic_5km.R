####################################################
## Resample raster from 1km to 5 km
## Author: Tainá Rocha
## Data: 26 Apriel 2021
####################################################


library(raster)

## Load Refernce map of 5km resolution
reference_map <- raster("./data/Envs_GDM/5km/bio5.tif")

plot(reference_map)

## List topographics envs of 1km

lista_topographic <- list.files("./data/Envs_GDM/Topographic_1km/", full.names = T, pattern = ".tif")

## Put together (stack)
topo <-stack(lista_topographic)

plot(topo)


## Resample
topo_5km <- resample(topo, reference_map, method = "bilinear")

plot(topo_5km)


## Write Ratser

writeRaster(topo_5km, filename = names(topo), format = "GTiff", bylayer = T)
 