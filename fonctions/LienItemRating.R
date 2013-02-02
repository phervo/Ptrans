GetMatriceNotationsOuvrages=function()
{
  #function qui retourne la matrice de notations des ouvrages par les utilisateurs
  #Par Py
  #date de derniere Maj : 02/02/13
  #entrees : rien
  #sortie : Matrice avec en ligne les utilisateur, en colonne les ouvrages et au centre les notes
  #exemple d utilisation : Mat=GetMatriceNotationsOuvrages() 
  #pour voir un resultat Mat[6,86]
  
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
  
  as.matrix(matriceNote)
}


ordonnerRatings=function(){
  #function qui retourne la matrice ratrings triee. Cette fonction sert pour la fonction GetMatriceNotationsOuvrages
  #Par Py
  #date de derniere Maj : 30/01/13
  #entrees : rien
  #sortie : Matrice ratings triee sur deux champs : le premier est l userId le second le MovieId
  #exemple d utilisation : ordonnerRatings()
  ratingso <- ratings[order(ratings$Uid,ratings$Mid), ]
  return(ratingso)
}

GetMatriceColonneEmpruntOuvrage<-function(Uid)
{
  # Fonction qui retourne une matrice colonne
  # Lignes: books
  # Colonne: user passe en parametre
  # Par Benji
  # Date de derniere MaJ: 02/02/2013
  # Entree: UserID
  # Sortie: Vecteur de booleen qui indique si l'utilisateur passe en parametre a emprunte ou non l'ouvrage
  # Exemple d'utilisation: mat = GetMatriceColonneEmpruntOuvrage(6)
  # Pour voir un resultat, taper: mat[86,1]
  
  matriceNote = GetMatriceNotationsOuvrages()
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
  
  as.matrix(matriceBorrow)
}

nbOuvragesEmpruntesParUtilisateurDonne<-function(Uid)
{
  # Fonction qui retourne le nombre de livres empruntes par l'utilisateur passe en parametre
  # Par Benji
  # Date de derniere MaJ: 02/02/2013
  # Entree: UserID
  # Sortie: nombre de livres empruntes par l'utilisateur dont l'ID a ete passe en parametre
  # Exemple d'utilisation: nbOuvragesEmpruntesParUtilisateurDonne(6) 
  
  mat = GetMatriceColonneEmpruntOuvrage(Uid)
  nBorrow = sum(mat)
  
  nBorrow
}

GetMatriceThemesDesOuvrages<-function()
{
  # Fonction qui retourne une matrice
  # Lignes: books
  # Colonnes: genres
  # Par Benji
  # Date de derniere MaJ: 30/01/3
  # Entree: 
  # Sortie: matrice binaire books x genres
  
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
  as.matrix(theme)
}

GetMatriceEmpruntsDesUtilisateursParTheme<-function()
{ 
  # Fonction qui retourne une matrice
  # Lignes: users
  # Colonnes: genres
  # Par Benji
  # Date de derniere MaJ: 30/01/13
  # Entree: 
  # Sortie: matrice binaire users x genres
  
  matBookByGenre = GetMatriceThemesDesOuvrages()
  matUserByBook = GetMatriceNotationsOuvrages()
  
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