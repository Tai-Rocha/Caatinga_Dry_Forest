##########################################################
# Descriptive statiscal for Baelga and GDM
# R version 4.2.2
# Author code: Tainá Rocha
# Linux 
##########################################################

library(dplyr)

# Read data

gdm_sp = read.csv("data/GDM_inputs/SPP_DATA_v2.csv")

# use group_by and summarize to count the number of unique species per site, including repeats

gdm_summary = gdm_sp |> 
  dplyr::group_by(sites) |> 
  dplyr::summarize(total_species = n())

# use filter to select sites with more than 50 species
gdm_filtered = gdm_summary |> 
  filter(total_species >= 50)

# select only the sites column from the filtered dataframe
selected_sites = gdm_filtered$sites

# create a new dataframe with only the rows corresponding to the selected sites
gdm_final_sp_sites_selected = gdm_sp |> 
  filter(sites %in% selected_sites)

#write.csv(gdm_final_sp_sites_selected, "results/Descriptive_Baselga_GDM_2023/sites_gdm_50sps.csv")

# create a new dataframe with unique species
gdm_unique_species = gdm_final_sp_sites_selected |> 
  distinct(species)

write.csv(gdm_unique_species, "results/Descriptive_Baselga_GDM_2023/UNIQUE SPECIES_GDM.csv")

# create a new dataframe with unique species with lat long

gdm_unique_species_lat_long = gdm_final_sp_sites_selected |> 
  distinct(species, LONG, LAT)

write.csv(gdm_unique_species_lat_long, "results/Descriptive_Baselga_GDM_2023/SPECIES_GDM_LAT_LONG.csv")


##### Test 2
gdm_summary = gdm_sp |> 
  dplyr::group_by(sites) |> 
  dplyr::summarize(unique_species = dplyr::n_distinct(species))

# use filter to select sites with more than 50 unique species
gdm_filtered = gdm_summary |> 
  dplyr::filter(unique_species >= 50)

# print the sites with more than 50 unique species
cat("Sites with more than 50 unique species:\n")
cat(df_filtered$sites)

##################### Test 1

## Select sites more than 50 species

gdm_sp_filtered = gdm_sp |> 
  dplyr::group_by(sites) |>
  dplyr::filter(dplyr::n_distinct(species) >= 50)


# count the number of unique sites
gdm_sites_filtered = dplyr::n_distinct(gdm_sp_filtered$sites)

# print the number of unique sites
cat("Number of unique sites with more than 50 species:", gdm_sites_filtered)


###########################

# use group_by and filter to select sites with more than 50 species
sites_filtered = gdm_sp |> 
  dplyr::group_by(sites) |> 
  dplyr::filter(dplyr::n_distinct(species) >= 50)

# print the sites with more than 50 species
cat("Sites with more than 50 species:\n")
cat(unique(sites_filtered$sites))

write.csv(sites_filtered, "results/Descriptive_Baselga_GDM_2023/sites_gdm_50sps.csv")
