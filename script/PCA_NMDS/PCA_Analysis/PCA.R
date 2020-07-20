##############################
## PCA for caatinga 
## Author: Tainá Rocha
##############################

## Librarys

library(factoextra)
library(FactoMineR)
library(ggcorrplot)
library(ggplot2)
library(psych)
library(rgdal)
library(rgeos)
library(vegan)

## Read and Load data

#PCA_INPUT <- read.csv("./data/tables/input_data_prepare_for_PCA/Input_Final_PCA.csv", sep = ",", dec = ".")

PCA_INPUT <- read.csv("./data/tables/input_data_prepare_for_PCA/teste_pca_long.csv", sep = ",", dec = ".")

### standardize unit of variables to build PCA  

#pca_caatinga<-decostand(PCA_INPUT[1:23], method="standardize")

#write.table(wc_vals, './data/wc_vals_standardize.txt')

### PCA

res.pca.caatinga <- prcomp(PCA_INPUT[1:23],  scale = TRUE)



# Color individuals by groups
fviz_pca_ind (
              res.pca.caatinga, 
              select.ind = list(name = PCA_INPUT$id))

###
fviz_pca_ind(res.pca.caatinga,
             label = "none",
             habillage= PCA_INPUT$id,
             geom = "point",
             col.var = "coord")

###
fviz_pca_ind(res.pca.caatinga, 
             label="none", 
             habillage=PCA_INPUT$id,
             palette = "Dark2")
             



              
              


p <- fviz_pca_ind(res.pca.caatinga, 
                  label="none", 
                  geom = c("point", "text"),
                  geom.ind = c("point", "text"),
                  habillage=PCA_INPUT$sitios,
                  addEllipses=TRUE, 
                  ellipse.level=0.95
                 )
print(p)

# Change the color by groups, add ellipses
fviz_pca_biplot(res.pca.caatinga, label="var", habillage=PCA_INPUT$sitios,
                addEllipses=TRUE, ellipse.level=0.95)


#Select the top 5 contributing variables
fviz_pca_var(res.pca.caatinga, select.var = list(contrib = 5))


# PCA with cor matriz 

PCA_WC <- PCA(PCA_INPUT[1:23], scale.unit = T, ncp = 5, graph = TRUE)


plot(PCA_WC, graph.type = "ggplot")

plot(PCA_WC, habillage = 10, cex=0.3)



gr <- plot(PCA_WC)
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

# matriz de covariância

round(cor(pca_briofitas),2)

# autovalores
round(pca.cor$eig,3)

# A proporção de variação retida pelos componentes principais (CP) pode ser extraída da seguinte forma

pca.cor$eig


# A importância dos CP pode ser visualizada usando o scree plot :
fviz_screeplot(wc.res.pca, ncp=4, choice="variance", addlabels=F, main=NULL, barfill="white", linecolor= "black", geom= c("bar","line"),barcolor = "black")+ theme_minimal()

ggsave("Scree_Plot_.tiff", units="in", width=5, height=4, dpi=100, compression = 'lzw')


# A correlação entre uma variável e um CP é chamada de carga (loadings). 

round(pca.cor$var$cor,4)


##Factorial map

# Quanto mais próxima uma variável for do círculo de correlações, melhor sua representação no mapa fatorial (e mais # Importante é a variável para a interpretação desses componentes)
# As variáveis próximas ao centro do gráfico são menos importantes para os primeiros componentes.
# No gráfico abaixo os componentes são coloridas de acordo com os valores do coseno quadrado:


