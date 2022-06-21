

library(vegan)
library(ape)
library(ggplot2)


#caatinga_pcoa_vegan <- read.csv("data/PCoA/pcoa_input.csv", sep = " ")

df <- read.csv("data/PCoA/env_values_in_GRIDS_bilinear_NONA.csv", sep = ",")

df <- df[,-1]

## To get the names of sites

rownames(df)<-paste0("site",1:5308)

##  Compute dissamilaty matix

bray_dist<-vegdist(df,"euclidean", binary=TRUE)

df.pcoa<-pcoa(bray_dist,correction = "cailliez")
df.pcoa$vectors
df.pcoa$values


df.plot<-data.frame(df.pcoa$vectors)

head(df.plot)


df.pcoa$values$Relative_eig[1]*100

x_label<- 67.03976

y_label <- 24.88249



ggplot(data=df.plot,aes(x=Axis.1,y=Axis.2))+
  
  
  geom_point()+
  
  
  theme_bw()+
  
  
  theme(panel.grid = element_blank())+
  
  
  geom_vline(xintercept = 0,lty="dashed")+
  
  
  geom_hline(yintercept = 0,lty="dashed")+
  
  
  labs(x=paste0("PCoA1 ",x_label,"%"),
       
       
       y=paste0("PCoA2 ",y_label,"%"))






df.plot$group<-ifelse(df.plot$Axis.1>0,"AAA","BBB")

df.plot$group


ggplot(data=df.plot,aes(x=Axis.1,y=Axis.2,
                        
                        
                        color=group,shape=group))+
  
  
  geom_point(size=5)+
  
  
  theme_bw()+
  
  
  theme(panel.grid = element_blank())+
  
  
  geom_vline(xintercept = 0,lty="dashed")+
  
  
  geom_hline(yintercept = 0,lty="dashed")+
  
  
  labs(x=paste0("PCoA1 ",x_label,"%"),
       
       
       y=paste0("PCoA2 ",y_label,"%"))+
  
  
  stat_ellipse(data=df.plot,
               
               
               geom = "polygon",
               
               
               aes(fill=group),
               
               
               alpha=0.1)+
  
  
  scale_fill_manual(values = c("#e31a1c","#1f78b4"))

################## Not Runb from here
pcoa_flor <-ordiplot(scores(pcoa_floristic_caatinga, choices = c(1,2)), type = "t", main= "PCoA of floristic matrix")

abline(h=0, lty=3)
abline(v=0, lty=3)


# Add weighted average projection of species
#spe.wa <- wascores(pcoa_floristic_caatinga$points[,1:2], caatinga_pcoa_vegan)
#text(spe.wa, rownames(spe.wa), cex=0.7, col="red")


####### Explanied percentage

# Extract PCoA coordinates
Coordinates <- data.frame(
  Sample = row.names(pcoa_floristic_caatinga$points),
  Dim1 = pcoa_floristic_caatinga$points[,1],
  Dim2 = pcoa_floristic_caatinga$points[,2],
  row.names = NULL
) %>%
  as.tbl()

# Calculate variance explained
# Method is from http://r-sig-ecology.471788.n2.nabble.com/\
# Variability-explanations-for-the-PCO-axes-as-in-Anderson-and-Willis-2003-\
# td6429547.html
Eigenvalues <- eigenvals(pcoa_floristic_caatinga) 
Variance <- Eigenvalues / sum(Eigenvalues) 
Variance1 <- 100 * signif(Variance[1], 2)
Variance2 <- 100 * signif(Variance[2], 2)

# Return
Result <- list(
  Coordinates = Coordinates,
  Variance1 = Variance1,
  Variance2 = Variance2
)
return(Result)


############ Climatic data

#Read data 

climatic_caatinga <- read.csv("./data/tables/New/PcoA/PCoA_envs.csv")

## To get the names of sites
rownames(climatic_caatinga) <- climatic_caatinga[,1]
climatic_caatinga <- climatic_caatinga[,-1]
climatic_caatinga

###  MAtrix Distance based on climatic data in points

Euclidian_Climatic <- dist(climatic_caatinga, method = "euclidean")


# Vegan
eucl_clim <-cmdscale(Euclidian_Climatic,k=2,eig=TRUE)
eucl_clim

pcoa_climatic <-ordiplot(scores(eucl_clim, choices = c(1,2)), type = "t", main= "PCoA of climatic matrix")
abline(h=0, lty=3)
abline(v=0, lty=3)

####### Explanied percentage

# Extract PCoA coordinates
Coordinates <- data.frame(
  Sample = row.names(eucl_clim$points),
  Dim1 = eucl_clim$points[,1],
  Dim2 = eucl_clim$points[,2],
  row.names = NULL
) %>%
  as.tbl()

# Calculate variance explained
# Method is from http://r-sig-ecology.471788.n2.nabble.com/\
# Variability-explanations-for-the-PCO-axes-as-in-Anderson-and-Willis-2003-\
# td6429547.html
Eigenvalues <- eigenvals(eucl_clim) 
Variance <- Eigenvalues / sum(Eigenvalues) 
Variance1 <- 100 * signif(Variance[1], 2)
Variance2 <- 100 * signif(Variance[2], 2)

# Return
Result <- list(
  Coordinates = Coordinates,
  Variance1 = Variance1,
  Variance2 = Variance2
)
return(Result)


