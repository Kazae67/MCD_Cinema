/* #a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur.

/* #b. Liste des films dont la durée excède 2h15 classés par durée (du plus long au plus court) */
SELECT titre FROM film 
WHERE duree >= 135
ORDER BY duree DESC;

/* #c. Liste des films d’un réalisateur (en précisant l’année de sortie) */ 

