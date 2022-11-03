#############################
# GDM 
# R version 4.2.1
# GDM package version
# Linux 
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

# Formatimg spp table and rater data 

sitePairRast <- formatsitepair(sppdata, 
                               bioFormat=2, 
                               #dist = "bray",
                               XColumn="LONG",
                               YColumn="LAT", 
                               sppColumn="species",
                               siteColumn="sites", 
                               predData=pres_cristalino_envs,
                               sppFilter=50)
# Remove NA values
sitePairRast <- na.omit(sitePairRast)


# Run GDM Model -----------------------------------------------------------

# Fit raster GDM
gdmRastMod <- gdm(sitePairRast, geo=TRUE)
summary(gdmRastMod)

str(gdmRastMod)

## Plots

tiff(file="GDM_Pred_1",
     width=9, height=7, units="in", res=150)
plot(gdmRastMod, plot.layout=c(1,2))
dev.off()
#plot(gdmRastMod)


plot(gdmRastMod$x[,"Geographic"], gdmRastMod$y[,"Geographic"], lwd=3,
     type="l", xlab="Geographic distance", ylab="Partial ecological distance")


# Predictions -------------------------------------------------------------

gdm.pred <- predict(gdmRastMod, sitePairRast)
head(gdm.pred)

tiff(file="GDM_Pred_2",
     width=9, height=7, units="in", res=150)
plot(sitePairRast$distance, gdm.pred, xlab="Observed dissimilarity",
     ylab="Predicted dissimilarity", xlim=c(0,1), ylim=c(0,1), pch=20, col=rgb(0,0,1,0.5))

lines(c(-1,2), c(-1,2))
dev.off()

# Trasform

rastTrans <- gdm.transform(gdmRastMod, pres_cristalino_envs)

# Remove NA

rastDat <- na.omit(getValues(rastTrans))

# Sample Random

rastDat <- sampleRandom(rastTrans, 10000)

# PCA

pcaSamp <- prcomp(rastDat)

# G space

# Predict note the use of the 'index' argument

pcaRast <- predict(rastTrans, pcaSamp, index=1:3)

# scale rasters
pcaRast[[1]] <- (pcaRast[[1]]-pcaRast[[1]]@data@min) /
  (pcaRast[[1]]@data@max-pcaRast[[1]]@data@min)*255
pcaRast[[2]] <- (pcaRast[[2]]-pcaRast[[2]]@data@min) /
  (pcaRast[[2]]@data@max-pcaRast[[2]]@data@min)*255
pcaRast[[3]] <- (pcaRast[[3]]-pcaRast[[3]]@data@min) /
  (pcaRast[[3]]@data@max-pcaRast[[3]]@data@min)*255

plotRGB(pcaRast, r=1, g=2, b=3)

writeRaster(pcaRast, "results/GDM/Final/G_Space_Dissimi_GDM.tif")


# Other Statistics --------------------------------------------------------

# GDM var importance and significance 

var_importance <- gdm.varImp(sitePairRast, geo=TRUE, splines = NULL,
           predSelect = FALSE, nPerm = 100, pValue=0.05, parallel = TRUE, cores = 2,
           sampleSites = 1, sampleSitePairs = 1)

erer::write.list(var_importance, "gdm_vars_impor_signi.csv")


# GDM crossvalidation

validation_GDM <- gdm.crossvalidation(sitePairRast, train.proportion=0.7, n.crossvalid.tests=5,
                    geo=FALSE, splines=NULL, knots=NULL)

erer::write.list(validation_GDM, "gdm_validation_crossvalid.csv")

