#############################################################
## Select only records inside Cristalino shape counties
## Author script : Tainá Rocha
## Date: 22 May 2021
#############################################################


#Library

library(raster)
library(rgdal)
library(sf)


## Log collector
#log_open(file_name = "", logdir = TRUE, show_notes = TRUE, autolog = TRUE)

## Read Caatinga Cristalino shapefile via rgdal 

cristalino_shp <- readOGR("./data/Shape_Mun_Cristalino/mun_caatinga_cristalino.shp")

## Read gbif list arbustivo arboreo shapefile via rgdal 

gbif_shp <- readOGR("./data/sp_list_version_jun_2021/gbif_raw_arbus_arbor.shp")


### Select records inside Cristalino

gbif_cristalino <- gbif_shp[cristalino_shp, ]

#plot(gbif_cristalino)

log_print(gbif_cristalino)

## Write new shapefile
writeOGR(gbif_cristalino, "./data/sp_list_version_jun_2021/gbif_cristalino_arbus_arbor.shp", layer = "cristalino_records_arbu_arbo_gbif.shp", driver = "ESRI Shapefile")


### Go To Provenac_Log script to finhed 
