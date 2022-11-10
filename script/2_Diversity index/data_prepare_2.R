library(dplyr)
library(readr)

## Remove site less than 5 species 

betapart_input = read.csv("data/betapart_Input/betapart_input.csv", sep = " ")

betapart_input_2 = t(betapart_input[-1])

beta_input_3 = betapart_input_2[,colSums(betapart_input_2) > 4]

beta_input_4 = t(beta_input_3)

beta_input_final = as.data.frame(beta_input_4)

write_csv(beta_input_final, "data/betapart_Input/betainput_final.csv")
