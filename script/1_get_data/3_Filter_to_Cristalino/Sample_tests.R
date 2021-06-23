library(rgdal)
library(sf)
library(tidyverse)
library(dplyr)


##### Read 
## Read shape 

sample_points <- readOGR("./data/shape/sample_test_spps.shp")
cristalino <- readOGR("./data/shape/mun_caatinga_cristalino.shp")
grid_5 <- readOGR("./data/shape/grid_5km.shp")

#plot(grid_5); points(sample_table)

## Exmaple 1

## convert it to 'sf'

pontos = st_as_sf(sample_points, coords = c("coords.x1", "coords.x2"), crs = 4326)
cristalino_2 = st_as_sf(cristalino)

## intersect polygons with points, keeping the information from both

pontos_no_cristalino = st_intersection(cristalino_2, pontos)

## transform into a 'data.frame' by removing the geometry
st_geometry(pontos_no_cristalino) = NULL
head(pontos_no_cristalino)

#write.csv(pontos_no_cristalino, "./antes_sf_points.csv")

########################################### Spatial Joint test ########################################### 
###########################################  using "sf" pckg   ########################################### 

cristalino_points <- st_as_sf(pontos_no_cristalino, coords = c("LONGITUDE", "LATITUDE"), crs =4326)

#write.csv(cristalino_points, "./sf_points.csv")

grid_sf_5km <- st_as_sf(grid_5)

## Verify the CRS for both objects
st_crs(cristalino_points)

st_crs(grid_sf_5km)


# CRS for grid_5km object

#st_crs(grid_5km) <- 4326  

#grid_5km_final <- as_Spatial(grid_5km) 

## Spatial Join
join_test <- st_join(cristalino_points, grid_sf_5km, join = st_within , suffix = c("decimalLon", "decimalLat"),
        prepared = TRUE, left = TRUE)

write.csv(join_test, "./join_test.csv")



# First time I trie to do all for R : open csv sample, convert in spatial data, cut it for caatinga cristalino shape and then do spatial with grid shape 5km)
# But there are two issues (NAs and strings in decimalLongitude and decimalLatitude cols) in table that I fix faster in SIG 
#sample_table <- read.csv("./test_3.csv")

## Remove NA rows from decimalLongitude and decimalLatitude cols in sample table


#Select only the rows that contain a number in specific column .

#sample_table_2 <- sample_table[grep("[[:digit:]]", sample_table$decimalLongitude), ]

#rm(sample_table_2)

## It should be work for rows which contains NA values, but in this dataframe contains string in some rows..  
##Ps.: filter_at for more than on var in data-frame

#sample_table_2 <- sample_table %>%
#filter_at(vars(decimalLongitude, decimalLatitude), any_vars(!is.na(.)))


## Example 2 ## I'm not test this

#o = overlay(pts, polys)
#pts@data = cbind(pts@data, polys[o,])

###############################################
###############################################
# Qgisprocessing tests 
###############################################
###############################################



## Dissolve
gbifdissolve <- qgis_run_algorithm(
  "gdal:dissolve",
  INPUT = gbif_sf,
  #FIELD = gbif_sf$gbifID,
  #GEOMETRY = gbif_sf$gbifID,
  EXPLODE_COLLECTIONS = 0,
  KEEP_ATTRIBUTES = 1,
  COUNT_FEATURES = 1,
  COMPUTE_AREA = 0,
  COMPUTE_STATISTICS = 0,
  STATISTICS_ATTRIBUTE = 0,
  OPTIONS = 0,
  OUTPUT = "./datadissolvegbif.shp",
  .complete_output = FALSE
)
plot(gbifdissolve)
## CLip
gbifclip <- qgis_run_algorithm(
  "gdal:clipvectorbypolygon",
  INPUT = gbif_shp,
  MASK = cristalino_shp,
  #Dissolve = T,
  OPTIONS = 1,
  OUTPUT = "./clipgbif.shp",
  #.complete_output = TRUE
)




qgis_show_help("native:joinattributesbylocation")

qgis_joinattributesbylocation(
  INPUT = qgisprocess::qgis_default_value(),   #All points shapes
  JOIN = qgisprocess::qgis_default_value(),    #Shape with right extent (Caatinga- Cristalino)
  PREDICATE = qgisprocess::qgis_default_value(), #
  JOIN_FIELDS = qgisprocess::qgis_default_value(),
  METHOD = qgisprocess::qgis_default_value(),
  DISCARD_NONMATCHING = qgisprocess::qgis_default_value(),
  PREFIX = qgisprocess::qgis_default_value(),
  OUTPUT = qgisprocess::qgis_default_value(),
  NON_MATCHING = qgisprocess::qgis_default_value(),
  .complete_output = TRUE)





#qgis_show_help("native:buffer")
#print(qgis_algorithms(), n=604)

qgis_configure()
qgis_algorithms()
options(qgisprocess.path = "path/to/qgis_process")

input <- sf::read_sf(system.file("shape/nc.shp", package = "sf"))
result <- qgis_run_algorithm(
  "native:buffer",
  INPUT = input,
  DISTANCE = 1,
  DISSOLVE = TRUE,
  .quiet = TRUE
)

output_sf <- sf::read_sf(qgis_output(result, "OUTPUT"))
plot(sf::st_geometry(output_sf))


