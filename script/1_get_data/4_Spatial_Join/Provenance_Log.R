#############################
##
#############################


library(logr)
library(rdtLite)

## Run the following lines as soon as you start the section.

prov.init(
  prov.dir = "./",
  overwrite = FALSE,
  snapshot.size = 0,
  hash.algorithm = "md5",
  save.debug = FALSE)


log_open(file_name = "./log_join", logdir = TRUE, show_notes = TRUE, autolog = TRUE)





## Run This lines in the afetr run all script in this folder

log_close()


prov.quit()
