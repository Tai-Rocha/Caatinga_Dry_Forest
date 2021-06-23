#############################
##
#############################



library(logr)
library(rdtLite)

## Run folooew lines in the begin

prov.init(
  prov.dir = "./",
  overwrite = FALSE,
  snapshot.size = 0,
  hash.algorithm = "md5",
  save.debug = FALSE)


log_open(file_name = "./log_gbif", logdir = TRUE, show_notes = TRUE, autolog = TRUE)





## Run This command in the os last script filer folder.

log_close()


prov.quit()
