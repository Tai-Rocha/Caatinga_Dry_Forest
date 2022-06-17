############################################ 
# Crop Future Variables- CANESM
############################################

library(raster)
library(rgdal)

## Read Shape

Caatinga_Cristalino <- readOGR("data/shape/mun_caatinga_cristalino.shp")
plot(Caatinga_Cristalino)

## Enviromental
ssp245_envs <- list.files("data-raw/Envs_WC_21/Future_2041_2060/CanESM5/ssp245/bc/", pattern = ".tif", full.names = T)

ssp245_stack <- stack(ssp245_envs)
plot(ssp245_stack)

ssp585_envs <- list.files("data-raw/Envs_WC_21/Future_2041_2060/CanESM5/ssp585/bc/", pattern = ".tif", full.names = T)

ssp585_stack <- stack(ssp585_envs)
plot(ssp585_stack)

### Mask and  Crop

## SSP245
ssp245_masked <- mask(x = ssp245_stack, mask = Caatinga_Cristalino) #aplicando a máscara (shape) pela função mask do pacote raster 
plot(ssp245_masked) # plote 

ssp245_cropped <- crop(x = ssp245_masked, y = extent(Caatinga_Cristalino)) #agora corte por essa máscara
plot(ssp245_cropped)

## SSP585

ssp585_masked <- mask(x = ssp585_stack, mask = Caatinga_Cristalino) #aplicando a máscara (shape) pela função mask do pacote raster 
plot(ssp585_masked) # plote 

ssp585_cropped <- crop(x = ssp585_masked, y = extent(Caatinga_Cristalino)) #agora corte por essa máscara
plot(ssp585_cropped)

## Save 

## SSP245

a <- paste0(names(ssp245_cropped), ".asc")

writeRaster(ssp245_cropped, filename = a, bylayer = TRUE, overwrite = TRUE) ### Isto vai salvar no local em que estiver o projeto. Veja este local no canto superior  direito 

## SSP245

b <- paste0(names(ssp585_cropped), ".asc")

writeRaster(ssp585_cropped, filename = b, bylayer = TRUE, overwrite = TRUE) ### Isto vai salvar no local em que estiver o projeto. Veja este local no canto superior  direito 


