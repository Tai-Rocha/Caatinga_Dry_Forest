###############################################################
# Matrices distance accounting for :                          #
# turnover (replacement),                                     #
# nestedness-resultant component                              #
# and total dissimilarity (i.e. the sum of both components)   #
# Jaccard index                                               #
# Author: Tainá Rocha                                         #
###############################################################


### Library

library(betapart)
library(vegan)

### Load Input data frame, where rows are sites and columns are species.

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")


#### Rea d and loa input for envfit function

envs.in.site <- read.csv("./data/tables/input_envifit/Input_Final_PCA.csv", sep = ",", dec = ".")

######### Incidence-based pair-wise dissimilarities

jaccard_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "jaccard")

## See outputs

jaccard_caatinga[["beta.jtu"]]
jaccard_caatinga[["beta.jne"]]
jaccard_caatinga[["beta.jac"]]

### NMDs with Jaccard beta.jne (nestedness) and beta.jtu (turnover)

beta.jne <- metaMDS(jaccard_caatinga[["beta.jne"]], distance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 

beta.jtu <- metaMDS(jaccard_caatinga[["beta.jtu"]], distance = "bray", K=3, trymax = 100, engine= "monoMDS", autotransform = "F", plot = T)  

##### envfit function Jaccard index Beta.JNE 

fit.beta.jne <- envfit(beta.jne, envs.in.site[1:23], perm = 999)

scores_beta.jne <-scores(fit.beta.jne, "vectors")

plot(beta.jne)
plot(fit.beta.jne)
plot(fit.beta.jne, p.max = 0.05, col = "red")

#### Write beta.jne scores

write.table(scores_beta.jne, "./results/Results_New/ENVFIT_NMDS/Jaccard/score_betaJNE_ENVFIT_NMDS.txt", dec = ".")

####### envifit Jaccard beta.jts

fit.beta.jtu <- envfit(beta.jtu, envs.in.site[1:23], perm = 999)

scores_beta.jtu <-scores(fit.beta.jtu, "vectors")

plot(beta.jtu)
plot(fit.beta.jtu)
plot(fit.beta.jtu, p.max = 0.05, col = "red")

#### Write beta.JTU scores

write.table(scores_beta.jtu, "./results/Results_New/ENVFIT_NMDS/Jaccard/score_betaJTU_ENVFIT_NMDS.txt", dec = ".")

## Conversion outputs into a matrix (to save easily)

beta.jtu <- as.matrix(jaccard_caatinga$beta.jtu)

beta.jne <- as.matrix(jaccard_caatinga$beta.jne)

beta.jac <- as.matrix(jaccard_caatinga$beta.jac)

########### Write Jaccard outputs

## 

write.csv(beta.jtu, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jtu.csv", sep=",", dec = ".")

write.csv(beta.jne, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jne.csv",sep = ",", dec = ".")

write.csv(beta.jac, "./results/Results_New/Diversity_indices/beta_pair_Jaccard_Sorense/Jaccard_beta_jac.csv", sep=",", dec = ".")


########## End