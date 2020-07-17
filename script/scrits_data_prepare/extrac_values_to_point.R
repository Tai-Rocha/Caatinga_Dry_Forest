######################
# Estudando os pontos
#Author: Tainá Rocha
#Date: 07 May 2020
#####################

## Library

library(raster)
##################

### Load Points

caatinga_pontos <- read.csv("./data/tables/caatinga_long_lat.csv", sep = ",", dec = ".")

# remover registros duplicados
dups.all <- duplicated(caatinga_pontos[, c('Longitude', 'Latitude')])
caatinga_pontos_final <- caatinga_pontos[!dups.all, ]


##### Extract values from point (require a file in format long lat respectively to use extract funtion)

list_envs <- list.files ("./data/Envs_caatinga/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

# Extract values from point

values_in_coord <- extract(envs, caatinga_pontos_final[,-1])

write.table(values_in_coord, "./data/tables/caatinga_values_in_coord.txt")

