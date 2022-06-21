#############################
# GDM 
# Rveion
# GDM package version
# OS
#############################

library(gdm)
library(raster)

# Data Prepare ------------------------------------------------------------

# Read inputs (species_site table and enviromental table)
sppdata <- read.csv("./data/GDM_inputs/SPP_DATA_v2.csv")

# Current envs
pres_list_envs <- list.files("./data/Envs/5min/GDM/Pres", full.names= T, pattern = "tif")

pres_cristalino_envs <-stack(pres_list_envs)

#plot(pres_cristalino_envs)

# CamESM5- SSP245 - Future envs

ssp245_list <- list.files("./data/Envs/5min/GDM/Future_2041_2060/CanESM5/ssp245/", full.names= T, pattern = "tif")

ssp245_envs <-stack(ssp245_list)

#plot(ssp245_envs)

# CamESM5- SSP585 - Future envs

ssp585_list <- list.files("./data/Envs/5min/GDM/Future_2041_2060/CanESM5/ssp585/", full.names= T, pattern = "tif")

ssp585_envs <-stack(ssp585_list)

plot(ssp585_envs)

# Formatimg spp table and rater data 

sitePairRast <- formatsitepair(sppdata, 
                               bioFormat=2, 
                               #dist = "bray",
                               XColumn="LONG",
                               YColumn="LAT", 
                               sppColumn="species",
                               siteColumn="sites", 
                               predData=pres_cristalino_envs,
                               sppFilter=55)
# Remove NA values
sitePairRast <- na.omit(sitePairRast)


# Run GDM Model -----------------------------------------------------------

# Fit raster GDM
gdmRastMod <- gdm(sitePairRast, geo=TRUE)
summary(gdmRastMod)

plot(gdmRastMod)

# Transforms geographic and environmental predictors using (1) the fitted functions from a model object returned from gdm and (2) a data frame or raster stack containing predictor data for a set of sites

transRasts <- gdm.transform(gdmRastMod, pres_cristalino_envs)

plot(transRasts)

# Prediction based on GDM  ------------------------------------------------

# Current- Prediction for all variables

pred_prese <- predict(gdmRastMod, sitePairRast, time=FALSE) 

plot(pred_prese)

# Current- Prediction using PCA

# map biological patterns
rastDat <- sampleRandom(transRasts, 10000)  #radom points 
pcaSamp <- prcomp(rastDat)
plot(pcaSamp)

# This funtion predicts biological distances between sites or times using a model object returned from gdm. Predictions between site pairs require a data frame containing the values of predictors for pairs of locations, formatted as follows: distance, weights, s1.X, s1.Y, s2.X, s2.Y, s1.Pred1, s1.Pred2, ..., s1.PredN, s2.Pred1, s2.Pred2, ..., s2.PredN.. Predictions of biological change through time require two raster stacks or bricks for environmental conditions at two time periods, each with a layer for each environmental predictor in the fitted model.

pcaRast <- predict(transRasts, pcaSamp, index=1:3) 

plot(pcaRast)

# scale rasters
pcaRast[[1]] <- (pcaRast[[1]]-pcaRast[[1]]@data@min) /
  (pcaRast[[1]]@data@max-pcaRast[[1]]@data@min)*255
plot(pcaRast)


pcaRast[[2]] <- (pcaRast[[2]]-pcaRast[[2]]@data@min) /
  (pcaRast[[2]]@data@max-pcaRast[[2]]@data@min)*255
plot(pcaRast)

pcaRast[[3]] <- (pcaRast[[3]]-pcaRast[[3]]@data@min) /
  (pcaRast[[3]]@data@max-pcaRast[[3]]@data@min)*255
plotRGB(pcaRast, r=1, g=2, b=3)

writeRaster(pcaRast, "results/GDM/Map/Pres_DissimiModel_PCA_bc_topo.tif")

#Figure 5: Predicted spatial variation in plant species composition. Colors represent gradients in species composition derived from transformed environmental predictors. Locations with similar colors are expected to contain similar plant communities.

# Future Prediction

# SSP245

ssp245_timePred <- predict(gdmRastMod, pres_cristalino_envs, time=T, predRasts=ssp245_envs)
plot(ssp245_timePred)

writeRaster(ssp245_timePred, "results/GDM/Map/ssp245_DissimiModel_PCA_bc_topo.tif")

