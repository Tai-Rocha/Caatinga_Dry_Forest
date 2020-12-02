######################
# Estudando os pontos
#Author: Tainá Rocha
#####################

## Library

library(raster)
##################

### Load Points

caatinga_pontos <- read.csv("./data/tables/New/vars_in_cood/vals_in_coord_input.csv", sep = ",", dec = ".")

# remover registros duplicados
dups.all <- duplicated(caatinga_pontos[, c('LAT', 'LONG')])
caatinga_pontos_final <- caatinga_pontos[!dups.all, ]


##### Extract values from point (require a file in format long lat respectively to use extract funtion)

list_envs <- list.files ("./data/Envs_caatinga/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

# Extract values from point

values_in_coord <- extract(envs, caatinga_pontos[3:4])

write.table(values_in_coord, "./data/tables/New/vars_in_cood/caatinga_values_in_coord.txt")

