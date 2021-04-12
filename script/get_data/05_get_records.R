# Download species records
# get from each database, then merge final results

library(Rocc)
library(dplyr)
library(tidyverse)

# reading final species list
spp <- read.csv("./results/04_taxon_data_flora_check.csv")

spp2 <- as.character(unique(spp$species))

#records <- rspeciesLink(dir = "results/spp_records/",
#                        filename = "records_specieslink",
#                        species = spp2,
#                        Scope = "plants")
#
#

records_list <- list()

for (i in 1:length(spp2)) {
  message(paste(i, "species"))
  records_list[[i]] <- rspeciesLink(species = spp2[[i]],
                                    Scope = "plants")
}


#records <- rspeciesLink(dir = "./results/spp_records/",
#                        filename = "records_specieslink",
#                        species = spp2[1:19],
#                        Scope = "plants")

#records_1 <- purrr::map(spp2, rspeciesLink(dir = "./results/spp_records/",
#                                                       filename = "records_specieslink"))