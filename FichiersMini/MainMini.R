#Fichier contenant le main, c est lui qui fera l appel aux differentes fonctions

#chargement des fichiers
setwd("C:\Users\user\Desktop\R\MovieLens")
ratingsMini=read.table("ratingsMini",sep ="",na.strings = "NA",col.names=c("Uid","Mid","Rtg","Ts"))
itemsMini=read.table("itemsMini",sep =";",na.strings = "NA")
usersMini=read.table("usersMini",sep =";",na.strings = "NA")


#objets utils

#chargement des fonctions
source("LienItemRatingsMini.R")

lienItemRatingsMini()
ordonnerRatingsMini()