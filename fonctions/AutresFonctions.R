NbLivreEmpruntesParGenre=function()
{
  #fonction qui retourne le nombre de livre de chaque genre ayant deja ete empruntes
  #Par Py
  #date de derniere Maj : 30/01/13
  #entrees : rien
  #sortie : vecteur avec le nombre de livre du genre ayant deja ete empruntes
  #exemple d utilisation : NbLivreEmprunterParGenre()
  #
  MatriceGenre=GetMatUserToBook()
  num=ncol(MatriceGenre)
  matrice=matrix(0,nrow=1,ncol=num)
  colnames(matrice)=colnames(MatriceGenre)
  for( i in 1:num )
  {
    matrice[1,i]=sum(MatriceGenre[,i])
  }
  as.matrix(matrice)
}

NbLivreEmpruntesPourGenreDonne=function(Gid)
{
  #fonction qui retourne le nombre de livre d'un genre particulier ayant deja ete empruntes
  #Par Py
  #date de derniere Maj : 31/01/13
  #entrees : id du genre
  #sortie : vecteur avec le nombre de livre du genre ayant deja ete empruntes
  #exemple d utilisation : NbLivreGenreDonne(1)
  #
  Mat=NbLivreEmpruntesGenre()
  Mat[Gid,1]
}

NbLivreDansBaseParGenre=function()
{
  #fonction qui retourne le nombre de livres de chaque genre renseignes dans la base. Ici on ne tient pas compte
  #du fait qu ils aient ete empruntes ou non.
  #REMARQUE IMPORTANTE : ici on se preocupe des genres simples, c est a dire que si un livre a plusieurs genres,
  #il sera comptabilise dans chacun des genres auquel il appartient,on ne cre pas de genres specifiques pour les
  #groupement.
  #
  #Par Py
  #date de derniere Maj : 02/02/13
  #entrees : rien
  #sortie : vecteur avec le nombre de livre enregistre dans chaque genre
  #exemple d utilisation : NbLivreDansBaseParGenre()
  num=nrow(genre)
  matrice=matrix(0,nrow=1,ncol=num)
  colnames(matrice)=rownames(genre)
  #on recupere les colonnes de items qui correspondent au types
  for(i in 1:num)
  {
    matrice[1,i]=sum(items[,4+i]) #on se place sur la bonne colonne en connaissance de la structure du fichier
  }
  matrice
}


RatioEmpruntsParGenre=function()
{
  #fonction qui retourne le pourcentage de livres empruntes pour chaque genre. Cela permet de savoir quels genres
  # de livres sont les plus rentables a acquerir.
  #Par Py
  #date de derniere Maj : 02/02/13
  #entrees : rien
  #sortie : vecteur avec un pourcentage qui correspond pour chaque genre au nombre de livre emprunte sur le nombre
  #de livre existant
  #exemple d utilisation : NbLivreDansBaseParGenre()
  num=nrow(genre)
  matrice=matrix(0,nrow=1,ncol=num)
  matriceEmpruntGenre=NbLivreEmpruntesGenre()
  nbLivreParGenre=NbLivreBaseParGenre()
  for(i in 1:num)
  {
    matrice[1,i]=(matriceEmpruntGenre[,i]/nbLivreParGenre[,i])*100
  }
  matrice
}

PersonnesAyantEmprunteLivre<-function(Mid)
{
  #fonction qui retourne un vecteur avec les personnes ayant empruntee  un livre precis 
  #Par Py
  #date de derniere Maj : 02/02/13
  #entrees : un id de film
  #sortie : un vecteur de booleen qui indique les personnes ayant emprunte le film passe en parametre
  # exemple d utilisation :  MAt=PersonnesAyantEmprunteLivre(86)
  # pour voir un resultat concret : MAt[6,1]
  
  matriceNote=GetMatriceNotationsOuvrages()
  
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


NbPersonnesAyantEmprunteOuvrageDonne=function(Mid)
{
  #fonction qui retourne le nombre de personnes ayant emprunte un ouvrage precis 
  #Par Py
  #date de derniere Maj : 02/02/13
  #entrees : un id de film
  #sortie : le nombre de personnes ayant emprunte cet ouvrage
  # exemple d utilisation :  NbPersonnesAyantEmprunteOuvrageDonne(86)
  Mat=PersonnesAyantEmprunteLivre(Mid)
  somme=sum(Mat)
  somme
}

ObtenirMatriceCategorieSocioProfFoisUtilisateur=function()
{
  
  #function qui retourne la matrice de notations des ouvrages par les utilisateurs
  #Par Py
  #date de derniere Maj : 14/03/13
  #entrees : rien
  #sortie : 
  #exemple d utilisation : ObtenirMatriceCategorieSocioProfFoisUtilisateur()
  
  # Creation d'une matrice vide a remplir
  X = nrow(users)#attention a bien utiliser users car on fait pour chaque utilisateur
  Y = nrow(jobs)
  matrice = matrix(0,nrow=X,ncol=Y) #0 represente le fait que le film soit non emprunte
  
  # Mise en place des noms des lignes et colonnes
  rownames(matrice) = users[,1]
  colnames(matrice) = jobs[,1]
  for( i in 1:X )
  {
    for( j in 1:Y )
    { 
      if(users[i,4]==jobs[j,1]){
        matrice[i,j]=1
      }
    }
  }
  matrice
}


AttraitsCategorieSocioProfPourGenre=function()
{
  #fonction qui retourne la matrice avec en ligne les groupes socico professionnels et en colonne les genre 
  #Par Py
  #date de derniere Maj : 14/03/13
  #entrees : rien
  #sortie : les notes mises par les utilisateur sur un genre donne
  # exemple d utilisation :  AttraitsCategorieSocioProfPourGenre()
  matUtilFoisMetier=ObtenirMatriceCategorieSocioProfFoisUtilisateur()
  matThemeFoisUtil=t(GetMatriceEmpruntsDesUtilisateursParTheme())
  nbligne=nrow(matThemeFoisUtil)
  nbcolonne=ncol(matUtilFoisMetier)
  matRetour=matrix(0,nrow=nbligne,ncol=nbcolonne)
  
  
  # %*% operateur de multiplication de matrices
  matRetour = matThemeFoisUtil%*% matUtilFoisMetier
  
  matRetour
}