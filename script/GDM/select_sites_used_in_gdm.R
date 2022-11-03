#############################
# 
# R version 4.2.1
# 
# Linux 
#############################

library(dplyr)
library(sf)


ssites = st_read("results/join_maps/join_sitios_spss.shp")
#plot(ssites)

gdm_sites = ssites |> 
  group_by(id) |> 
  mutate(Len = n()) |> 
  filter(Len > 49) |> 
  ungroup()

st_write(gdm_sites, "results/join_maps/site_used_GDM.shp")
  
gdm_sites_n = ssites |> 
  group_by(id) |> 
  mutate(Len = n()) |> 
  filter(Len > 49) |> 
  ungroup() |> 
  count(id)