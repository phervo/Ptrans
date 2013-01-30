#Fichier contenant le main, c est lui qui fera l appel aux differentes fonctions

#chargement des fichiers
genre=read.table("FichierDonnees/genre",sep ="|",na.strings = "NA")
# items=read.table("FichierDonnees/items",sep =";",na.strings = "NA")
items=read.table("FichiersMini/itemsMini",sep =";",na.strings = "NA")
#users=read.table("FichierDonnees/users",sep =";",na.strings = "NA")
users=read.table("FichiersMini/usersMini",sep =";",na.strings = "NA")
#ratings=read.table("FichierDonnees/ratings",sep ="",na.strings = "NA",col.names=c("Uid","Mid","Rtg","Ts"))
ratings=read.table("FichiersMini/ratingsMini",sep ="",na.strings = "NA",col.names=c("Uid","Mid","Rtg","Ts"))

#objets utils

#chargement des fonctions

source("fonctions/LienItemRating.R")
source("fonctions/AutresFonctions.R")


#test d appels de fonctions
lienItemRating()
ordonnerRating()

x=merge(ratings,users,by.x="V1",by.y="V1")
z=merge(ratings,items,by.x="Mid",by.y="V1")