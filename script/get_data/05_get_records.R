# Download species records
# get from each database, then merge final results

library(Rocc)
library(dplyr)
library(tidyverse)
library(erer)

# reading final species list
spp <- read.csv("./results/04_taxon_data_flora_check.csv")

spp1 <- spp %>% filter(taxonomicStatus == "NOME_ACEITO")

spp2 <- as.character(unique(spp1$species))

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

############## Bind Rows 

lista_2 <- bind_rows(records_list)

############### Write table

write.csv(lista_2, "final_2.csv", row.names = FALSE)

#j <- length(records_list)

#for (j in 1:length(records_list)) {
#  write.csv(records_list[j], file = paste0("loop_", ".csv"))
#}


#for (j in 1:length(records_list)) {
#     write.csv(records_list[j], file = paste0("loop_", j, ".csv"))
#

#for (j in 1:length(records_list)) {
#write.list(records_list[j], file= "spps_records_final.csv", row.names = T)
#}

##################################################################################################

#records <- rspeciesLink(dir = "./results/spp_records/",
#                        filename = "records_specieslink",
#                        species = spp2[1:19],
#                        Scope = "plants")
#records_1 <- purrr::map(spp2, rspeciesLink(dir = "./results/spp_records/",
#                                                       filename = "records_specieslink"))