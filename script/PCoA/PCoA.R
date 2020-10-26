##################################
# Principal coordinates analysis
# Author: Tainá Rocha
##################################

#Library
library(ape)

## Read data 
caatina_pcoa_input <- read.csv("./data/tables/Old/Diversity_Input_betapart/betapart_2.core.csv")


###  MAtrix Distance based on binary data

caatinga_distance_banary <- dist(caatina_pcoa_input, method = "binary")


## PCoA
caatina_pcoa <- pcoa(caatinga_distance_banary, correction="none", rn=caatina_pcoa_input$X)


biplot(caatina_pcoa,rn=caatina_pcoa_input$X, pch=25, main = "PCoA of binary distance")



############ Climatic data

#Read data 

climatic_caatinga <- read.csv("./data/tables/New/Input_PCoA_PCA/PCoA_long.csv")

###  MAtrix Distance based on climatic data in points

caatinga_euclidian <- dist(climatic_caatinga[3:27], method = "euclidean")

## PCoA
climatic_caatina_pcoa <- pcoa(caatinga_euclidian, correction="none", rn=climatic_caatinga$sitios)


biplot(climatic_caatina_pcoa,rn=climatic_caatinga$sitios, pch=25, main = "PCoA of euclidean distance")
