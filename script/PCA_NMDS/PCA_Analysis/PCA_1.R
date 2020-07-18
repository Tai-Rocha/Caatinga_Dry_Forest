##############################################
##### PCA Analysis for Caatiga points
##### Author: Tainá Rocha & Marinez Siqueira
##### Date: 15 July 2020
##############################################

# Library pckgs

library(raster)
library(rgdal)

# Read csv input table

pontos <- read.csv("./data/tables/pe.csv", sep = ",")


## List variables 

list_inpe<-list.files(path="./data/Envs_caatinga/",
                      pattern="tif",
                      full.names=TRUE)

envs <- stack(list_inpe)
plot(envs)

## Extract values from inpe variables to ponit

vals_inpe<- extract(envs, pontos[,-1])

sum_inpe_vals <- summary(vals_inpe)


### Write table

write.table(vals_inpe, file = "./results/Results_New/inpe_values.txt", dec= ".")



### PCA

### Library

library(factoextra)
library(FactoMineR)
library(ggcorrplot)
library(ggplot2)
library(psych)
library(rgdal)
library(rgeos)
library(vegan)

### Read table of variable information in records. Standardize

pca <- read.table("./results/Results_New/inpe_values.txt")

vals_pca<-decostand(pca, method="standardize")

boxplot(vals_pca)

#PCA FACTOREXTRA

PCA_Graphic <- prcomp(vals_pca)

fviz_pca_var(PCA_Graphic, axes = c(1, 2), geom = c("arrow", "text"),
             label = "all", invisible = "none", labelsize = 3,
             col.var = "black", alpha.var = 1, col.quanti.sup = "blue",
             col.circle = "grey70", select.var = list(name =NULL, cos2 = NULL, contrib = 5)) + 
  labs(title ="Principal component analysis (PCA)", x = "PC1", y = "PC2")

tiff("PCA_21_vars.tiff", width = 984, height = 615, unit = "px", res = 300)

dev.off()


### PCA of 5 variables major contribuiton

pca_21_var <- read.csv("./data/PCA/stand_test.csv", sep = ",")

fviz_pca_var(PCA_Graphic, select.var = list(contrib = 5), labelsize = 3) + 
  labs(title ="Principal component analysis (PCA)", x = "PC1", y = "PC2")

tiff("PCA_5_contr.tiff", width = 984, height = 615, unit = "px", res = 300)
dev.off()


################# PCA 2




### PCA

pca.2 <- prcomp(vals_pca,  scale = TRUE)


# Color individuals by groups
fviz_pca_ind(pca.2, label="none")



#Select the top 3 contributing variables
fviz_pca_var(pca.2, select.var = list(contrib = 6))


# PCA with cor matriz 

PCA_INPE <- PCA(pca.s, scale.unit = T, ncp = 7, graph = TRUE)


plot(PCA_INPE, graph.type = "ggplot")

plot(PCA_INPE, habillage = 10, cex=0.3)



gr <- plot(PCA_INPE)
gr + theme(panel.grid.major = element_blank(),
           plot.title=element_text(size=14, color="blue"),
           axis.title = element_text(size=12, color="red"))

plot(gr, choix = "var",
     col.ind="black", col.ind.sup="blue", 
     col.var="black", label = "var", lim.cos2.var = 0, title = PCA, palette=NULL,
     autoLab = "auto", new.plot = FALSE, select = NULL,
     shadowtext = FALSE, graph.type = "ggplot", ggoptions = NULL)

#PCA_21_variables_2 <- PCA(vals_pca, graph = FALSE)
#print(PCA_21_variables_2)


plot(PCA_WC, cex=1.5,scale.unit = T, ncp = 21)

