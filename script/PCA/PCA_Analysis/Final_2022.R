###### Library

library(raster)
library(sp)
library(tidyr)

###################################

### Load and stack enviromental variables for analysis

list_envs <- list.files("data/Envs/2_5/", full.names = T, pattern = ".tif")

envs <- stack(list_envs)

plot(envs)


## Points 
caatinga_points <- read.csv("data/PCA/pre_PCA.csv", sep=",", dec = ".")

points <- as.data.frame(caatinga_points)

points <- SpatialPointsDataFrame(points[,-1], pointspoints[,-1])

unique_points <- remove.duplicates(points)
coord <- as.data.frame(unique_points@coords)

coordinates(coord) <- ~ decimalLon+ decimalLat

## Extract envirometal values

#values_in_coord <- extract(envs, points_cc[4:5])
#write.csv(values_in_coord, "./data/tables/GDM_INPUT/env_values_in_coord.csv", sep = ",")

values_in_coord_bi <- extract(envs, coord@coords, method= 'bilinear')

write.csv(values_in_coord_bi, "./data/PCA/env_values_in_coord_bilinear.csv", sep = ",")


#### Remove NA from
input_pca <- readr::read_csv("./data/PCA/env_values_in_coord_bilinear.csv")

# noNA_pca <- na.omit(input_pca) # Not work 

#noNA_pca <- input_pca[complete.cases(input_pca), ] # Not work 

noNA_pca <- input_pca %>% drop_na()     
noNA_pca 

write.csv(noNA_pca, "./data/PCA/env_values_in_coord_bilinear_NONA.csv", sep = ",")


#### ENd


pca <- stats::prcomp(noNA_pca, scale=T)

factoextra::fviz_pca_biplot(pca, 
                axes = c(1, 2), 
                geom = c("point", "text"), 
                geom.ind = "point", 
                geom.var = c("arrow", "text"), 
                col.ind = "black", 
                fill.ind = "gray", 
                col.var = "red", 
                fill.var = "white", 
                gradient.cols = NULL, 
                #label = "all", 
                invisible = "none", 
                repel = FALSE, 
                #habillage = vals_pca$Setor, 
                palette = NULL, 
                addEllipses = FALSE, 
                title = " ")


factoextra::fviz_contrib(pca, choice="var", axes = 1:2, top = 10 )


factoextra::fviz_contrib(pca, choice="ind", axes = 1, xtickslab.rt = 90, top = 100)
