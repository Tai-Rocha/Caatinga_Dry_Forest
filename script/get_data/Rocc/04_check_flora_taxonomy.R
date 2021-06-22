# Script to check taxonomy
# Check routine:
# get synonyms from Flora 2020
# 1. Flora 2020
# 2. Kew - World Checklist of Vascular Plants
# 3. TNRS - Taxonomic Name Resolution Service
## 4.02 R version


library(dplyr)
library(flora)
library(rocc)
library(parallel)

# reading file
plan_03 <- read.csv("./results/03_taxon_data_raw_check.csv", as.is = TRUE)

head(plan_03)

tax_ok <- plan_03 %>% filter(check_ok == "ok")

scientificName <- unique(tax_ok$species)
length(scientificName)

# 1. suggesting a name ####
# using parallel

# Calculate the number of cores
no_cores <- detectCores() - 1
# Initiate cluster
cl <- makeCluster(no_cores)

start_time <- Sys.time()
list_taxa <- parLapply(cl, scientificName, suggest_flora)
end_time <- Sys.time()

t1 <- end_time - start_time

stopCluster(cl)

suggest_taxa <- bind_rows(list_taxa)

search_taxa <- suggest_taxa$species %>%
  unique() %>%
  na.omit()

##

search_taxa_2 <- search_taxa[1:5000]



search_df <- data.frame(species = search_taxa,
                        search_id = 1:length(search_taxa))
# 2. checking if the name exists in Brazilian Flora ####

flora_taxa <- list()
##
for (i in 1:length(search_taxa_2)) {
  message(paste(i, "species"))
  flora_taxa[[i]] <- check_flora(search_taxa_2[i],
                                 get_synonyms = FALSE,
                                 infraspecies = TRUE)
}

length(flora_taxa)

flora_taxa2 <- lapply(flora_taxa, function(x) x[1]$taxon)

flora_df <- bind_rows(flora_taxa2)

head(flora_df)

table(flora_df$taxonomicStatus)

flora_df2 <- left_join(flora_df, search_df, by ="species")

# writing output
write.csv(flora_df2,
          file = "./results/04_taxon_data_flora_check.csv",
          row.names = FALSE)
