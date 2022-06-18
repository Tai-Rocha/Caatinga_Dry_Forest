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
