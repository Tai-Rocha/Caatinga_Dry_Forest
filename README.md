# Pernambuco

This is a repository for analysis of 24 Caatinga sites. We're investigating the phytogeographica patterns determining the relative contribution of species turnover/nestedness to beta diversity composition.

We split script folders and subfolders as follow:


- exploratory: extract enviromental values in 24 points using INPE climatic and topographic data ( http://www.dpi.inpe.br/Ambdata/download.php ) and raster pckg         (https://www.rdocumentation.org/packages/raster/versions/3.3-7)


- PCA_NMDS:

    - Data_Prepare_for_PCA: script to prepare input data to run PCA analysis.
    
    - PCA_Analysis: scripts for PCA analysis in stats 3.6.2 pckg ( https://www.rdocumentation.org/packages/stats/versions/3.6.2/ ),and factoextra pckg                     (https://www.rdocumentation.org/packages/factoextra/versions/1.0.7)
    
    
    
    
- Cluster:  cluster analysis using pvclust pck ( https://github.com/shimo-lab/pvclust )
