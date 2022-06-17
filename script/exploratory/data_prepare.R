############################################
# Enviromental values of species points 
# Author: Tainá Rocha
###########################################

##################
# Library
library(dplyr)
library(raster)
library(rgdal)
library(sp)
library(tidyr)

##################

### Load Points

sp_lonlat<- read.csv("data/sp_lon_lat/sp_lon_lat.csv", sep = ",", dec = ".")

points <- as.data.frame(sp_lonlat)

points_2 <- sp::SpatialPointsDataFrame(points[,-1], points[,-1])

unique_points <- sp::remove.duplicates(points_2)

coord <- as.data.frame(unique_points@coords)

coordinates(coord) <- ~ decimalLon+ decimalLat

# remover registros duplicados
#dups.all <- duplicated(caatinga_pontos[, c('LAT', 'LONG')])
#caatinga_pontos_final <- caatinga_pontos[!dups.all, ]


##### Extract values from point (require a file in format long lat respectively to use extract funtion)

list_envs <- list.files ("data/Envs/5min/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

## Extract envirometal values

#values_in_coord <- extract(envs, points_cc[4:5])
#write.csv(values_in_coord, "./data/tables/GDM_INPUT/env_values_in_coord.csv", sep = ",")


values_in_coord_bi <- raster::extract(envs, coord@coords, method = 'bilinear')

write.csv(values_in_coord_bi, "./data/PCA/env_values_in_coord_bilinear.csv", sep = ",")


#### Remove NA from
input_pca <- readr::read_csv("./data/PCA/env_values_in_coord_bilinear.csv")

# noNA_pca <- na.omit(input_pca) # Not work 

#noNA_pca <- input_pca[complete.cases(input_pca), ] # Not work 

noNA_pca <- input_pca %>% drop_na()     
noNA_pca 

write.csv(noNA_pca, "./data/PCA/env_values_in_coord_bilinear_NONA.csv", sep = ",")


################## Get envirometal data of grid 

cristalino_grids<- readOGR("./data/shape/grids_cristalino.shp")

envs_grids <- getValues(envs) |>  
  as_tibble() |> 
  drop_na() 


df <- as.data.frame(envs_grids)

df_final <- lapply(df, unique)

#df_test <- apply(df,2, unique) # works 

## Bind list

output <- do.call(cbind, df_final)

write.csv(output, "./data/PCA/env_values_in_GRIDS_bilinear_NONA.csv", sep = ",")

write.csv(output, "./data/PCoA/env_values_in_GRIDS_bilinear_NONA.csv", sep = ",")
