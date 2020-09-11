#############################
## GDM RUN
#############################

## Library

library(gdm)

## Read inputs (species_site table and enviromental table)
sppdata <- read.csv("./data/tables/New/GDM_INPUT/sppdata.csv")

envtab <- read.csv("./data/tables/New/GDM_INPUT/envtab_all_lat_long.csv")

## site xy spp list, table-table
exFormat2a <- formatsitepair(sppdata, 2, XColumn="Long", YColumn="Lat", sppColumn="species", siteColumn="site", predData=envtab)

gdm_run <- gdm(exFormat2a, geo=TRUE, splines=NULL, knots=NULL)

plot(gdm_run)

sta <-str(gdm_run)


#### Quantify model significance and variable importance/significance in gdm using matrix permutation.

caatinga_imporatnce <- gdm.varImp(exFormat2a, geo = F, splines = NULL, knots = NULL, fullModelOnly = FALSE, 
           nPerm = 50, parallel = FALSE, cores = 4, sampleSites = 1, sampleSitePairs = 1,
           outFile = NULL)

### Barplot
barplot(sort(caatinga_imporatnce[[2]][,1], decreasing=T), space= 1.5, axisnames= T, font.sub=2, cex.names = 0.8)

