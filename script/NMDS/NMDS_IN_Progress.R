
## Librarys

library(factoextra)
library(FactoMineR)
library(ggcorrplot)
library(ggplot2)
library(psych)
library(rgdal)
library(rgeos)
library(vegan)
library(raster)
library(data.table)
library(sf)
library(dplyr)



### Funtion to load recods

load_occ <- function(path, crs_num = NULL) {
        temp_occ <- fread(path, sep = "\t", header = T)
        sel_col <- c("decimalLatitude", "decimalLongitude")
        temp_occ_narrow <- unique(temp_occ[, ..sel_col])
        temp_occ_narrow <- temp_occ_narrow[!is.na(decimalLongitude) & !is.na(decimalLatitude)]
        coordinates(temp_occ_narrow) <- ~ decimalLongitude + decimalLatitude
        crs(temp_occ_narrow) <- crs("+init=epsg:4326")
        if (!is.null(crs_num)) {
                tempcrs <- CRS(paste0("+init=epsg:", crs_num))
                temp_occ_narrow <- spTransform(temp_occ_narrow, tempcrs)
        }
        return(temp_occ_narrow)
}


arbus_arbo <- load_occ( './data-raw/gbif/0282703-200613084148143.csv')

xy_points <- as.data.frame(arbus_arbo@coords)

######## List and stack variable

list_vars <- list.files("./data/10km/", pattern = ".tif", full.names = T)

vars <- stack(list_vars)

plot(vars)

# Extract vals in coord

vals_in_xy <- extract(vars, xy_points) #select long and lat

## Remove  NA

vals_in_xy_coord <- cbind(vals_in_xy, xy_points)

vals_final <- na.omit(vals_in_xy_coord)

vals_final <- as.data.frame(vals_final)

vals_small_test <-  vals_final |> 
        slice(1:50)     


## NMDS
nmds <- metaMDS(vals_small_test[1:25], distance="bray", k=3, trymax=35, autotransform=TRUE) ##k is the number of  dimensions
## metaMDS takes either a distance matrix or your community matrix (then requires method for 'distance=')

#write.table(nmds,"./data/nmds.csv", sep = ",")

scores <- scores(nmds, display = 'sites')


####

# Convert NMDS-scores to SpatialPoints objects
coords = as.data.frame(vals_small_test[26:27])
names(coords) = c("decimalLongitude","decimalLatitude")
nmds_scores<-cbind(coords, scores)
coordinates(nmds_scores) <- ~decimalLongitude+decimalLatitude # Convert 'nmds_scores'> dataframe to SpatialPointsDataframe
wgs84<-"+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" # WGS84 Coordinate Reference System (CRS)
crs(nmds_scores) <- wgs84 # Set the original CRS (WGS84)
#new_crs <-"+proj=robin +lon_0=0 +x_0=0 +y_0=0 +a=6371000 +b=6371000 +units=m+no_defs" # Transform CRS to Robinson projection (it is necessary to have projected data for interpolation)
 nmds_scores <- spTransform(nmds_scores, new_crs)
 # Read the shapefile of Brazilian Atlantic Forest (BAF) and rasterize it
 BAF_limit<-readOGR("./data-raw/Shape_Mun_Cristalino/mun_caatinga_cristalino.shp")
         BAF_limit<-spTransform(BAF_limit, wgs84) # Change the CRS from SIRGAS2000 to WGS84
         r_ext<-extent(BAF_limit)
         r<-raster() # Create a empty raster to receive data
         res(r)<-0.02166667 # Define raster resolution in decimal degrees (= 10 arc-min)
 r<-crop(r, r_ext) # Define spatial extent of the raster (same as BAF)
 BAF_raster<-rasterize(BAF_limit, r, field=1, background=NA)

 # Get the spatial coordinates of BAF pixels
get_coords<-rasterToPoints(vars)
         get_coords<-as.data.frame(get_coords[, c(1:2)])
         get_coords<-cbind(get_coords, NA, NA, NA)
         names(get_coords)<-c("longitude", "latitude", "NMDS1", "NMDS2", "NMDS3")
         coordinates(get_coords)<-~longitude+latitude # Convert 'get_coords' dataframe to SpatialPointsDataframe
         crs(get_coords)<-wgs84 # Set the original CRS (WGS84)
         crs(vars)<-wgs84
         #get_coords<-spTransform(get_coords, new_crs) # Transform CRS to Robinson projection
        
         Model_ok  <- gstat( id='NMDS1_kri',  formula= NMDS1 ~ 1 , data = nmds_scores)
         
         G0y_ok <- interpolate(vars, Model_ok, xyOnly=F )

plot(G0y_ok)

plot(BAF_raster)
writeRaster(G0y_ok,"./data/test.tif", format="GTiff")
                                                
#Hi Alexandre,looks like you are trying to apply inverse distance weighting with gstat For that your command should be something like this:
rm(Baf])
                                                
#Where X is a data.frame of your coordinates with NMDS scores or a spatial object like your nmds_scores.









##Statistic PCA
statistical_summary <- describe(vals_point)
write.table(statistical_summary, './statistical_summary_pca.txt')

#vals <- na.omit(vals_point) ## Eliminando linhas com NA
#write.table(vals, './vals_point.txt')

### standardize unit of variables to build PCA  

vals_pca<-decostand(vals_point_final, method="standardize")

write.table(vals_pca, './final_pca_standardize.txt')



### standardize unit of variables to build  

nmds_caatinga<-decostand(PCA_INPUT[1:23], method="standardize")

#pca_caatinga<-decostand(PCA_INPUT[1:23], method="standardize")


metaMDS(comm, distance = "bray", k = 2, try = 20, trymax = 20, 
        engine = c("monoMDS", "isoMDS"), autotransform =TRUE,
        noshare = (engine == "isoMDS"), wascores = TRUE, expand = TRUE, 
        trace = 1, plot = FALSE, previous.best,  ...)
## S3 method for class 'metaMDS'
plot(nmds, display = c("sites", "species"), choices = c(1, 2),
     type = "p", shrink = FALSE,  ...)

birds<-read.csv('https://raw.githubusercontent.com/collnell/lab-demo/master/bird_by_fg.csv')

nmds<-metaMDS(nmds_caatinga, distance="jaccard", k=2, trymax=35, autotransform=TRUE) ##k is the number of  dimensions
 ##metaMDS takes eaither a distance matrix or your community matrix (then requires method for 'distance=')

stressplot(nmds)
