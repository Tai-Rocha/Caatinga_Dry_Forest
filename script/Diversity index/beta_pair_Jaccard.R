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
library(erer)

### Load Input data frame, where rows are sites and columns are species.

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Old/Diversity_Input_betapart/betapart_2.core.csv", sep = ",", dec = ".")


## Incidence-based pair-wise dissimilarities
## Computes 3 distance matrices accounting for the (i) turnover (replacement), (ii) nestedness-resultant component, and (iii) total dissimilarity (i.e. the sum of both components).

jaccard_caatinga <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "jaccard")

## See outputs

jaccard_caatinga[["beta.jtu"]]
jaccard_caatinga[["beta.jne"]]
jaccard_caatinga[["beta.jac"]]

## Conversion outputs into a matrix (to save easily)

beta.jtu <- as.matrix(jaccard_caatinga$beta.jtu)

beta.jne <- as.matrix(jaccard_caatinga$beta.jne)

beta.jac <- as.matrix(jaccard_caatinga$beta.jac)

## Write Jaccard outputs

write.csv(beta.jtu, "./results/New/Diversity/Jaccard/Jaccard_beta_jtu.csv", sep=",", dec = ".")

write.csv(beta.jne, "./results/New/Diversity/Jaccard/Jaccard_beta_jne.csv",sep = ",", dec = ".")

write.csv(beta.jac, "./results/New/Diversity/Jaccard/Jaccard_beta_jac.csv", sep=",", dec = ".")

############################################ Do not Run###############################################################################################
## NMDs with Jaccard beta.jne (nestedness) and beta.jtu (turnover) 
#beta.jne <- metaMDS(jaccard_caatinga[["beta.jne"]], distance = "bray", K=3, try=20 ,trymax = 100, engine= "monoMDS", autotransform = "F", plot = T) 
#beta.jtu <- metaMDS(jaccard_caatinga[["beta.jtu"]], distance = "bray", K=3, trymax = 100, engine= "monoMDS", autotransform = "F", plot = T)  
#######################################################################################################################################################


## Estimates the jaccard and sorense or any other indices of beta diversity reviewed by Koleff et al. (2003). Alternatively, it finds the co-occurrence frequencies for triangular plots (Koleff et al. 2003).

jaccard_2 <- betadiver(matrix_similaridade_caatinga_, method = "j")
jaccard_2

jaccard_2 <- as.matrix(jaccard_2)

write.csv(jaccard_2, "./results/New/Diversity/Jaccard/Jaccard_2.csv", sep=",", dec = ".")

## Computes 3 multiple-site dissimilarities accounting for the spatial turnover and the nestedness components of beta diversity, and the sum of both values. 

jaccard_3 <- beta.multi(matrix_similaridade_caatinga_[,-1], index.family="jaccard")
jaccard_3

write.list(jaccard_3, "./results/New/Diversity/Jaccard/Jaccard_3.txt")


############################################ Do not Run###############################################################################################

#### Read and load input for envfit function

#envs.in.site <- read.csv("./data/tables/Old/input_envifit/Input_Final_PCA.csv", sep = ",", dec = ".")

##### envfit function Jaccard index Beta.JNE 

#fit.beta.jne <- envfit(beta.jne, envs.in.site[1:23], perm = 999)

#scores_beta.jne <-scores(fit.beta.jne, "vectors")

#plot(beta.jne)
#plot(fit.beta.jne)
#plot(fit.beta.jne, p.max = 0.05, col = "red")

#### Write beta.jne scores

#write.table(scores_beta.jne, "./results/Results_New/ENVFIT_NMDS/Jaccard/score_betaJNE_ENVFIT_NMDS.txt", dec = ".")

############################################ Do not Run###############################################################################################

####### envifit Jaccard beta.jts

#fit.beta.jtu <- envfit(beta.jtu, envs.in.site[1:23], perm = 999)

#scores_beta.jtu <-scores(fit.beta.jtu, "vectors")

#plot(beta.jtu)
#plot(fit.beta.jtu)
#plot(fit.beta.jtu, p.max = 0.05, col = "red")

#### Write beta.JTU scores

#write.table(scores_beta.jtu, "./results/Results_New/ENVFIT_NMDS/Jaccard/score_betaJTU_ENVFIT_NMDS.txt", dec = ".")

########## End