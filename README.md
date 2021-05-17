##############################################################################################################################################
### Title: Data analysis of Caatinga Cristalino
### Study authors: BRUNO COUTINHO KURTZ,  DIEGO MEIRELES MONTEIRO, MARINEZ F. SIQUEIRA AND TAINÁ ROCHA
### Scripts and github structure Author: Tainá Rocha
### We are investigating the phytogeographical patterns and species turnover/nestedness (beta diversity composition) in Caatinga dry tropics
#### In progress. For preliminary results [click here](https://tai-rocha.github.io/Caatinga_Dry_Forest.github.io/)
##############################################################################################################################################

#### Script folders structure as follow:
<img align="right" width="330" height="300" src="https://github.com/Tai-Rocha/Caatinga_Dry_Forest/raw/master/docs/Figs./Map_Cristalino_Caatinga.png"> 

- [x] Rocc worflow (https://github.com/liibre/Rocc) to get occurrence for Caatinga Cristalino .


- [x]  Exploratory data analysis: extract enviromental values of 24 test points using INPE climatic and topographic data ( http://www.dpi.inpe.br/Ambdata/download.php ). I      use raster pckg to do this analysis       (https://www.rdocumentation.org/packages/raster/versions/3.3-7)

- [x]  GDM models. Ok for 24 sites test


- [x]  PCA_NMD. Ok for 24 sites test


    - Data_Prepare_for_PCA: script to prepare input data to run PCA analysis.
    
    - PCA_Analysis: scripts for PCA analysis in stats 3.6.2 pckg ( https://www.rdocumentation.org/packages/stats/versions/3.6.2/ ),and factoextra pckg                     (https://www.rdocumentation.org/packages/factoextra/versions/1.0.7)
    
    
    
    
- [x]  Cluster:  cluster analysis using pvclust pck ( https://github.com/shimo-lab/pvclust ). Ok for 24 sites test

