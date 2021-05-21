##############################################################################################################################################
### Title: Data analysis of Caatinga Cristalino
### Study authors: BRUNO COUTINHO KURTZ,  DIEGO MEIRELES MONTEIRO, MARINEZ F. SIQUEIRA AND TAINÁ ROCHA
### Codes and GitHub pages author: Tainá Rocha 
### We are investigating the phytogeographical patterns and species turnover/nestedness (beta diversity composition) in Caatinga dry tropics
#### In progress. For preliminary results [click here](https://tai-rocha.github.io/Caatinga_Dry_Forest.github.io/)
##############################################################################################################################################

#### Script folders structure as follow:
<img align="right" width="330" height="300" src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest/raw/master/docs/Figs./Map_Cristalino_Caatinga.png"> 

## MATERIALS AND METHODS

### Data source

We first compared the environment for 22 phytosociological surveys of Cristalino Caatinga as a test, considering five topographic data and 19 climatic data from [INPE](http://www.dpi.inpe.br/Ambdata/download.php) and [wordclim v. 2.1](https://www.worldclim.org/data/worldclim21.html) respectively.
Next, we expanded sampling areas by data collection from online biodiversity databases, as follow:

- [x] Survey of species list (and records) by Cristalino counties shapefile using [Rocc pckg](https://github.com/liibre/Rocc) workflow. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/get_data). Output: species list with occurrence (PS.:records occur beyond the Cristalino counties shapefile
- [x] Select just records inside Cristalino counties shapefile, Qgis (Clip function of vector Geoprocessing tools)
- [x] Create a spatial vector for the Caatinga Cristalino whole area with 10 km grid cells using Qgis(v.3.18). Each grid cell represents the sample site. 

- [x] Spatial join between occurrence records with spatial vector of 10km grid cells using Qgis(v.3.18).

- [x]  Extract enviromental values of occurrence records using [raster](https://www.rdocumentation.org/packages/raster/versions/3.3-7) . [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/exploratory) 
    
### Multivariate analysis

#### Generalized Dissimilarity Modeling (GDM)

- [x]  Inputs : two tables (spp_data and env_table)

- [x]  GDM models for 22 sites test. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/GDM) .

- [ ]  GDM models for expanded sample

#### Principal Coordinates Analysis (PCoA): For florist matrix of 0 and 1

- [x]  Data_Prepare_for_PCA: script to prepare input data to run PCA analysis.

- [x]  PCoA . Ok for 22 sites test. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/blob/master/script/PCoA/PCoA.R) .                
    

#### Cluster 

- [x]  Ok for 22 sites test using [pvclust]( https://github.com/shimo-lab/pvclust ). [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/Cluster) .

#### Baselga metrics

- [x] βSOR (overall beta diversity), 0k for 22 sites
- [x] βsim (turnover), 0k for 22 sites
- [x] βSNE (nestedness), 0k for 22 sites


### Preliminary Results 


<p align="justify">The results of the Generalized dissimilarity model (GDM) showed a power of explanation higher than 50 percent (56.8%).
A visualization of spatial pattern of dissimilarity is shown in  Figure 1 , in which areas of similar colour are predicted to have similar floristic composition. Predictions for Petrolina sites (PE1 e PE2) show most difference compositions compared with others, i.e., major dissimilarities compared with other sites. Pedicted a greater ecological distance increasing observed compositional dissimilarity (Fig. 2 a) and higher compositional dissimilarity when the observed compositional dissimilarity increases (Fig. 2b).  </p>

<img src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/raw/gh-pages/fig/GDM_google_docs.png" width="390"> <img align="right" width="500" height="400" src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/raw/gh-pages/fig/GDM_old_Graphics.png" > 

Fig.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fig.2
 






