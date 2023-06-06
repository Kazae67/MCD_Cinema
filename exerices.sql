[A. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur.]
/* CONCAT : https://sql.sh/fonctions/concat
   SEC_TO_TIME : https://sql.sh/fonctions/sec_to_time
   TIME_FORMAT : https://sql.sh/fonctions/date_format (fonctionne également avec DATE_FORMAT)
 *(1) f.titre : le titre du film
      f.date : la date de sortie du film
      p.nom : le nom du réalisateur
      p.prenom : le prénom du réalisateur
      CONCAT(TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%H'), ':', TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%i')) AS duree_formattee : 
      la durée du film, convertie en format 'HH:mm' (heures:minutes). 
      La fonction SEC_TO_TIME convertit la durée en secondes en un format de temps.
      TIME_FORMAT formate ce temps en heures et minutes séparées. 
      CONCAT combine les heures et les minutes avec le séparateur ':' et renvoie le résultat sous l'alias duree_formattee.
 *(2) film AS f : la table des films, avec l'alias 'f'.
      realisateur AS r : la table des réalisateurs, avec l'alias 'r'.
      personne AS p : la table des personnes, avec l'alias 'p'.
 *(3) JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur : 
      jointure entre la table des films (f) et la table des réalisateurs (r) en utilisant la colonne 'id_realisateur'.
 *(4) JOIN personne AS p ON r.id_personne = p.id_personne : 
      jointure entre la table des réalisateurs (r) et la table des personnes (p) en utilisant la colonne 'id_personne'.
 *(5) WHERE f.id_film = 2 : retournera les informations sur le film et le réalisateur correspondant à l'identifiant de film 2.
 */
SELECT f.titre, f.date, CONCAT(TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%H'), ':', TIME_FORMAT(SEC_TO_TIME(f.duree * 60), '%i')) AS duree_formattee, p.nom, p.prenom /*(1)*/
FROM film AS f /*(2)*/
JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur /*(3)*/
JOIN personne AS p ON r.id_personne = p.id_personne /*(4)*/
WHERE f.id_film = 2; /*(5)*/

[B. Liste des films dont la durée excède 2h15 classés par durée (du plus long au plus court)]
/*

*/
SELECT titre FROM film 
WHERE duree >= 135
ORDER BY duree DESC;

[C. Liste des films d’un réalisateur (en précisant l’année de sortie)]
/*

*/
SELECT f.titre, f.date, CONCAT(p.nom, ' ', p.prenom)
FROM film AS f
JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur
JOIN personne AS p ON r.id_personne = p.id_personne
WHERE p.nom = 'ROUGE';

[D. Nombre de films par genre (classés dans l’ordre décroissant)]
/*

*/
SELECT g.type AS genre, COUNT(*) AS nombre_de_films
FROM genre g
JOIN asso a ON g.id_genre = a.id_genre
GROUP BY g.type
ORDER BY nombre_de_films DESC;

[E. Nombre de films par réalisateur (classés dans l’ordre décroissant)]
/*

*/
SELECT g.type AS genre, COUNT(*) AS nombre_de_films
FROM genre AS g
JOIN asso a ON g.id_genre = a.id_genre
GROUP BY g.type
ORDER BY nombre_de_films DESC;

[F. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe]
/*

*/
SELECT p.nom, p.prenom, p.sexe
FROM personne p
JOIN acteur a ON p.id_personne = a.id_personne
JOIN casting c ON a.id_acteur = c.id_acteur
WHERE c.id_film = 1;

[G. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)]
/*

*/
SELECT  p.nom AS nom_realisateur, f.titre, r.nom AS role, f.date
FROM film f
JOIN casting c ON f.id_film = c.id_film
JOIN role r ON c.id_role = r.id_role
JOIN realisateur rt ON f.id_realisateur = rt.id_realisateur
JOIN personne p ON rt.id_personne = p.id_personne
WHERE c.id_acteur = 2
ORDER BY f.date DESC;

[H. Liste des personnes qui sont à la fois acteurs et réalisateurs]
/*

*/

[I. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)]
/*

*/
SELECT titre, date
FROM film
WHERE date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
ORDER BY date DESC;

[J. Nombre d’hommes et de femmes parmi les acteurs]
/*

*/
SELECT sexe, COUNT(*) AS nombre_acteur
FROM personne p
JOIN acteur a ON p.id_personne = a.id_personne
GROUP BY sexe;

[K. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)]
/*

*/

[L. Acteurs ayant joué dans 3 films ou plus]
/*

*/