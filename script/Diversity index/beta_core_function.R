##############################################################
## Diversity measures and pairwise dissimilarity matrices    #
## Author: Tainá Rocha                                       #
##############################################################

## library pckgs

library(vegan)
library(betapart)
library(erer)

# Input for "betapart.core" function is data frame, where rows are sites and columns are species. 

matrix_similaridade_caatinga_ <- read.csv("./data/tables/New/beta_diversidade/betapart_input.csv", sep = ",", dec = ".")

## "betapart.core" function computes the basic quantities needed for computing the multiple-site beta diversity measures and pairwise dissimilarity matrices.

caatinga_simi <- betapart.core(matrix_similaridade_caatinga_[,-1])

write.csv(caatinga_simi$sumSi, "./results/New/Beta_divers/sumSim_statistics.txt")

write.csv(caatinga_simi$St, "./results/New/Beta_divers/ST_statistics.txt")

write.csv(caatinga_simi$a, "./results/New/Beta_divers/a_statistics.txt")

write.csv(caatinga_simi$shared, "./results/New/Beta_divers/shared_statistics.txt")

write.csv(caatinga_simi$not.shared, "./results/New/Beta_divers/NOTshared_statistics.txt")






############# To test 
TernaryPlot(
  atip = caatinga_simi$a,
  btip = caatinga_simi$St,
  ctip = caatinga_simi$sumSi)
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