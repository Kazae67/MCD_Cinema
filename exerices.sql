[A. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur.]
/* https://sql.sh/fonctions/concat [CONCAT]
   https://sql.sh/fonctions/sec_to_time [SEC_TO_TIME]
   https://sql.sh/fonctions/date_format  [DATE_FORMAT (fonctionne également avec DATE_FORMAT)]
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
 * (1) SELECT titre : sélectionner la colonne "titre".
 * (2) FROM film : sélectionner la table "film"
 * (3) WHERE duree >= 135 : Clause WHERE pour filtrer les enregistrements de la table "film" en fonction d'une condition. 
       On sélectionne uniquement les films dont la durée est supérieure ou égale à 135 minutes.
 * (4) ORDER BY duree DESC : Clause ORDER BY est utilisée pour trier les résultats de la requête dans un ordre spécifié. 
       On tri les films en fonction de leur durée, l'option "DESC" indique un tri descendant (ordre décroissant). 
 */
SELECT titre /*(1)*/
FROM film /*(2)*/
WHERE duree >= 135 /*(3)*/
ORDER BY duree DESC; /*(4)*/

[C. Liste des films d’un réalisateur (en précisant l’année de sortie)]
/* https://sql.sh/fonctions/concat [CONCAT]
 * (1) On sélectionne les colonnes suivantes : f.titre, f.date et CONCAT(p.nom, ' ', p.prenom). 
       La fonction CONCAT est utilisée pour concaténer le nom et le prénom de la personne en une seule chaîne de caractères.
 * (2) Nous spécifions la source des données avec la clause FROM, en utilisant la table "film" avec l'alias "f".
 * (3) La clause JOIN pour joindre la table "realisateur" avec l'alias "r" à la table "film". 
       La condition de jointure spécifiée est f.id_realisateur = r.id_realisateur, 
       ce qui signifie que nous associons les films au réalisateur correspondant en comparant les valeurs des colonnes id_realisateur dans les deux tables.
 * (4) La clause JOIN pour joindre la table "personne" avec l'alias "p" à la table "realisateur". 
       La condition de jointure spécifiée est r.id_personne = p.id_personne, 
       ce qui signifie que nous associons les réalisateurs aux personnes correspondantes en comparant les valeurs des colonnes id_personne dans les deux tables.
 * (5) Après avoir joint les tables, nous utilisons la clause WHERE pour spécifier une condition de filtrage. 
       La condition spécifiée est p.nom = 'ROUGE', ce qui signifie que nous sélectionnons uniquement les enregistrements où le nom de la personne est égal à 'ROUGE'.
 */
SELECT f.titre, f.date, CONCAT(p.nom, ' ', p.prenom) /*(1)*/
FROM film AS f /*(2)*/
JOIN realisateur AS r ON f.id_realisateur = r.id_realisateur /*(3)*/
JOIN personne AS p ON r.id_personne = p.id_personne /*(4)*/
WHERE p.nom = 'ROUGE'; /*(5)*/

[D. Nombre de films par genre (classés dans l’ordre décroissant)]
/* https://sql.sh/fonctions/agregation/count [COUNT]
   [REMARQUE : SELECT genre.type AS genre, COUNT(*) AS nombre_defilms FROM genre] = [SELECT g.type AS genre, COUNT(*) AS nombre_defilm FROM genre as g]
 * (1) Cette clause sélectionne deux colonnes dans le résultat final. 
       La première colonne sera appelée "genre" et correspondra au champ "type" de la table "genre". 
       La deuxième colonne sera appelée "nombre_de_films" et contiendra le nombre total de films pour chaque genre.
 * (2) La clause FROM spécifie que la table "genre".
 * (3) Cette clause indique que la table "asso" doit être jointe à la table "genre". 
       Les deux tables sont liées par les colonnes "id_genre" présentes dans les deux tables.
 * (4) Cette clause regroupe les résultats en utilisant la colonne "type" de la table "genre". 
       Cela signifie que les enregistrements seront regroupés selon les différents types de genres.
 * (5) Cette clause trie les résultats par ordre décroissant du nombre total de films (calculé à l'aide de COUNT(*)) pour chaque genre. 
       L'option "DESC" indique un tri descendant (ordre décroissant).
 */
