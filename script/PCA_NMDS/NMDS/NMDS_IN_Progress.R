### Load Data


### standardize unit of variables to build  

nmds_caatinga<-decostand(PCA_INPUT[1:23], method="standardize")

#pca_caatinga<-decostand(PCA_INPUT[1:23], method="standardize")


metaMDS(comm, distance = "bray", k = 2, try = 20, trymax = 20, 
        engine = c("monoMDS", "isoMDS"), autotransform =TRUE,
        noshare = (engine == "isoMDS"), wascores = TRUE, expand = TRUE, 
        trace = 1, plot = FALSE, previous.best,  ...)
## S3 method for class 'metaMDS'
plot(x, display = c("sites", "species"), choices = c(1, 2),
     type = "p", shrink = FALSE,  ...)

birds<-read.csv('https://raw.githubusercontent.com/collnell/lab-demo/master/bird_by_fg.csv')

nmds<-metaMDS(nmds_caatinga, distance="jaccard", k=2, trymax=35, autotransform=TRUE) ##k is the number of  dimensions
 ##metaMDS takes eaither a distance matrix or your community matrix (then requires method for 'distance=')

stressplot(nmds)
