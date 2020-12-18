##################################
# Principal coordinates analysis
# Author: Tainá Rocha
##################################

#Library

library(ape)
library(tidyverse)


# Vegan
# The naming conventions vary. The one adopted here is traditional rather than truthful to priority. The function finds either quantitative or binary variants of the indices under the same name, which correctly may refer only to one of these alternatives For instance, the Bray index is known also as Steinhaus, Czekanowski and Sørensen index. The quantitative version of Jaccard should probably called Ružička index. The abbreviation "horn" for the Horn--Morisita index is misleading, since there is a separate Horn index. The abbreviation will be changed if that index is implemented in vegan (https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/vegdist)


caatinga_pcoa_vegan <- read.csv("./data/tables/New/PcoA/PCoA_input.csv")

## To get the names of sites
rownames(caatinga_pcoa_vegan) <- caatinga_pcoa_vegan[,1]
caatinga_pcoa_vegan <- caatinga_pcoa_vegan[,-1]
caatinga_pcoa_vegan

## To get the names of sites, another way  (tidyverse)

#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

## Distance

vegan_dist_caatinga <-vegdist(caatinga_pcoa_vegan,"bray")

## To get the names of sites (tidyverse)
#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

pcoa_floristic_caatinga <- cmdscale(vegan_dist_caatinga, k=(nrow(caatinga_pcoa_vegan)-1), eig = TRUE) # a função cmdscale é para fazer a PCoA, k is axis numbers and eig is explaination
pcoa_floristic_caatinga # eig is autovalues (eigenvalues), GOF is explaination percentage of axisi defined by K

dev.new(title="PCoA of floristic")

pcoa_flor <-ordiplot(scores(pcoa_floristic_caatinga, choices = c(1,2)), type = "t", main= "PCoA of floristic matrix")

abline(h=0, lty=3)
abline(v=0, lty=3)


# Add weighted average projection of species
#spe.wa <- wascores(pcoa_floristic_caatinga$points[,1:2], caatinga_pcoa_vegan)
#text(spe.wa, rownames(spe.wa), cex=0.7, col="red")


############ Climatic data

#Read data 

climatic_caatinga <- read.csv("./data/tables/New/PcoA/PCoA_long.csv")

###  MAtrix Distance based on climatic data in points

Euclidian_Climatic <- dist(climatic_caatinga[3:25], method = "euclidean")

## PCoA

#Ape
climatic_caatina_pcoa <- pcoa(Euclidian_Climatic, correction="none", rn=climatic_caatinga$sitios)

# Vegan
eucl_clim <-cmdscale(Euclidian_Climatic,k=2,eig=TRUE)
eucl_clim

biplot(climatic_caatina_pcoa,rn=climatic_caatinga$sitios,pch=25, main = "PCoA of euclidean distance", xlab="Dim1", ylab="Dim2")
