##################################
## Prepare input for betapart
## R version 4.1
## 25 May 2021
#################################

library(dplyr)
library(foreign)
library(tibble)
library(tidyr)
library(datapasta)


##Read

dbf_join <- foreign::read.dbf('./data/Shape_Join_CristalinoPoints_Grid10/join_PointsCristalino_Grid10.dbf')

## Covert to tibble 

tibble_join <- as.tibble(dbf_join)

tibble_join


## Filter species and id of sites
table_1 <- tibble_join %>%
  select(species, id)


#write_csv(table_1, './data/betapart_Input/pre_input.csv')




tab_2


tab_final <- tab_2 |> 
  distinct() |> 
  group_by(species) |> 
  tidyr::pivot_wider(
    names_from = Site,
    values_from = presence,
    values_fill = 0
  )
