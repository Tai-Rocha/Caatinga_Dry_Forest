#########################
# Correspondece analysis 
######################### 

# Library

library(factoextra)
library(FactoMineR)


## Read and Load data


CA_INPUT <- read.csv("./data/tables/New/PcoA/pcoa_input.csv", sep = ",", dec = ".")

# CA analysis 

res.ca.caatinga <- CA(CA_INPUT[,-1], graph = FALSE)

print(res.ca.caatinga)

get_eigenvalue(res.ca.caatinga)

fviz_eig(res.ca.caatinga):
  
#### Row
  
row <- get_ca_row(res.ca.caatinga)
row

fviz_ca_row(res.ca.caatinga, repel = TRUE, title= "Correspondence analysis")

fviz_ca (
  res.ca.caatinga, 
  title = "Correspondence",
  select.ind = list(name = CA_INPUT[1]))

## Col


fviz_ca_col(res.ca.caatinga, repel = TRUE, title= "Correspondence analysis")
