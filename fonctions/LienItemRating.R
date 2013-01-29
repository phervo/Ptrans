lienItemRating=function(){
  #on trie d'abord attention etape obligatoire 
  ratingsOrder=ordonnerRating()
  # Creation d'une matrice vide a remplir
  X = nrow(users)#attention a bien utiliser users car on fait pour chaque utilisateur
  Y = nrow(items)
  Z = nrow(ratingsOrder)
  matriceNote=data.frame(matrix(0,nrow=X,ncol=Y)) #0 represente le fait que le film soit non emprunte
  # Mise en place des noms des lignes et colonnes
  rownames(matriceNote) = users[,1]
  colnames(matriceNote) = items[,1]
  #parcours simple des lignes du  fichier rating
  for( i in 1:Z){
    #on insere a la case 
    matriceNote[ratingsOrder[i,1],ratingsOrder[i,2]]=ratingsOrder[i,3]
  }
  matriceNote
}

ordonnerRating=function(){
  #fonction qui ordonne le data frame rating 
  ratingso <- ratings[order(ratings$Uid,ratings$Mid), ]
  ratingso
}