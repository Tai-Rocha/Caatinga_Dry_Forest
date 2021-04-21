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
