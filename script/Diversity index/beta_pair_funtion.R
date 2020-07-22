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

## Sorense
sorense_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "sorensen")




########### Write outputs

## Jaccard

write.csv(jaccard_caatinga[["beta.jtu"]], "./results/Results_New/Diversity_indices/beta.pair_Jaccard_Sorense/Jaccard_beta.jtu.txt", dec = ".")

write.table(jaccard_caatinga[["beta.jne"]], "./results/Results_New/Diversity_indices/beta.pair_Jaccard_Sorense/Jaccard_beta.jne.txt", dec = ".")

write.table(jaccard_caatinga[["beta.jac"]], "./results/Results_New/Diversity_indices/beta.pair_Jaccard_Sorense/Jaccard_beta.jac.txt", dec = ".")

## Sorense
