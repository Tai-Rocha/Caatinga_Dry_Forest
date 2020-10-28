##################################
# Principal coordinates analysis
# Author: Tainá Rocha
##################################

#Library

library(ape)
library(vegan)
library(FactoMineR)
library(factoextra)

## Read data 

caatina_pcoa_input <- read.csv("./data/tables/Old/Diversity_Input_betapart/betapart_2.core.csv")

###  MAtrix Distance based on binary data

caatinga_distance_banary <- dist(caatina_pcoa_input, method = "binary")

## PCoA

caatina_pcoa_ape <- pcoa(caatinga_distance_banary, correction="none", rn=caatina_pcoa_input$X)

biplot(caatina_pcoa_ape, rn=caatina_pcoa_input$X, plot.axes = c(1,2), dir.axis1=1,
       dir.axis2=1, pch=25, main = "PCoA of binary distance")

#Vegan
caatinga_pcoa_vegan <-cmdscale(caatinga_distance_banary,k=5,eig=TRUE)
caatinga_pcoa_vegan
#biplot(caatinga_pcoa_vegan, caatina_pcoa_input,
      # plot.axes = c(1,2),
      # pch=25, main = "PCoA of binary distance")


#FactorMiner
input_factormine <- read.csv("./data/tables/Old/Cluster_Input/teste_pvclust_input.csv")

caatinga_pcoa_factominer <- CA(input_factormine[,-1], axes = c(1,2))

fviz_ca_biplot(caatinga_pcoa_factominer,
               axes = c(1, 2))

############ Climatic data

#Read data 

climatic_caatinga <- read.csv("./data/tables/New/Input_PCoA_PCA/PCoA_long.csv")

###  MAtrix Distance based on climatic data in points

Euclidian_Climatic <- dist(climatic_caatinga[3:27], method = "euclidean")

## PCoA

#Ape
climatic_caatina_pcoa <- pcoa(Euclidian_Climatic, correction="none", rn=climatic_caatinga$sitios)

# Vegan
eucl_clim <-cmdscale(Euclidian_Climatic,k=2,eig=TRUE)
eucl_clim

biplot(climatic_caatina_pcoa,rn=climatic_caatinga$sitios, pch=25, main = "PCoA of euclidean distance")
