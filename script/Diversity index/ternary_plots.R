################################################################################
## Ternary plots tests and olthers tests for plots beta diversity index
################################################################################


library(Ternary)
library(ggtern)
library(betapart)
library(vegan)


dist.jac <- beta.pair(matrix_similaridade_caatinga_[,-1], index.family = "jaccard")

bd.jac <- betadisper(dist.jac[[3]])
################# NMDS

J.nmds = metaMDS(matrix_similaridade_caatinga_[,-1], distance="jaccard", k=2, trymax=1000)

par(mfrow = c(1, 1))
#Create a blank plot for the nmds
plot(J.nmds, type="n", main="Jaccard")
#Add the points colored by age
points(J.nmds, display="sites", pch=20, col=c("blue", "green", "red")[matrix_similaridade_caatinga_$X])
#Add a legend
legend(-5.5, 2.5, legend=c("2w","8w","1yr"), col=c("green","red","blue"), pch=20)





######### PLOT ### To test 
ggtern(data = caatinga_simi,aes(x=jaccard_caatinga$beta.jtu, y=jaccard_caatinga$beta.jne, z=jaccard_caatinga$beta.jac)) +
  geom_point()


TernaryPlot(jaccard_caatinga)

TernaryPlot(
  atip = jaccard_caatinga$beta.jtu,
  btip = jaccard_caatinga$beta.jne,
  ctip = jaccard_caatinga$beta.jac)

plot(density(jaccard_caatinga$beta.jtu))
plot(density(jaccard_caatinga$beta.jne))
plot(density(jaccard_caatinga$beta.jac))

############# To test 
TernaryPlot(
  atip = caatinga_simi$shared,
  btip = caatinga_simi$not.shared,
  ctip = caatinga_simi$sumSi)


ggtern(data = caatinga_simi,aes(x=caatinga_simi$a, y=caatinga_simi$St, z=caatinga_simi$sumSi)) +
  geom_point()
