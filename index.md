## Caatinga domain, the largest continuous dry tropical forest.
### Study authors: BRUNO COUTINHO KURTZ,  DIEGO MEIRELES MONTEIRO, MARINEZ F. SIQUEIRA AND TAINÁ ROCHA
### Codes and GitHub pages author: Tainá Rocha 

<p align="justify">Seasonally dry tropical forests (SDTF) are one the most threatened and least studied ecosystems in the world (e.g., Miles et al. 2006, Sunderland et al. 2015). They can be characterized as forests or woodlands that occur in regions experiencing low annual precipitation (500-1500 mm) with strongly seasonal rainfall (5-8 dry months), generally concentrated in the summer (Mooney et al. 1995, FAO 2001). At the beginning of the 21st-century, remnants of SDTF were estimated to cover approximately 1 million km2 globally, with more than half of that are located in South America. In general, those remnant areas are threatened by climate change, fragmentation, burning, conversion to agricultural uses, and demographic pressure (Miles et al. 2006). The Caatinga domain, in Brazil, harbors the largest continuous area of SDTF in the Neotropics (Särkinen et al. 2011, DryFlor 2016). That domain comprises an area of 912,529 km2, under the influence of a semiarid climate (Silva et al. 2017), encompassing all of the states in the northeastern region of Brazil, as well as a small portion of northern Minas Gerais State (southeast region of the country). Two major types of SDTF are floristically distinguishable within the de Caatinga domain: the vegetation growing on crystalline rock terrains (Crystalline Caatinga or Caatinga sensu stricto) and that growing on the sandy terrains of sedimentary basins (Sedimentary Caatinga; Moro et al. 2016, Queiroz et al. 2017). Besides those major vegetation types, there are stretches of tall deciduous and semi-deciduous forests, associated with greater water supplies and richer soils, including those derived from karstic deposits (Queiroz et al. 2017). </p>

We compared the woody component of Cistalino Caatinga areas. Our aim was to examine the phytogeographical patterns within that geographical scale, determining the relative contribution of species turnover/nestedness to beta diversity composition. Considering the high environmental heterogeneity within Caatinga SDTF, we would expect a predominance of species turnover in relation to species nestedness in the composition of beta diversity.

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
 






