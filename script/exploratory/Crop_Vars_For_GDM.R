############################################ 
# Crop variables
############################################

library(raster)
library(rgdal)

## Read Shape

Caatinga_Cristalino <- readOGR("./data/shape/mun_caatinga_cristalino.shp")
plot(Caatinga_Cristalino)

## Enviromental
List_envs <- list.files("./data/Envs/5min/All_Global/", pattern = ".tif", full.names = T)

envs_caatinga <- stack(List_envs)
plot(envs_caatinga)

### Mask Crop  Solar Radiation
all_masked <- mask(x = envs_caatinga, mask = Caatinga_Cristalino) #aplicando a máscara (shape) pela função mask do pacote raster 
plot(all_masked) # plote 

all_cropped <- crop(x = all_masked, y = extent(Caatinga_Cristalino)) #agora corte por essa máscara
plot(all_cropped)

final_layers <- stack(all_cropped)

plot(final_layers$solar_rad)

#a <- paste0(names(all_cropped), ".tif")

#writeRaster(final_layers$solar_rad) ### Isto vai salvar no local em que estiver o projeto. Veja este local no canto superior  direito 

solar <- final_layers$solar_rad
writeRaster(solar,"./data/Envs/5min/solar_rad.tif")

wvapr <- final_layers$water_vapour
writeRaster(wvapr, "./data/Envs/5min/water_vpr.tif")

alt <- final_layers$wc2.1_5m_elev
writeRaster(alt, "./data/Envs/5min/alt.tif")
  
bio1 <- final_layers$wc2.1_5m_bio_1
writeRaster(bio1, "./data/Envs/5min/bio1.tif")

bio2 <- final_layers$wc2.1_5m_bio_2
writeRaster(bio2, "./data/Envs/5min/bio2.tif")

bio3 <- final_layers$wc2.1_5m_bio_3
writeRaster(bio3, "./data/Envs/5min/bio3.tif")

bio4 <- final_layers$wc2.1_5m_bio_4
writeRaster(bio4, "./data/Envs/5min/bio4.tif")

bio5 <- final_layers$wc2.1_5m_bio_5
writeRaster(bio5, "./data/Envs/5min/bio5.tif")

bio6 <- final_layers$wc2.1_5m_bio_6
writeRaster(bio6, "./data/Envs/5min/bio6.tif")

bio7 <- final_layers$wc2.1_5m_bio_7 
writeRaster(bio7, "./data/Envs/5min/bio7.tif")

bio8 <- final_layers$wc2.1_5m_bio_8
writeRaster(bio8, "./data/Envs/5min/bio8.tif")

bio9 <- final_layers$wc2.1_5m_bio_9
writeRaster(bio9, "./data/Envs/5min/bio9.tif")

bio10 <- final_layers$wc2.1_5m_bio_10
writeRaster(bio10, "./data/Envs/5min/bio10.tif")

bio11 <- final_layers$wc2.1_5m_bio_11
writeRaster(bio11, "./data/Envs/5min/bio11.tif")

bio12 <- final_layers$wc2.1_5m_bio_12
writeRaster(bio12, "./data/Envs/5min/bio12.tif")

bio13 <- final_layers$wc2.1_5m_bio_13
writeRaster(bio13, "./data/Envs/5min/bio13.tif")

bio14 <- final_layers$wc2.1_5m_bio_14
writeRaster(bio14, "./data/Envs/5min/bio14.tif")

bio15 <- final_layers$wc2.1_5m_bio_15
writeRaster(bio15, "./data/Envs/5min/bio15.tif")

bio16 <- final_layers$wc2.1_5m_bio_16
writeRaster(bio16, "./data/Envs/5min/bio16.tif")

bio17 <- final_layers$wc2.1_5m_bio_17
writeRaster(bio17, "./data/Envs/5min/bio17.tif")

bio18 <- final_layers$wc2.1_5m_bio_18
writeRaster(bio18, "./data/Envs/5min/bio18.tif")

bio19 <- final_layers$wc2.1_5m_bio_19
writeRaster(bio19, "./data/Envs/5min/bio19.tif")
