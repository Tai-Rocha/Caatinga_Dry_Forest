#############################################################
# Cluster with 24 Caatinga Sites                            #
# Author: Tainá Rocha                                       #
#############################################################

# Library pckgs

library(vegan)
library(pvclust)


#################### Clusters 

#Aplicando boostrap pelo pvclust

caatinga_matrix_pvclus_<- read.csv("./data/tables/Cluster_Input_pvclust.csv", sep = ",")
caatinga_matrix_pvclus <- caatinga_matrix_pvclus_ [,-1]

cluster.upgma.jac <-pvclust(caatinga_matrix_pvclus, method.hclust ="average", method.dist = "binary", nboot=1000)


plot(cluster.upgma.jac, print.pv=c("si","au", "bp"), print.num=TRUE, float=0.01,
     col.pv=c(2,3,8), cex.pv=0.8, font.pv=NULL, col=NULL, cex=NULL,
     font=NULL, lty=NULL, lwd=NULL, main="", sub=NULL, xlab=NULL)

#### To teste Find Clusters with High/Low P-values

pvrect(cluster.upgma.jac, alpha=0.95) # it's ok for this data

pvpick(x, alpha=0.95, pv="au", type="geq", max.only=TRUE)

pvrect(x, alpha=0.95, pv="au", type="geq", max.only=TRUE, border=NULL, ...)


#conferindo se o cluster representa bem a matriz de distância.
# cálculo do coeficiente de correlação cofenética
# lembre-se sempre de relatar o valor do coeficiente. Na legenda da figura é uma boa opção.

vals.dist.cof.jac<-cophenetic(cluster.upgma.jac) #cálculo da matriz cofenética
cor(jaccard_vegan, vals.dist.cof.jac)    #coeficiente de correlação em si = -0.7893426



#Carregando a planilha

matrix_similaridade_caatinga_ <- read.csv("./data/tables/Cluster_Input_caatinga.csv", sep = ";")

matrix_similaridade_caatinga <- matrix_similaridade_caatinga_[ ,-1]

briofitas_simi <- betapart.core(matrix_similaridade)


#### Jaccard index (VEGAN)

jaccard_vegan <- betadiver(matrix_similaridade, "j")
jaccard_vegan


#### Sorense index (VEGAN)

sorense_vegan <- betadiver(matrix_similaridade, "sor")
sorense_vegan


### CHAO index (VEGAN)

chao_vegan <- betadiver(matrix_similaridade, "co")
chao_vegan


