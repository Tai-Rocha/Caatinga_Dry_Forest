########################################
## Testes de Mantel
########################################

library(vegan) # carregar a biblioteca vegan
data(mite) # carregar dados-exemplo de uma comunidade. Linhas indicam as parcelas e as colunas representam as espécies.
data(mite.xy) # carregar coordenadas espaciais. Deve ser estruturada com linhas respresentando suas parcelas ou locais, e duas colunas, com suas coordenadas (x e y ou latitude e longitude).
spat.dist <- vegdist(mite.xy, "euclid") #Matriz de dissimilaridade espacial
veg.dist <- vegdist(mite) # Bray-Curtis #Matriz de dissimilaridade florística-estrutural
plot(spat.dist, veg.dist, xlab = "Distância espacial (m)", pch = 20, cex = 0.8) # plota a relação entre distância espacial x dissimilaridade
abline(lm(veg.dist ~ spat.dist), lwd = 2, col = "red") #plota a linha de regressão linear entre distância espacial x dissimilaridade
mantel(spat.dist, veg.dist) # realiza o Teste de
