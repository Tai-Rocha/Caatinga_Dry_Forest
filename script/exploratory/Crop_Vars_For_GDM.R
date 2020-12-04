############################################ 
# Crop variables
############################################

library(raster)
library(rgdal)

## Read Shape

Caatinga_Cristalino <- readOGR("./data/shape/Mask_GDM.shp")
plot(Caatinga_Cristalino)

## Enviromental
List_envs <- list.files("./data/Envs_caatinga/", pattern = ".tif", full.names = T)

envs_caatinga <- stack(List_envs)
plot(envs_caatinga)

### Mask Crop  Solar Radiation
all_masked <- mask(x = envs_caatinga, mask = Caatinga_Cristalino) #aplicando a máscara (shape) pela função mask do pacote raster 
plot(all_masked) # plote 

all_cropped <- crop(x = all_masked, y = extent(Caatinga_Cristalino)) #agora corte por essa máscara
plot(all_cropped)

a <- paste0(names(all_cropped), ".tif")

writeRaster(all_cropped, filename= a, bylayer=TRUE) ### Isto vai salvar no local em que estiver o projeto. Veja este local no canto superior  direito 

