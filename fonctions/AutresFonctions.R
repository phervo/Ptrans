NbLivreEmpruntesGenre=function()
{
  #function qui retourne le nombre de livre de chaque genre ayant deja ete empruntes
  #Par Py
  #date de derniere Maj : 30/01/12
  #entrees : rien
  #sortie : vecteur avec le nombre de livre du genre ayant deja ete empruntes
  #exemple d utilisation : NbLivreEmprunterGenre()
  #
  MatriceGenre=bookByGenre()
  num=ncol(MatriceGenre)
  matrice=matrix(0,nrow=num,ncol=1)
  rownames(matrice)=colnames(MatriceGenre)
  for( i in 1:num )
  {
    matrice[i,1]=sum(MatriceGenre[,i])
  }
  matrice
}

#nombreLivreGenre fonction a faire
#ratio fonction a faire

itemToUser<-function(Mid)
{
  #py
  # Fonction qui prend en parametre un id movie et qui retourne un vecteur avec les personnes ayant emprunte ce livre
  # exemple d utilisation
  # MAt=itemToUser(86)
  # MAt[6,1]
  
  matriceNote=lienItemRatings()
  
  # Creation d'une matrice vide a remplir
  X = nrow(users)
  matriceBorrow=data.frame(matrix(0,nrow=X,ncol=1))
  rownames(matriceBorrow)<-users[,1]
  
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
  #py
  #Fonction qui prend en parametre un id movie et qui retourne le nombre de personnes l'ayant deja emprunte
  Mat=itemToUser(Mid)
  somme=sum(Mat)
  somme
}