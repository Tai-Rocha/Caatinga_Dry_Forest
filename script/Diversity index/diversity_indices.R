############################################
## Alpha diversity and beta diversty index
## Author: Tainá Rocha
############################################

## library pckgs

library(vegan)
library(betapart)

# Input for "betapart.core" function is data frame, where rows are sites and columns are species. 

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")

matrix_similaridade_caatinga <- matrix_similaridade_caatinga_[ ,-1]

## "betapart.core" function computes the basic quantities needed for computing the multiple-site beta diversity measures and pairwise dissimilarity matrices.

caatinga_simi <- betapart.core(matrix_similaridade_caatinga)

####### Write Results
write.table(caatinga_simi[["sumSi"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_sumSI", dec = ".")

write.table(caatinga_simi[["St"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_St.txt", dec = ".")

write.table(caatinga_simi[["a"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_a.txt", dec = ".")

write.table(caatinga_simi[["shared"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_shared.txt", dec = ".")

write.table(caatinga_simi[["not.shared"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_notShared.txt", dec = ".")

write.table(caatinga_simi[["sum.not.shared"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_sum_notShared.txt", dec = ".")

write.table(caatinga_simi[["max.not.shared"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_maxNotShared.txt", dec = ".")

write.table(caatinga_simi[["min.not.shared"]], "./results/Results_New/Diversity_indices/betapart.core/beta.core_minNotShared.txt", dec = ".")




####









#### Jaccard index (VEGAN)

data("sipoo")

jaccard_vegan <- betadiver(matrix_similaridade_caatinga, "j")
jaccard_vegan


#### Sorense index (VEGAN)

sorense_vegan <- betadiver(matrix_similaridade, "sor")
sorense_vegan


### CHAO index (VEGAN)

chao_vegan <- betadiver(matrix_similaridade, "co")
chao_vegan


