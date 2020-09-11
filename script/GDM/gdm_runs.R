#############################
## GDM RUN
#############################

## Library

library(gdm)


## Read inputs (species_site table and enviromental table)
sppdata <- read.csv("./data/tables/New/GDM_INPUT/sppdata.csv")

envtab <- read.csv("./data/tables/New/GDM_INPUT/envtab_9_variables.csv")

## site xy spp list, table-table
exFormat2a <- formatsitepair(sppdata, 2, XColumn="Long", YColumn="Lat", sppColumn="species", siteColumn="site", predData=envtab)

gdm_run <- gdm(exFormat2a, geo=FALSE, splines=NULL, knots=NULL)

plot(gdm_run)

sta <-str(gdm_run)
