#############################
##
#############################


library(logr)
library(rdtLite)

prov.init(
  prov.dir = "./",
  overwrite = TRUE,
  snapshot.size = 0,
  hash.algorithm = "md5",
  save.debug = FALSE)


prov.quit()