-- 1- Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur
SELECT titre, anneeSortie, SEC_TO_TIME(duree*60),personne.nom
FROM film
INNER JOIN realisateur ON realisateur.Id_realisateur = film.Id_realisateur
INNER JOIN personne ON personne.Id_personne = realisateur.Id_personne

-- 2- Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)
SELECT titre, anneeSortie, SEC_TO_TIME(duree*60),personne.nom
FROM film
INNER JOIN realisateur ON realisateur.Id_realisateur = film.Id_realisateur
INNER JOIN personne ON personne.Id_personne = realisateur.Id_personne
WHERE duree > 120 
ORDER BY duree DESC 

-- 3- Liste des films d’un réalisateur (en précisant l’année de sortie) 
SELECT titre, anneeSortie, SEC_TO_TIME(duree*60),personne.nom
FROM film
INNER JOIN realisateur ON realisateur.Id_realisateur = film.Id_realisateur
INNER JOIN personne ON personne.Id_personne = realisateur.Id_personne
WHERE personne.nom = "Scorsese"

--4- Nombre de films par genre (classés dans l’ordre décroissant)
SELECT genre.nom, COUNT(genre.nom) AS nombre
FROM film
INNER JOIN posseder ON posseder.id_film = film.Id_film
INNER JOIN genre ON genre.Id_genre = posseder.Id_genre
GROUP BY genre.nom
ORDER BY nombre asc

--5- Nombre de films par réalisateur (classés dans l’ordre décroissant)
SELECT  personne.nom,COUNT(titre) AS nombre_film
FROM film
INNER JOIN realisateur ON realisateur.Id_realisateur = film.Id_realisateur
INNER JOIN personne ON personne.Id_personne = realisateur.Id_personne
GROUP BY personne.nom
ORDER BY nombre_film desc

--6- Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe
SELECT film.titre,personne.nom, personne.prenom, personne.sexe
FROM film
INNER JOIN jouer ON jouer.id_film = film.Id_film
INNER JOIN acteur ON acteur.Id_acteur = jouer.Id_acteur
INNER JOIN personne ON personne.id_personne = acteur.id_personne
WHERE film.titre = "Dune"

--7- Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)
SELECT film.titre,personne.nom, personne.prenom, role.nom,film.anneeSortie
FROM film
INNER JOIN jouer ON jouer.id_film = film.Id_film
INNER JOIN role ON role.Id_role = jouer.Id_role
INNER JOIN acteur ON jouer.Id_acteur = acteur.Id_acteur
INNER JOIN personne ON personne.id_personne = acteur.id_personne

WHERE personne.nom = "DiCaprio"

--8- Liste des personnes qui sont à la fois acteurs et réalisateurs
SELECT personne.nom, personne.prenom
FROM acteur
INNER JOIN personne ON personne.id_personne = acteur.Id_personne
INNER JOIN realisateur ON personne.Id_personne = realisateur.Id_personne

--9- Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)
SELECT film.titre, film.anneeSortie
FROM film 
WHERE (YEAR(NOW()) - film.anneeSortie) < 5

--10- Nombre d’hommes et de femmes parmi les acteurs
SELECT personne.sexe,COUNT(acteur.Id_acteur) AS nombre_hommefemme
FROM acteur
INNER JOIN personne ON personne.id_personne = acteur.id_personne 
GROUP BY personne.sexe

--11- Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)
SELECT round(DATEDIFF(NOW(),personne.dateNaissance)/365) AS age, personne.nom
FROM acteur
INNER JOIN personne ON personne.id_personne = acteur.Id_personne
having age >50

--12- Acteurs ayant joué dans 3 films ou plus
SELECT personne.nom,acteur.Id_acteur, count(acteur.Id_acteur) AS nombre
FROM film
INNER JOIN jouer ON jouer.id_film = film.Id_film
INNER JOIN acteur ON acteur.Id_acteur = jouer.Id_acteur
INNER JOIN personne ON personne.id_personne = acteur.id_personne
GROUP BY acteur.Id_acteur
HAVING nombre >= 3