### Caatinga domain, the largest continuou dry tropical forest.

Seasonally dry tropical forests (SDTF) are one the most threatened and least studied ecosystems in the world (e.g., Miles et al. 2006, Sunderland et al. 2015). They can be characterized as forests or woodlands that occur in regions experiencing low annual precipitation (500-1500 mm) with strongly seasonal rainfall (5-8 dry months), generally concentrated in the summer (Mooney et al. 1995, FAO 2001). At the beginning of the 21st-century, remnants of SDTF were estimated to cover approximately 1 million km2 globally, with more than half of that are located in South America. In general, those remnant areas are threatened by climate change, fragmentation, burning, conversion to agricultural uses, and demographic pressure (Miles et al. 2006). The Caatinga domain, in Brazil, harbors the largest continuous area of SDTF in the Neotropics (Särkinen et al. 2011, DryFlor 2016). That domain comprises an area of 912,529 km2, under the influence of a semiarid climate (Silva et al. 2017), encompassing all of the states in the northeastern region of Brazil, as well as a small portion of northern Minas Gerais State (southeast region of the country). Two major types of SDTF are floristically distinguishable within the de Caatinga domain: the vegetation growing on crystalline rock terrains (Crystalline Caatinga or Caatinga sensu stricto) and that growing on the sandy terrains of sedimentary basins (Sedimentary Caatinga; Moro et al. 2016, Queiroz et al. 2017). Besides those major vegetation types, there are stretches of tall deciduous and semi-deciduous forests, associated with greater water supplies and richer soils, including those derived from karstic deposits (Queiroz et al. 2017).

### MATERIALS AND METHODS

#### Data source and analysis 

- [x] [Rocc](https://github.com/liibre/Rocc) worflow  to get occurrence for Caatinga Cristalino. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/get_data)


- [x]  Exploratory data analysis: extract enviromental values of 24 test points using [INPE](http://www.dpi.inpe.br/Ambdata/download.php) climatic and topographic data. I use [raster](https://www.rdocumentation.org/packages/raster/versions/3.3-7) pacakge to do this analysis.  [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/exploratory)     

- [x]  GDM models. Ok for 24 sites test. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/GDM) .


- [x]  PCoA . Ok for 24 sites test. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/blob/master/script/PCoA/PCoA.R) .


    - Data_Prepare_for_PCA: script to prepare input data to run PCA analysis.
    
    - PCoA_Analysis: scripts for PCA analysis in [stats 3.6.2]( https://www.rdocumentation.org/packages/stats/versions/3.6.2/ ) and [factoextra](https://www.rdocumentation.org/packages/factoextra/versions/1.0.7) pacakges                    
    
        
- [x]  Cluster analysis using [pvclust]( https://github.com/shimo-lab/pvclust ). Ok for 24 sites test. [Code acess](https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/tree/master/script/Cluster) .


### Preliminary Results 


The results of the Generalized dissimilarity model (GDM) showed a power of explanation higher than 50 percent (56.8%).
A visualization of spatial pattern of dissimilarity is shown in  Figure 1 , in which areas of similar colour are predicted to have similar floristic composition. Predictions for Petrolina sites (PE1 e PE2) show most difference compositions compared with others, i.e., major dissimilarities compared with other sites. Pedicted a greater ecological distance increasing observed compositional dissimilarity (Fig. 2 a) and higher compositional dissimilarity when the observed compositional dissimilarity increases (Fig. 2b). 

<img src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/raw/gh-pages/fig/GDM_google_docs.png" width="390"> <img align="right" width="500" height="400" src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest.github.io/raw/gh-pages/fig/GDM_old_Graphics.png" > 

Fig.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fig.2
 






