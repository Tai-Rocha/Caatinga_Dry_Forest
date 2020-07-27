
## Librarys

library(factoextra)
library(FactoMineR)


## Read and Load data


CA_INPUT <- read.csv("./data/tables/input_data_prepare_for_PCA/pca_long.csv", sep = ",", dec = ".")

# CA analysis 

res.ca.caatinga <- CA(PCA_INPUT[1:23], graph = FALSE)

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
  select.ind = list(name = CA_INPUT$sitios))

## Col


fviz_ca_col(res.ca.caatinga, repel = TRUE, title= "Correspondence analysis")
