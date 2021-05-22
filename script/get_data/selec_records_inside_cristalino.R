#############################################################
## Select only records inside Cristalino shape counties
## Author script : Tainá Rocha
## Date: 22 May 2021
#############################################################

## Read Caatinga Cristalino shapefile via rgdal 

cristalino_shp <- readOGR("./data/shape/mun_caatinga_cristalino.shp")
plot(cristalino_shp)

## Read gbif list arbustivo arboreo shapefile via rgdal 

gbif_shp <- readOGR("./data/rgbif_arbusto_arboreo/gbif_arbusto_arboreo.shp")
#plot(gbif_shp)


### Select records inside Cristalino

gbif_cristalino <- gbif_shp[cristalino_shp, ]

plot(gbif_cristalino)

writeOGR(gbif_cristalino, "./data/shape/cristalino_records_arbu_arbo_gbif.shp", layer = "cristalino_records_arbu_arbo_gbif.shp", driver = "ESRI Shapefile")
