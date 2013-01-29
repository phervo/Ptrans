lienItemRatingsMini=function()
{
  #on trie d'abord attention etape obligatoire 
  ratingsOrder=ordonnerRatingsMini()
  
  # Creation d'une matrice vide a remplir
  X = nrow(usersMini)#attention a bien utiliser users car on fait pour chaque utilisateur
  Y = nrow(itemsMini)
  Z = nrow(ratingsOrder)  
  matriceNote=data.frame(matrix(0,nrow=X,ncol=Y)) #0 represente le fait que le film soit non emprunte
  
  # Mise en place des noms des lignes et colonnes
  rownames(matriceNote) = usersMini[,1]
  colnames(matriceNote) = itemsMini[,1]
  
  #parcours simple des lignes du  fichier rating
  for( i in 1:Z)
  {
    #on insere a la case 
    matriceNote[ratingsOrder[i,1],ratingsOrder[i,2]]=ratingsOrder[i,3]
  }
  matriceNote
}

ordonnerRatingsMini=function(){
  #fonction qui ordonne le data frame rating 
  ratingso <- ratingsMini[order(ratingsMini$Uid,ratingsMini$Mid), ]
  return(ratingso)
}

userToItem<-function(Uid)
{
  # Fonction qui prend en parametre un id user et qui retourne une matrice binaire des items empruntes
  # exemple d utilisation
  # MAt=userToItem(6)
  # MAt[86,1]
  
  matriceNote=lienItemRatingsMini()
  nBooks = ncol(matriceNote)
  
  # Creation d'une matrice vide a remplir
  matriceBorrow=data.frame(matrix(0,nrow=nBooks,ncol=1))
  rownames(matriceBorrow)<-itemsMini[,1]
  
  
  for( i in 1:nBooks)
  {
    if( matriceNote[Uid,i] > 0 )
    {
      # emprunt
      matriceBorrow[i,1] = 1
    }
  }
  
  matriceBorrow
}


itemToUser<-function(Mid)
{
  # Fonction qui prend en parametre un id movie et qui retourne un vecteur avec les personnes ayant emprunte ce livre
  # exemple d utilisation
  # MAt=itemToUser(86)
  # MAt[6,1]
  
  matriceNote=lienItemRatingsMini()
  
  # Creation d'une matrice vide a remplir
  X = nrow(usersMini)
  matriceBorrow=data.frame(matrix(0,nrow=X,ncol=1))
  rownames(matriceBorrow)<-usersMini[,1]
  
  for( i in 1:X)
  {
    if( matriceNote[i,Mid] > 0 )
    {
      # emprunt
      matriceBorrow[i,1] = 1
    }
  }
  
  matriceBorrow
}


NbPersonnesAyantEmprunteOuvrage=function(Mid)
{
  #Fonction qui prend en parametre un id movie et qui retourne le nombre de personnes l'ayant deja emprunte
  Mat=itemToUser(Mid)
  somme=sum(Mat)
  somme
}