# SSP585

ssp585_timePred <- predict(gdmRastMod, pres_cristalino_envs, time=T, predRasts=ssp585_envs)
plot(ssp585_timePred)

writeRaster(ssp585_timePred, "results/GDM/Map/2061_2080_ssp585_DissimiModel_PCA_bc_topo.tif")


# Figure 4: Predicted magnitude of biological change through time

#################################################################
## NOT RUN

gdmTab.rast<-na.omit(gdmTab.rast)
gdm.1 <- gdm(gdmTab.rast, geo=T)

## get idea of number of panels
length(gdm.1$predictors)

png(filename="./results/New_11_setembro/GDM/Maps/GDM.png")
plot(gdm.1, plot.layout=c(3,3))
dev.off()

summary(gdm.1)

# porcentagem de explicação do GDM. Figure X. Fitted functions of observed turnover in composition of species for a Generalized Dissimilarity Model using 4 environmental variables.
#The maximum height reached by each function provides an indication of the total amount of compositional turnover associated with that variable, holding all other variables constant.
#The slope of each function provides an indication of the rate of compositional turnover and how this rate varies along the gradient.

png(filename="./results/New_11_setembro/GDM/Maps/plotUncertainty.png")
plotUncertainty(gdmTab.rast,  sampleSites=0.7, bsIters=5,
                geo=T, spline=NULL,
                knots=NULL, splineCol="blue", errCol="grey80",
                plot.linewidth=2.0, plot.layout=c(3,2))
dev.off()



envRast<-caatinga_envs
rastTrans <- gdm.transform(gdm.1, envRast)

png(filename="./results/New_11_setembro/GDM/Maps/env_variables.png")
plot(rastTrans, plot.layout=c(3,3))
dev.off()


rastDat <- na.omit(getValues(rastTrans))
#rastDat <- sampleRandom(rastTrans, 50000) # can use if rasters are large
pcaSamp <- prcomp(rastDat)
# note the use of the 'index' argument
pcaRast <- predict(rastTrans, pcaSamp, index=1:3)
# scale rasters
pcaRast[[1]] <- (pcaRast[[1]]-pcaRast[[1]]@data@min) /
  (pcaRast[[1]]@data@max-pcaRast[[1]]@data@min)*255
pcaRast[[2]] <- (pcaRast[[2]]-pcaRast[[2]]@data@min) /
  (pcaRast[[2]]@data@max-pcaRast[[2]]@data@min)*255
pcaRast[[3]] <- (pcaRast[[3]]-pcaRast[[3]]@data@min) /
  (pcaRast[[3]]@data@max-pcaRast[[3]]@data@min)*255

###mesmo gráfico com outro padrão de cor
#é tudo o mesmo resultado, só muda aparência (combinação de cores). Escolher qual fica melhor de interpretar
png(filename="./results/New_11_setembro/GDM/Maps/plotRGB.png")
par(mfrow=c(3,2))
plotRGB(pcaRast, r=2, g=3, b=1,stretch='hist')
plotRGB(pcaRast, r=2, g=1, b=3,stretch='hist')
plotRGB(pcaRast, r=3, g=2, b=1,stretch='hist')
plotRGB(pcaRast, r=3, g=1, b=2,stretch='hist')
plotRGB(pcaRast, r=1, g=2, b=3,stretch='hist')
plotRGB(pcaRast, r=1, g=3, b=2,stretch='hist')
dev.off()

png(filename="./results/New_11_setembro/GDM/Maps/plotRGB123.png")
plotRGB(pcaRast, r=1, g=2, b=3, stretch='hist', axes=T, main="RGB123", colNA="gray", bgalpha=100)
dev.off()

png(filename="./results/New_11_setembro/GDM/Maps/plotRGB231.png")
plotRGB(pcaRast, r=2, g=3, b=1,stretch='hist', axes=T, main="RGB231", colNA="gray", bgalpha=100)
dev.off()

##Figure X: Predicted spatial variation in species composition.
#Grid cells mapped in similar colors are predicted to have similar species composition, while cells mapped in very different colors are predicted to be highly dissimilar in composition.
# Colors represent gradients in species composition derived from transformed environmental predictors.
# Locations with similar colors are expected to contain similar communities.
