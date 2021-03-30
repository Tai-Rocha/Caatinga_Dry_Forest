# Download species records
# get from each database, then merge final results

library(Rocc)
library(dplyr)
library(tidyverse)

# reading final species list
spp <- read.csv("./results/04_taxon_data_flora_check.csv")

spp2 <- unique(spp$species)

records_list <- list()

for (i in 1:length(spp2)) {
  message(paste(i, "species"))
  records_list[[i]] <- rspeciesLink(species = spp2,
                                    Scope = "plants")
}

records <- rspeciesLink(dir = "./results/spp_records/",
                        filename = "records_specieslink",
                        species = spnames[1:10],
                        Scope = "plants")


for (i in 1:length(search_taxa)) {
  message(paste(i, "species"))
  flora_taxa[[i]] <- check_flora(search_taxa[i],
                                 get_synonyms = FALSE,
                                 infraspecies = TRUE)
}
