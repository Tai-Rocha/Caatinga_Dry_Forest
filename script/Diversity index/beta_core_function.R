##############################################################
## Diversity measures and pairwise dissimilarity matrices    #
## Author: Tainá Rocha                                       #
##############################################################

## library pckgs

library(vegan)
library(betapart)

# Input for "betapart.core" function is data frame, where rows are sites and columns are species. 

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Old/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")

## "betapart.core" function computes the basic quantities needed for computing the multiple-site beta diversity measures and pairwise dissimilarity matrices.

caatinga_simi <- betapart.core(matrix_similaridade_caatinga_[,-1])

####### Write Results
write.table(caatinga_simi[["sumSi"]], "./results/New/Diversity/beta.core_sumSI.txt", dec = ".")

write.table(caatinga_simi[["St"]], "./results/New/Diversity/beta.core_St.txt", dec = ".")

write.table(caatinga_simi[["a"]], "./results/New/Diversity/beta.core_a.txt", dec = ".")

write.table(caatinga_simi[["shared"]], "./results/New/Diversity/beta.core_shared.txt", dec = ".")

write.table(caatinga_simi[["not.shared"]], "./results/New/Diversity/beta.core_notShared.txt", dec = ".")

write.table(caatinga_simi[["sum.not.shared"]], "./results/New/Diversity/beta.core_sum_notShared.txt", dec = ".")

write.table(caatinga_simi[["max.not.shared"]], "./results/New/Diversity/beta.core_maxNotShared.txt", dec = ".")

write.table(caatinga_simi[["min.not.shared"]], "./results/New/Diversity/beta.core_minNotShared.txt", dec = ".")

###################### End