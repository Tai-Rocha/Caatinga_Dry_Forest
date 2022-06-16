############################################
# Enviromental values of species points 
# Author: Tainá Rocha
###########################################

##################
# Library

library(raster)
library(sf)
library(tidyverse)
library(dplyr)
library(foreign)

##### Read 
sp_lon_lat <- readr::read_csv("./data/GDM_inputs/SPP_DATA_id_v1.csv")

dplyr::glimpse(sp_lon_lat)
# remover registros duplicados
#dups.all <- duplicated(caatinga_pontos[, c('LAT', 'LONG')])
#caatinga_pontos_final <- caatinga_pontos[!dups.all, ]


##### Extract values from point (require a file in format long lat respectively to use extract funtion)

list_envs <- list.files ("./data/Envs/5min/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

# Extract values from point

#values_in_coord <- extract(envs, points_cc[4:5])
#write.csv(values_in_coord, "./data/tables/GDM_INPUT/env_values_in_coord.csv", sep = ",")

values_in_coord_bi <- extract(envs, sp_lon_lat[4:5], method= 'bilinear')

write.csv(values_in_coord_bi, "./data/GDM_inputs/env_values_in_coord_bilinear.csv", sep = ",")


