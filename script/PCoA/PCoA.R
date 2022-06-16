##################################
# Principal coordinates analysis
# Author: Tainá Rocha
##################################

#Library

library(tidyverse)
library(vegan)
library(ggvegan)
library(ggplot2)


# Vegan
# The naming conventions vary. The one adopted here is traditional rather than truthful to priority. The function finds either quantitative or binary variants of the indices under the same name, which correctly may refer only to one of these alternatives For instance, the Bray index is known also as Steinhaus, Czekanowski and Sørensen index. The quantitative version of Jaccard should probably called Ružička index. The abbreviation "horn" for the Horn--Morisita index is misleading, since there is a separate Horn index. The abbreviation will be changed if that index is implemented in vegan (https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/vegdist)


#caatinga_pcoa_vegan <- read.csv("data/PCoA/pcoa_input.csv", sep = " ")

caatinga_pcoa_vegan <- read.csv("data/PCoA/env_values_in_GRIDS_bilinear_NONA.csv", sep = ",")

## To get the names of sites
rownames(caatinga_pcoa_vegan) <- caatinga_pcoa_vegan[,1]
caatinga_pcoa_vegan <- caatinga_pcoa_vegan[,-1]
caatinga_pcoa_vegan

## To get the names of sites, another way  (tidyverse)

#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

## Distance

vegan_dist_caatinga <-vegdist(caatinga_pcoa_vegan[1:25],"euclidean", binary=FALSE)

#vegan_dist_caatinga <- vegan::decostand(vegan_dist_caatinga, method = "range")

#rm(vegan_dist_caatinga)
## To get the names of sites (tidyverse)
#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

pcoa_stdf <- cmdscale(vegan_dist_caatinga, k=5, eig = TRUE)  # a função cmdscale é para fazer a PCoA, k is axis numbers and eig is explaination


pcoa_stdf # eig is autovalues (eigenvalues), GOF is explaination percentage of axisi defined by K

sum(pcoa_stdf$eig) # values x sum og eig values 

pcoa_stdf$eig / sum(pcoa_stdf$eig) # Fraction of explanation for each axis 

percent <- 100 * pcoa_stdf$eig / sum(pcoa_stdf$eig) # percentage 

percent[1:2]  # percent of two frist axis 

#dev.new(title="PCoA of floristic")

################# Plot

### GGplot
pcoa_df = tibble(PCoA_1 = pcoa_stdf$points[,1], 
                 PCoA_2 = pcoa_stdf$points[,2])



p = ggplot(pcoa_df, aes(x = PCoA_1, y = PCoA_2)) + 
  geom_point() +
  labs(x= "PCoA_1= 58.7%", y="PCoA_2= 12.5%")
p


##############



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



