userByBook=function()
{
  #on trie d'abord attention etape obligatoire 
  ratingsOrder=ordonnerRatings()
  
  # Creation d'une matrice vide a remplir
  X = nrow(users)#attention a bien utiliser users car on fait pour chaque utilisateur
  Y = nrow(items)
  Z = nrow(ratingsOrder)  
  matriceNote = data.frame(matrix(0,nrow=X,ncol=Y)) #0 represente le fait que le film soit non emprunte
  
  # Mise en place des noms des lignes et colonnes
  rownames(matriceNote) = users[,1]
  colnames(matriceNote) = items[,1]
  
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
  ratingso <- ratings[order(ratings$Uid,ratings$Mid), ]
  return(ratingso)
}

userToItem<-function(Uid)
{
  # Fonction qui prend en parametre un user et qui retourne les items empruntes
  # 0: non emprunte
  # 1 : emprunte
  #
  # Exemple d'utilisation:
  # mat = userToItem(6)
  # mat[86,1]
  
  matriceNote = lienItemRatings()
  nBooks = ncol(matriceNote)
  
  # Creation d'une matrice vide a remplir
  matriceBorrow = data.frame(matrix(0,nrow=nBooks,ncol=1))
  rownames(matriceBorrow)<-items[,1]
  
  
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

nbBooksBorrowedByUser<-function(Uid)
{
  # Nombre de livres empruntes par l'utilisateur passe en parametre
  
  mat = userToItem(Uid)
  nBorrow = sum(mat)
  print("Nombre d'ouvrage empruntés: ")
  
  nBorrow
}

bookByGenre<-function()
{
  # Fait apparaitre une matrice binaire
  # Lignes: ouvrages
  # Colonnes: themes
  
  # Creation d'une matrice vide a remplir
  X = nrow(items)
  Y = nrow(genre)
  theme<-data.frame(matrix(NA,ncol=Y,nrow=X))
  
  # Remplissage de la matrice
  for( i in 1:Y )
  {
    # Dans le fichier items, les genres sont repertories de la colonne 5 (4+1) a 23 (4+nbGenres)
    theme[i] = items[4+i]
  }
  
  # Mise en place des noms des lignes et colonnes
  rownames(theme) = items[,1]
  colnames(theme) = genre[,2]
  #colnames(theme) = genre[,1] #si on souhaite les noms
  
  # Apparition de la matrice
  theme
}

userByGenre<-function()
{
  # Fait apparaitre une matrice binaire
  # Lignes: utilisateurs
  # Colonnes: themes
  
  matBookByGenre = as.matrix(bookByGenre())
  matUserByBook = as.matrix(userByBook())
  
  # %*% operateur de multiplication de matrices
  matUserByGenre = matUserByBook %*% matBookByGenre
  
  # "Binarisation" car jusque la, on avait les notes dans la matrice
  nUsers = nrow(matUserByGenre)
  nGenres = ncol(matUserByGenre)
  
  for( i in 1:nUsers )
  {
    for( j in 1:nGenres )
    {
      if( matUserByGenre[i,j] > 0 )
      {
        matUserByGenre[i,j] = 1
      }
    }
  }
  
  matUserByGenre
}