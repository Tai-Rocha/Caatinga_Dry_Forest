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
join <- readr::read_csv("./results/join_maps/Final_Join_sps_grid_preinput_GDM.csv")

## Suitable file for tidyverse
join_2 <- as_tibble(join)

dplyr::glimpse(join_2)

## Select columns for GDM input with id
input_gdm_id <- join_2 %>% select(species, gbifID, site_id, decimalLon, decimalLat, gbifID)

dplyr::glimpse(input_gdm_id)

write_csv(input_gdm_id, "./data/GDM_inputs/SPP_DATA_id_v1.csv")

## Pre input input for GDM
input_gdm <- join_2 %>% select(species, site_id, decimalLon, decimalLat)

## Rename columns, final input
gdm_input_final <- rename(input_gdm, sites = site_id, LONG = decimalLon, LAT = decimalLat)


# Write final input
write_csv(gdm_input_final, "./data/GDM_inputs/SPP_DATA_v2.csv")





