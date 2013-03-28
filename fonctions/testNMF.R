library(NMF)
library(pkgmaker)
library(rngtools)
library(registry)
library(digest)
library(grid)
n = 20
counts= c(5, 3, 2)
p = sum(counts)
x = syntheticNMF(n, counts)

dim(x)