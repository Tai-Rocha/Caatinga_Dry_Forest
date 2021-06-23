################################################
## Scrip 04: Check Flora
## Package Rocc lastest version ( 20/03/2021)
################################################

#Library

library(Rocc)
library(flora)
library(dplyr)
library(parallel)
###################

planilha_02 <- read.csv("./results/02_taxon_data_raw.csv")

check <- check_string(planilha_02$scientificName)

table(check$speciesStatus)

tax_check_2 <- tax_check %>% filter(speciesStatus == "possibly_ok")


# exportando os dados depois do check
write.csv(tax_check_2,
          file = "./results/03_taxon_data_raw_check.csv",
          row.names = FALSE)
