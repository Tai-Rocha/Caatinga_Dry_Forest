############################################
## Alpha diversity and beta diversty index
## Author: Tainá Rocha
############################################

## library pckgs

library(vegan)
library(betapart)

#Carregando a planilha

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Cluster_Input_caatinga.csv", sep = ";")

matrix_similaridade_caatinga <- matrix_similaridade_caatinga_[ ,-1]

briofitas_simi <- betapart.core(matrix_similaridade)


#### Jaccard index (VEGAN)

jaccard_vegan <- betadiver(matrix_similaridade, "j")
jaccard_vegan


#### Sorense index (VEGAN)

sorense_vegan <- betadiver(matrix_similaridade, "sor")
sorense_vegan


### CHAO index (VEGAN)

chao_vegan <- betadiver(matrix_similaridade, "co")
chao_vegan


