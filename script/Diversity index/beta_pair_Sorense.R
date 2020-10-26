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
library(erer)

### Load Input data frame, where rows are sites and columns are species.

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Old/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")

#### Dissimalarity Sorense

sorense_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "sorensen")

## Conversion outputs into a matrix (to save easily)

beta.sim <- as.matrix(sorense_caatinga$beta.sim)
beta.sne <- as.matrix(sorense_caatinga$beta.sne)
beta.sor <- as.matrix(sorense_caatinga$beta.sor)

## Write Sorense Outputs

write.table(beta.sim, "./results/New/Diversity/Sorense/Sorense_beta_sim.txt", dec = ".")

write.table(beta.sne, "./results/New/Diversity/Sorense/Sorense_beta_sne.txt", dec = ".")

write.table(beta.sor, "./results/New/Diversity/Sorense/Sorense_beta_sor.txt", dec = ".")


############################################################### Do not run ################################################################################
### NMDS with beta.sne (nestedness) and beta.sim (turnover)

#beta.sne <- metaMDS(sorense_caatinga[["beta.sne"]], distance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 

#beta.sim <- metaMDS(sorense_caatinga[["beta.sim"]], ddistance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 

###########################################################################################################################################################


## Estimates the jaccard and sorense or any other indices of beta diversity reviewed by Koleff et al. (2003). Alternatively, it finds the co-occurrence frequencies for triangular plots (Koleff et al. 2003).

sorense2 <- betadiver(matrix_similaridade_caatinga_, method = "j")
sorense2

sorense2 <- as.matrix(sorense2)

write.csv(sorense2, "./results/New/Diversity/Sorense/Sorense_2.csv", sep=",", dec = ".")

## Computes 3 multiple-site dissimilarities accounting for the spatial turnover and the nestedness components of beta diversity, and the sum of both values. 

sorense_3 <- beta.multi(matrix_similaridade_caatinga_[,-1], index.family="sorense")
sorense_3

write.list(sorense_3, "./results/New/Diversity/Sorense/Sorense_3.txt")


####### envifit Sorense beta.sne (nestedness)
#### Read and load input for envfit function

#envs.in.site <- read.csv("./data/tables/input_envifit/Input_Final_PCA.csv", sep = ",", dec = ".")

#fit.beta.sne <- envfit(beta.sne, envs.in.site[1:23], perm = 999)

#scores_beta.sne <-scores(fit.beta.sne, "vectors")

#plot(beta.sne)
#plot(fit.beta.sne)
#plot(fit.beta.sne, p.max = 0.05, col = "red")

### Write beta.SNE scores

#write.table(scores_beta.sne, "./results/Results_New/Diversity_Index/ENVFIT_NMDS/Sorense/score_betaSNE_ENVFIT_NMDS.txt", dec = ".")

########## End