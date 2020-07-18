#################################
## Data prepare for PCA and NMDS
## setud_sdmadata funciton
## Author: Tainá Rocha
#################################

###### Library

library(raster)
library(modleR)
###################################

### Load and stack enviromental variables for analysis

list_envs <- list.files("./data/Envs_caatinga/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

### Load the data (input log lat table)

caatinga_points <- read.csv("./data/tables/input_data_prepare_for_PCA/setup_sdmdata_input_caatinga2.csv", sep=",", dec = ".")


#### setup_sdmdata

setup_sdmdata(species_name = unique(caatinga_points[2]),
              occurrences = caatinga_points[,3:4], 
              predictors = envs, 
              lon = "Longitude", 
              lat = "Latitude", 
              models_dir = "./results/cleanning", 
              real_absences = NULL, 
              buffer_type = NULL, 
              dist_buf = NULL, 
              env_filter = FALSE, 
              env_distance = "centroid", 
              buffer_shape = NULL, 
              min_env_dist = NULL, 
              min_geog_dist = NULL,
              write_buffer = FALSE, 
              seed = NULL, 
              clean_dupl = TRUE, 
              clean_nas = TRUE, 
              clean_uni = TRUE, 
              geo_filt = FALSE, 
              geo_filt_dist = NULL, 
              select_variables = FALSE, 
              cutoff = 0.1, 
              sample_proportion = 0.1, 
              png_sdmdata = TRUE, 
              n_back = 3, 
              partition_type = c("bootstrap"), 
              boot_n = 1, 
              boot_proportion = 0.7, 
              cv_n = NULL, 
              cv_partitions = NULL)


