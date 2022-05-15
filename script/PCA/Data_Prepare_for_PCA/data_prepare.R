#################################
## Data prepare for PCA and NMDS
## setud_sdmadata funciton
## Author: Tainá Rocha
#################################

###### Library

library(raster)
library(sp)
library(tidyr)
###################################

### Load and stack enviromental variables for analysis

list_envs <- list.files("data/Envs/2_5/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

### Load the data (input log lat table)

caatinga_points <- read.csv("./data/PCA/pre_PCA.csv", sep=",", dec = ".")

points <- as.data.frame(caatinga_points)

points_2 <- sp::SpatialPointsDataFrame(points[,-1], points[,-1])

unique_points <- sp::remove.duplicates(points_2)

coord <- as.data.frame(unique_points@coords)

coordinates(coord) <- ~ decimalLon+ decimalLat

## Extract envirometal values

#values_in_coord <- extract(envs, points_cc[4:5])
#write.csv(values_in_coord, "./data/tables/GDM_INPUT/env_values_in_coord.csv", sep = ",")

values_in_coord_bi <- extract(envs, coord@coords, method= 'bilinear')

write.csv(values_in_coord_bi, "./data/PCA/env_values_in_coord_bilinear.csv", sep = ",")


#### Remove NA from
input_pca <- readr::read_csv("./data/PCA/env_values_in_coord_bilinear.csv")

# noNA_pca <- na.omit(input_pca) # Not work 

#noNA_pca <- input_pca[complete.cases(input_pca), ] # Not work 

noNA_pca <- input_pca %>% drop_na()     
noNA_pca 

write.csv(noNA_pca, "./data/PCA/env_values_in_coord_bilinear_NONA.csv", sep = ",")
