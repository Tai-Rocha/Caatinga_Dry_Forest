###############################################################
# Matrices distance accounting for :                          #
# turnover (replacement),                                     #
# nestedness-resultant component                              #
# and total dissimilarity (i.e. the sum of both components)   #
# Sorense Index                                               #
# Author: Tainá Rocha                                         #
###############################################################

### Library

library(betapart)
library(vegan)


### Load Input data frame, where rows are sites and columns are species.

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")


#### Rea d and loa input for envfit function

envs.in.site <- read.csv("./data/tables/input_envifit/Input_Final_PCA.csv", sep = ",", dec = ".")

#### Dissimalarity Sorense

sorense_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "sorensen")

## Conversion outputs into a matrix (to save easily)

beta.sim <- as.matrix(sorense_caatinga$beta.sim)
beta.sne <- as.matrix(sorense_caatinga$beta.sne)
beta.sor <- as.matrix(sorense_caatinga$beta.sor)


### NMDS with beta.sne (nestedness) and beta.sim (turnover)

beta.sne <- metaMDS(sorense_caatinga[["beta.sne"]], distance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 

beta.sim <- metaMDS(sorense_caatinga[["beta.sim"]], ddistance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 


####### envifit Sorense beta.sne (nestedness)

fit.beta.sne <- envfit(beta.sne, envs.in.site[1:23], perm = 999)

scores_beta.sne <-scores(fit.beta.sne, "vectors")

plot(beta.sne)
plot(fit.beta.sne)
plot(fit.beta.sne, p.max = 0.05, col = "red")

#### Write beta.SNE scores

write.table(scores_beta.sne, "./results/Results_New/Diversity_Index/ENVFIT_NMDS/Sorense/score_betaSNE_ENVFIT_NMDS.txt", dec = ".")


## Write Sorense Outputs

write.table(beta.sim, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Sorense_beta_sim.txt", dec = ".")

write.table(beta.sne, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Sorense_beta_sne.txt", dec = ".")

write.table(beta.sor, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Sorense_beta_sor.txt", dec = ".")


########## End