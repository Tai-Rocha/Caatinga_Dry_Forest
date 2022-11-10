library(dplyr)

test = t(matrix_similaridade_cristalino_[-1])

test_2 = colSums(test[,-1])

test_3 = as_data_frame(test_2)