SELECT genre.type AS genre, COUNT(*) AS nombre_de_films /*(1)*/
FROM genre /*(2)*/
JOIN asso ON genre.id_genre = asso.id_genre /*(3)*/
GROUP BY genre.type /*(4)*/
ORDER BY COUNT(*) DESC; /*(5)*/

[E. Nombre de films par réalisateur (classés dans l’ordre décroissant)]
/* https://sql.sh/fonctions/agregation/count [COUNT]
   [REMARQUE : FROM genre g = FROM genre AS g | JOIN asso a = JOIN asso AS a]
 * (1) On sélectionne les colonnes qu'on souhaite récupérer dans la requête : 
       g.type AS genre" pour le nom du genre,
       COUNT(*) AS nombre_de_films" pour le nombre de films associés à chaque genre.
 * (2) On spécifie la table principale de la requête, qui est "genre", en utilisant l'alias "g".
 * (3) La clause "JOIN" pour effectuer une jointure entre les tables "genre" et "asso". 
       La jointure est réalisée en associant les valeurs de la colonne "id_genre" de la table "genre" 
       avec les valeurs correspondantes de la colonne "id_genre" de la table "asso". 
       Cela relie les genres aux films associés dans la table "asso".
 * (4) La clause "GROUP BY" pour regrouper les résultats en fonction de la colonne "g.type" (alias "genre") afin d'obtenir le nombre de films pour chaque genre distinct.
 * (5) La clause "ORDER BY" pour trier les résultats selon la colonne "nombre_de_films".
       L'option "DESC" indique un tri descendant (ordre décroissant)
 */
SELECT g.type AS genre, COUNT(*) AS nombre_de_films /*(1)*/
FROM genre g /*(2)*/
JOIN asso a ON g.id_genre = a.id_genre /*(3)*/
GROUP BY g.type /*(4)*/
ORDER BY nombre_de_films DESC; /*(5)*/

[F. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe]
/*
 * (1)
 * (2)
 * (3)
 * (4)
 * (5)
 */
SELECT p.nom, p.prenom, p.sexe /*(1)*/
FROM personne p /*(2)*/
JOIN acteur a ON p.id_personne = a.id_personne /*(3)*/
JOIN casting c ON a.id_acteur = c.id_acteur /*(4)*/
WHERE c.id_film = 1; /*(5)*/

[G. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de sortie (du film le plus récent au plus ancien)]
/*
 * (1)
 * (2)
 * (3)
 * (4)
 * (5)
 * (6)
 * (7)
 * (8)
 */
SELECT  p.nom AS nom_realisateur, f.titre, r.nom AS role, f.date /*(1)*/
FROM film f /*(2)*/
JOIN casting c ON f.id_film = c.id_film /*(3)*/
JOIN role r ON c.id_role = r.id_role /*(4)*/
JOIN realisateur rt ON f.id_realisateur = rt.id_realisateur /*(5)*/
JOIN personne p ON rt.id_personne = p.id_personne /*(6)*/
WHERE c.id_acteur = 2 /*(7)*/
ORDER BY f.date DESC; /*(8)*/

[H. Liste des personnes qui sont à la fois acteurs et réalisateurs]
/*

*/

[I. Liste des films qui ont moins de 5 ans (classés du plus récent au plus ancien)]
/*
 * (1)
 * (2)
 * (3)
 * (4)
 */
SELECT titre, date /*(1)*/
FROM film /*(2)*/
WHERE date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR) /*(3)*/
ORDER BY date DESC; /*(4)*/

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