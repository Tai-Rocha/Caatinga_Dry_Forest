########################################
### Mantel test
### Author: Tainá Rocha
########################################


## Library

library(vegan)

## Read and Load  data 

caatinga.sites.sps <- read.csv("./data/tables/Mantel and NMDS/caatinga_sites_sps.csv", sep= ",", dec = ".")

caatinga_xy <-read.csv("./data/tables/Mantel and NMDS/caatinga_xy.csv", sep = ",", dec = ".")

#### Matriz de dissimilaridade espacial

spatial.dist.caatinga <- vegdist(caatinga_xy[,-1], "euclid") 

veg.dist <- vegdist(caatinga.sites.sps[,-1], method = "jaccard", binary = "T", ) # Jaacard for dissimilarity

# plota a relação entre distância espacial x dissimilaridade
plot(spatial.dist.caatinga, veg.dist, xlab = "Spatial distance (m)", pch = 20, cex = 0.8) 

#plota a linha de regressão linear entre distância espacial x dissimilaridade

abline(lm(veg.dist ~ spatial.dist.caatinga), lwd = 2, col = "red") 

# realiza o Teste de

mantel(spatial.dist.caatinga, veg.dist) 
