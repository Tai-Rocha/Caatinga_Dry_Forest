library(dplyr)
library(sf)

## 1

matrix = read.csv("data/betapart_Input/betapart_input.csv", sep = " ")

###

test = t(matrix_similaridade_cristalino_[-1])

test_2 = colSums(test[,-1])

test_3 = as_data_frame(test_2)

## 1 FInal species count 
all_sp_cristalino = sf::read_sf("results/join_maps/sps_critalino_shape.shp") |> 
  as.data.frame() |> 
  select(species) |> 
  n_distinct()


## 2 SP in Protected areas

sp_cristalino_uc = sf::read_sf("results/join_maps/sp_in_UCs.shp") |> 
  as.data.frame() |> 
  select(species) |> 
  n_distinct()

