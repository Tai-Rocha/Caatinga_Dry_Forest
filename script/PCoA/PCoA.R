##################################
# Principal coordinates analysis
# Author: Tainá Rocha
##################################

#Library

library(tidyverse)
library(vegan)
library(ggvegan)
library(ggplot2)
library(ggfortify)

# Vegan
# The naming conventions vary. The one adopted here is traditional rather than truthful to priority. The function finds either quantitative or binary variants of the indices under the same name, which correctly may refer only to one of these alternatives For instance, the Bray index is known also as Steinhaus, Czekanowski and Sørensen index. The quantitative version of Jaccard should probably called Ružička index. The abbreviation "horn" for the Horn--Morisita index is misleading, since there is a separate Horn index. The abbreviation will be changed if that index is implemented in vegan (https://www.rdocumentation.org/packages/vegan/versions/2.4-2/topics/vegdist)


caatinga_pcoa_vegan <- read.csv("data/PCoA/env_values_in_GRIDS_bilinear_NONA_copy.csv", sep = ",")

## To get the names of sites
rownames(caatinga_pcoa_vegan) <- caatinga_pcoa_vegan[,1]
caatinga_pcoa <- caatinga_pcoa_vegan[,-1]
caatinga_pcoa

## To get the names of sites, another way  (tidyverse)

#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

## Distance

vegan_dist_caatinga <-vegdist(caatinga_pcoa[1:25],"euclidean", binary=FALSE)

#vegan_dist_caatinga <- vegan::decostand(vegan_dist_caatinga, method = "range")

#rm(vegan_dist_caatinga)
## To get the names of sites (tidyverse)
#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

pcoa_stdf <- cmdscale(vegan_dist_caatinga, k=5, eig = TRUE)  # a função cmdscale é para fazer a PCoA, k is axis numbers and eig is explaination

caatinga_pcoa_vegan$sites

pcoa_stdf # eig is autovalues (eigenvalues), GOF is explaination percentage of axisi defined by K

sum(pcoa_stdf$eig) # values x sum og eig values 

pcoa_stdf$eig / sum(pcoa_stdf$eig) # Fraction of explanation for each axis 

percent <- 100 * pcoa_stdf$eig / sum(pcoa_stdf$eig) # percentage 

percent[1:2]  # percent of two frist axis 

#dev.new(title="PCoA of floristic")

################# Plot

### GGplot
pcoa_df = tibble(PCoA_1 = pcoa_stdf$points[,1], 
                 PCoA_2 = pcoa_stdf$points[,2],
                 sites = caatinga_pcoa_vegan$sites)

png(file="PCoA_vars.png",
    width=9, height=7, units="in", res=300)
p = ggplot(pcoa_df, aes(x = PCoA_1, y = PCoA_2)) + 
  geom_point(aes(colour = sites), size = 3) +
  scale_color_identity() +
  coord_equal()+
  labs(x= "PCoA_1= 58.7%", y="PCoA_2= 12.5%")
p

dev.off()

########## Binary Matix

bi_caatinga_pcoa_vegan <- read.csv("data/PCoA/pcoa_input.csv", sep = " ")

## To get the names of sites
rownames(bi_caatinga_pcoa_vegan) <- bi_caatinga_pcoa_vegan[,1]
bi_caatinga_pcoa <- bi_caatinga_pcoa_vegan[,-1]
bi_caatinga_pcoa

## To get the names of sites, another way  (tidyverse)

#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

## Distance

bi_vegan_dist_caatinga <-vegdist(bi_caatinga_pcoa,"bray", binary=TRUE)

#vegan_dist_caatinga <- vegan::decostand(vegan_dist_caatinga, method = "range")

#rm(vegan_dist_caatinga)
## To get the names of sites (tidyverse)
#caatinga_pcoa_vegan<- column_to_rownames (caatinga_pcoa_vegan, var = 'sites')
#caatinga_pcoa_vegan

bi_pcoa_stdf <- cmdscale(bi_vegan_dist_caatinga, k=5, eig = TRUE)  # a função cmdscale é para fazer a PCoA, k is axis numbers and eig is explaination

rownames(bi_caatinga_pcoa_vegan)

bi_pcoa_stdf # eig is autovalues (eigenvalues), GOF is explaination percentage of axisi defined by K

sum(bi_pcoa_stdf$eig) # values x sum og eig values 

bi_pcoa_stdf$eig / sum(bi_pcoa_stdf$eig) # Fraction of explanation for each axis 

percent <- 100 * bi_pcoa_stdf$eig / sum(bi_pcoa_stdf$eig) # percentage 

percent[1:2]  # percent of two frist axis 

#dev.new(title="PCoA of floristic")

################# Plot

### GGplot
bi_pcoa_df = tibble(PCoA_1 = bi_pcoa_stdf$points[,1], 
                 PCoA_2 = bi_pcoa_stdf$points[,2],
                 sites = rownames(bi_caatinga_pcoa_vegan))

png(file="PCoA_binary.png",
    width=9, height=7, units="in", res=300)
p = ggplot(bi_pcoa_df, aes(x = PCoA_1, y = PCoA_2)) + 
  geom_point(aes(colour = sites), size = 3) +
  scale_color_identity() +
  coord_equal()+
  labs(x= "PCoA_1= 3.6%", y="PCoA_2= 2.6%")
p

dev.off()

##############



