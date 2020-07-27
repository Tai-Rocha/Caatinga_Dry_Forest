###############################
## Species accumulation curves
## Author: Tainá Rocha
## June 2020
###############################


## Library

library(vegan)

## Load data

SAC <- read.csv("./data/tables/CAE/input_teste.csv", sep = ",")

##########
coleman <- specaccum(SAC[2:3], method = "coleman", permutations = 100, conditioned =TRUE, gamma = "jack1")

plot(coleman, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")

##########
exact <- specaccum(SAC[2:3], method = "exact", permutations = 100,
                   conditioned =TRUE, gamma = "jack1")


plot(exact, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")

##########

collector <- specaccum(SAC[2:3], method = "collector", permutations = 100,conditioned =TRUE, gamma = "jack1")


plot(collector, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")


##########

random <- specaccum(SAC[2:3], method = "random", permutations = 100,conditioned =TRUE, gamma = "jack1")


plot(random, ci.type="poly", col="blue", lwd=2, ci.lty=0, ci.col="lightblue")

boxplot(sp2, col="yellow", add=TRUE, pch="+")