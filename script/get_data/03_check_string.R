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

# vamos ficar com: possibly_ok, subspecies, variety, name_w_authors, name_w_non_ascii
fica <- c("possibly_ok",
          "subspecies",
          "variety",
          "name_w_authors",
          "name_w_wrong_case")

checar <- c("name_w_non_ascii",
            "not_Genus_epithet_format",
            "not_name_has_digits")



# 2. checking fields ####
## name_w_non_ascii
## remove Não identificada
planilha_02 %>% filter(check$speciesStatus %in% checar[1])

## not_Genus_epithet_format
## too much
planilha_02 %>% filter(check$speciesStatus %in% checar[2])

## not_name_has_digits
planilha_02 %>% filter(check$speciesStatus %in% checar[3]) # ok

check$check_ok <- "fora"
check$check_ok[check$speciesStatus %in% c(fica, checar[-2])] <- "ok"
check$check_ok[check$speciesStatus %in% checar[1] &
                 check$scientificName == "Não identificada"] <- "fora"
check$check_ok[check$speciesStatus %in% "not_Genus_epithet_format"] <- "checar"

table(check$check_ok)

# e agora juntando com o objeto inicial
tax_check <- cbind(planilha_02, check[, -1])

# exportando os dados depois do check
write.csv(tax_check,
          file = "./results/03_taxon_data_raw_check.csv",
          row.names = FALSE)
