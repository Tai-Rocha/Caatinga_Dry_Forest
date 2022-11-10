###############################################################
# Matrices distance accounting for :                          #
# turnover (replacement),                                     #
# nestedness-resultant component                              #
# and total dissimilarity (i.e. the sum of both components)   #
# Sorense Index                                               #
# Author: Tainá Rocha  
# R version 4.2.1
###############################################################
### Library
library(betapart)
library(vegan)
#library(erer)

### Load Input data frame, where rows are sites and columns are species.

beta_matrix <- read.csv("data/betapart_Input/betainput_final.csv", sep = ",")

#betaa <- betadiver(beta_matrix)
#plot(betaa)

#### Dissimalarity Sorense

sorense_caatinga <- beta.pair(beta_matrix, index.family = "sorensen")

sorense_vegan <- betadiver(beta_matrix, "sor")
class(sorense_vegan)

sor_dissimi_caatinga <- as.data.frame(sorense_vegan)

## Conversion outputs into a matrix (to save easily)

beta.sim <- as.matrix(sorense_caatinga$beta.sim)
beta.sne <- as.matrix(sorense_caatinga$beta.sne)
beta.sor <- as.matrix(sorense_caatinga$beta.sor)

## Write Sorense Outputs

write.csv(beta.sim, "results/Sorense_beta_sim.csv", dec = ".")

write.csv(beta.sne, "results/Sorense_beta_sne.csv", dec = ".")

write.csv(beta.sor, "results/Sorense_beta_sor.csv", dec = ".")


## All dataset.  Computes 3 multiple-site dissimilarities accounting for the spatial turnover and the nestedness components of beta diversity, and the sum of both values. 

Sorense_all_dataset <- beta.multi(beta_matrix, index.family="sorense")
Sorense_all_dataset

