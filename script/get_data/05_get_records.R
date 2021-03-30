# Download species records
# get from each database, then merge final results

library(Rocc)
library(dplyr)
library(tidyverse)

# reading final species list
spp <- read.csv("./results/03_taxon_data_raw_check.csv")

spp2 <- as.list(spp$species)

test <- map(spnames)
  
ssp2 <- as.vector(spp2)


records <- rspeciesLink(dir = "./results/spp_records/",
                        filename = "records_specieslink",
                        species = spnames[1:10],
                        Scope = "plants")


teste <- spnames[1:72374] %>%
  map(rspeciesLink)
