###############################################################
# Matrices distance accounting for :                          #
# turnover (replacement),                                     #
# nestedness-resultant component                              #
# and total dissimilarity (i.e. the sum of both components)   #
# Author: Tainá Rocha                                         #
###############################################################


### Library

library(betapart)

### Load Input data frame, where rows are sites and columns are species.

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")

######### Incidence-based pair-wise dissimilarities

## Jaccard

jaccard_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "jaccard")

## See outputs

jaccard_caatinga[["beta.jtu"]]
jaccard_caatinga[["beta.jne"]]
jaccard_caatinga[["beta.jac"]]

## Conversion outputs into a matrix (to save easily)

beta.jtu <- as.matrix(jaccard_caatinga$beta.jtu)

beta.jne <- as.matrix(jaccard_caatinga$beta.jne)

beta.jac <- as.matrix(jaccard_caatinga$beta.jac)

## Sorense
sorense_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "sorensen")




########### Write outputs

## Jaccard

write.csv(beta.jtu, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jtu.csv", sep=",", dec = ".")

write.csv(beta.jne, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jne.csv",sep = ",", dec = ".")

write.csv(beta.jac, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jac.csv", sep=",", dec = ".")

## Sorense
