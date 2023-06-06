/* #a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur. */
SELECT f.titre, f.date, CONCAT(TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%H'), ':', TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%i')) AS duree_formattee, p.nom, p.prenom
FROM film AS f
JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur
JOIN personne AS p ON r.id_personne = p.id_personne
WHERE f.id_film = 2;

/* #b. Liste des films dont la durée excède 2h15 classés par durée (du plus long au plus court) */
SELECT titre FROM film 
WHERE duree >= 135
ORDER BY duree DESC;

/* #c. Liste des films d’un réalisateur (en précisant l’année de sortie) */ 
SELECT f.titre, f.date, CONCAT(p.nom, ' ', p.prenom)
FROM film AS f
JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur
JOIN personne AS p ON r.id_personne = p.id_personne
WHERE p.nom = 'ROUGE';

/* d. Nombre de films par genre (classés dans l’ordre décroissant) */
SELECT g.type AS genre, COUNT(*) AS nombre_de_films
FROM genre g
JOIN asso a ON g.id_genre = a.id_genre
GROUP BY g.type
ORDER BY nombre_de_films DESC;

/* e. Nombre de films par réalisateur (classés dans l’ordre décroissant) */
SELECT g.type AS genre, COUNT(*) AS nombre_de_films
FROM genre AS g
JOIN asso a ON g.id_genre = a.id_genre
GROUP BY g.type
ORDER BY nombre_de_films DESC;

/* f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe */
SELECT p.nom, p.prenom, p.sexe
FROM personne p
JOIN acteur a ON p.id_personne = a.id_personne
JOIN casting c ON a.id_acteur = c.id_acteur
WHERE c.id_film = 1;

/* g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien) */
SELECT f.titre, r.nom AS role, f.date
FROM film f
JOIN casting c ON f.id_film = c.id_film
JOIN role r ON c.id_role = r.id_role
WHERE c.id_acteur = 2
ORDER BY f.date DESC;

/* h. Liste des personnes qui sont à la fois acteurs et réalisateurs */

/* i. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien) */

/* j. Nombre d’hommes et de femmes parmi les acteurs */

/* k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu) */

/* l. Acteurs ayant joué dans 3 films ou plus */