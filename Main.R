#Fichier contenant le main, c est lui qui fera l appel aux differentes fonctions

#chargement des fichiers
setwd("C:/Users/Py/Documents/Polytech/4emeAnnee/PTRANS/MovieLens")
items=read.table("items",sep =";",na.strings = "NA")
genre=read.table("genre",sep ="|",na.strings = "NA")
ratings=read.table("ratings",sep ="",na.strings = "NA",col.names=c("Uid","Mid","Rtg","Ts"))
users=read.table("users",sep =";",na.strings = "NA")

#objets utils
blablabla
#chargement des fonctions

source("test2.R")
source("LienItemRating.R")
lienItemRating()

ordonnerRating()

x=merge(ratings,users,by.x="V1",by.y="V1")
z=merge(ratings,items,by.x="Mid",by.y="V1")