##########################################
## GDM input from Join file
##
##########################################

## Library
library(sf)
library(tidyverse)
library(dplyr)
library(foreign)

##### Read 
join <- read.dbf("./data/shape/join_cristalino_grid.dbf")

## Suitable file for tidyverse
join_2 <- as_tibble(join)

## Select columns for GDM input with id
input_gdm_id <- join_2 %>% select(species, id, decimalLon, decimalLat, gbifID)

write_csv(input_gdm_id, "./data/GDM_INPUTS/SPP_DATA_id_v2.csv")

## Pre input input for GDM
input_gdm <- join_2 %>% select(species, id, decimalLon, decimalLat)

## Rename columns, final input
gdm_input_final <- rename(input_gdm, sites = id, LONG = decimalLon, LAT = decimalLat)


# Write final input
write_csv(gdm_input_final, "./data/GDM_INPUTS/SPP_DATA_v2.csv")





