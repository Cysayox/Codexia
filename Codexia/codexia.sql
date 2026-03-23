-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 23 mars 2026 à 22:42
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `codexia`
--

-- --------------------------------------------------------

--
-- Structure de la table `exercice`
--

DROP TABLE IF EXISTS `exercice`;
CREATE TABLE IF NOT EXISTS `exercice` (
  `id_exercice` int NOT NULL AUTO_INCREMENT,
  `id_track` int NOT NULL,
  `title` varchar(200) NOT NULL,
  `chemin_url` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `grade_exercice` varchar(50) NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `theme_chapitre` varchar(100) NOT NULL,
  `instructions` text,
  `xp_reward` int DEFAULT '100',
  `numero_ordre` int NOT NULL DEFAULT '0',
  `base_code` text,
  `test_code` text NOT NULL,
  PRIMARY KEY (`id_exercice`),
  UNIQUE KEY `slug` (`chemin_url`),
  KEY `fk_track_exercice` (`id_track`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `exercice`
--

INSERT INTO `exercice` (`id_exercice`, `id_track`, `title`, `chemin_url`, `grade_exercice`, `description`, `theme_chapitre`, `instructions`, `xp_reward`, `numero_ordre`, `base_code`, `test_code`) VALUES
(1, 1, 'L\'addition simple', 'addition-simple', 'Débutant', 'Crée une fonction simple pour additionner deux nombres.', 'Les bases', NULL, 100, 1, 'def addition(a, b):\r\n    # Ton code ici\r\n    pass', 'assert addition(2,3)==5'),
(2, 1, 'Pair ou Impair', 'pair-ou-impair', 'Débutant', 'Vérifie si un nombre entier donné est pair ou impair.', 'Conditions', 'Écris une fonction `est_pair(n)` qui prend un nombre entier en paramètre. Elle doit retourner `True` s\'il est pair, et `False` s\'il est impair.', 100, 8, 'def est_pair(n):\n    # Ton code ici\n    pass', 'assert est_pair(4) == True, \"Erreur avec 4\"\nassert est_pair(7) == False, \"Erreur avec 7\"\nassert est_pair(0) == True, \"Erreur avec 0\"\nprint(\"EXERCICE_REUSSI\")'),
(3, 1, 'Compteur de voyelles', 'compteur-voyelles', 'Débutant', 'Compte le nombre de voyelles présentes dans une chaîne de caractères.', 'Chaînes de caractères', 'Écris une fonction `compter_voyelles(texte)` qui retourne le nombre de voyelles (a, e, i, o, u, y) présentes dans un mot en minuscules.', 100, 13, 'def compter_voyelles(texte):\n    # Ton code ici\n    pass', 'assert compter_voyelles(\"hello\") == 2, \"hello contient 2 voyelles\"\nassert compter_voyelles(\"codexia\") == 4, \"codexia contient 4 voyelles\"\nassert compter_voyelles(\"xyz\") == 1, \"y est une voyelle\"\nprint(\"EXERCICE_REUSSI\")'),
(4, 1, 'Le plus grand nombre', 'plus-grand-nombre', 'Intermédiaire', 'Trouve la valeur maximale dans une liste sans utiliser de fonction native.', 'Listes', 'Écris une fonction `trouver_max(liste)` qui prend une liste de nombres et retourne le plus grand élément. Attention : tu n\'as pas le droit d\'utiliser la fonction native `max()` de Python !', 100, 16, 'def trouver_max(liste):\n    # Ton code ici\n    pass', 'assert trouver_max([1, 5, 3, 9, 2]) == 9, \"Le max est 9\"\nassert trouver_max([-5, -2, -10]) == -2, \"Attention aux nombres négatifs\"\nprint(\"EXERCICE_REUSSI\")'),
(5, 1, 'Inverser un mot', 'inverser-mot', 'Intermédiaire', 'Conçois un algorithme pour inverser l\'ordre des lettres d\'un mot.', 'Algorithmique', 'Écris une fonction `inverser(mot)` qui prend une chaîne de caractères et la retourne à l\'envers (ex: \"python\" devient \"nohtyp\").', 100, 17, 'def inverser(mot):\n    # Ton code ici\n    pass', 'assert inverser(\"python\") == \"nohtyp\", \"Erreur avec python\"\nassert inverser(\"codexia\") == \"aixedoc\", \"Erreur avec codexia\"\nprint(\"EXERCICE_REUSSI\")'),
(6, 1, 'Suite de Fibonacci', 'suite-fibonacci', 'Avancé', 'Génère le n-ième terme de la célèbre suite mathématique de Fibonacci.', 'Mathématiques', 'Écris une fonction `fibonacci(n)` qui retourne le n-ième terme de la suite de Fibonacci. Sachant que $F(0)=0$, $F(1)=1$, et $F(n) = F(n-1) + F(n-2)$.', 100, 26, 'def fibonacci(n):\n    # Ton code ici\n    pass', 'assert fibonacci(0) == 0\nassert fibonacci(1) == 1\nassert fibonacci(5) == 5\nassert fibonacci(10) == 55\nprint(\"EXERCICE_REUSSI\")'),
(7, 1, 'Calcul de la moyenne', 'calcul-moyenne', 'Débutant', 'Calcule la moyenne d\'une liste de notes.', 'Mathématiques', 'Écris une fonction `calculer_moyenne(notes)` qui prend une liste de nombres en paramètre et retourne leur moyenne. Si la liste est vide, retourne 0.', 100, 12, 'def calculer_moyenne(notes):\n    # Ton code ici\n    pass', 'assert calculer_moyenne([10, 15, 20]) == 15.0, \"La moyenne de 10, 15, 20 est 15.0\"\nassert calculer_moyenne([0, 0, 0]) == 0.0, \"La moyenne de zéros est 0\"\nassert calculer_moyenne([]) == 0, \"Une liste vide doit retourner 0\"\nprint(\"EXERCICE_REUSSI\")'),
(8, 1, 'Filtrer les pairs', 'filtrer-pairs', 'Débutant', 'Extrait uniquement les nombres pairs d\'une liste.', 'Listes', 'Écris une fonction `garder_pairs(liste)` qui prend une liste d\'entiers et retourne une nouvelle liste contenant uniquement les nombres pairs de la liste d\'origine.', 100, 14, 'def garder_pairs(liste):\n    # Ton code ici\n    pass', 'assert garder_pairs([1, 2, 3, 4, 5, 6]) == [2, 4, 6], \"Erreur avec 1,2,3,4,5,6\"\nassert garder_pairs([1, 3, 5]) == [], \"S\'il n\'y a pas de pairs, retourne une liste vide\"\nassert garder_pairs([2, 4, 8]) == [2, 4, 8], \"Si tout est pair, retourne toute la liste\"\nprint(\"EXERCICE_REUSSI\")'),
(9, 1, 'FizzBuzz Classique', 'fizz-buzz', 'Débutant', 'Le test d\'embauche le plus célèbre du monde de la programmation.', 'Conditions', 'Écris une fonction `fizzbuzz(n)` qui retourne :\n- \"Fizz\" si le nombre est divisible par 3.\n- \"Buzz\" si le nombre est divisible par 5.\n- \"FizzBuzz\" si le nombre est divisible par 3 ET 5.\n- Le nombre lui-même (en format chaîne de caractères) dans les autres cas.', 100, 15, 'def fizzbuzz(n):\n    # Ton code ici\n    pass', 'assert fizzbuzz(3) == \"Fizz\", \"Erreur avec 3\"\nassert fizzbuzz(5) == \"Buzz\", \"Erreur avec 5\"\nassert fizzbuzz(15) == \"FizzBuzz\", \"Erreur avec 15\"\nassert fizzbuzz(4) == \"4\", \"Erreur avec 4 (doit être une string)\"\nprint(\"EXERCICE_REUSSI\")'),
(10, 1, 'Compteur de mots', 'compteur-mots', 'Intermédiaire', 'Utilise un dictionnaire pour compter les occurrences de chaque mot.', 'Dictionnaires', 'Écris une fonction `compter_mots(phrase)` qui prend une chaîne de caractères (mots séparés par des espaces) et retourne un dictionnaire où les clés sont les mots et les valeurs sont le nombre de fois où ils apparaissent.', 100, 18, 'def compter_mots(phrase):\n    # Ton code ici\n    pass', 'assert compter_mots(\"le chat le chien\") == {\"le\": 2, \"chat\": 1, \"chien\": 1}, \"Erreur de comptage\"\nassert compter_mots(\"hello hello hello\") == {\"hello\": 3}, \"Erreur avec un mot répété\"\nassert compter_mots(\"\") == {}, \"Une phrase vide retourne un dictionnaire vide\"\nprint(\"EXERCICE_REUSSI\")'),
(11, 1, 'Générateur de mot de passe', 'generateur-mdp', 'Intermédiaire', 'Crée un mot de passe sécurisé à partir d\'un mot simple.', 'Chaînes de caractères', 'Écris une fonction `securiser(mot)` qui remplace certaines lettres pour créer un mot de passe. Remplace les \"a\" par \"@\", les \"e\" par \"3\", les \"i\" par \"1\" et les \"o\" par \"0\" (zéro).', 100, 19, 'def securiser(mot):\n    # Ton code ici\n    pass', 'assert securiser(\"password\") == \"p@ssw0rd\", \"password devient p@ssw0rd\"\nassert securiser(\"securite\") == \"s3cur1t3\", \"securite devient s3cur1t3\"\nprint(\"EXERCICE_REUSSI\")'),
(12, 1, 'Anagrammes', 'detection-anagrammes', 'Intermédiaire', 'Vérifie si deux mots sont constitués des mêmes lettres.', 'Algorithmique', 'Écris une fonction `sont_anagrammes(mot1, mot2)` qui retourne `True` si mot1 et mot2 sont des anagrammes (ils ont exactement les mêmes lettres, peu importe l\'ordre).', 100, 20, 'def sont_anagrammes(mot1, mot2):\n    # Ton code ici\n    pass', 'assert sont_anagrammes(\"chien\", \"niche\") == True, \"chien et niche SONT des anagrammes\"\nassert sont_anagrammes(\"python\", \"typhon\") == True, \"python et typhon SONT des anagrammes\"\nassert sont_anagrammes(\"chat\", \"chien\") == False, \"chat et chien NE SONT PAS des anagrammes\"\nassert sont_anagrammes(\"papa\", \"pape\") == False, \"Vérifie bien la quantité de chaque lettre\"\nprint(\"EXERCICE_REUSSI\")'),
(13, 1, 'Aire d\'un rectangle', 'aire-rectangle', 'Débutant', 'Calcule la surface.', 'Mathématiques', 'Écris une fonction `aire_rectangle(longueur, largeur)` qui retourne l\'aire d\'un rectangle.', 100, 2, 'def aire_rectangle(longueur, largeur):\n    # Ton code ici\n    pass', 'assert aire_rectangle(5, 4) == 20\nassert aire_rectangle(10, 10) == 100\nprint(\"EXERCICE_REUSSI\")'),
(15, 1, 'Calcul du prix TTC', 'prix-ttc', 'Débutant', 'Ajoute la TVA à un prix.', 'Mathématiques', 'Écris une fonction `calculer_ttc(prix_ht)` qui prend un prix Hors Taxe et retourne le prix TTC avec une TVA fixe de 20%.', 100, 3, 'def calculer_ttc(prix_ht):\n    # Ton code ici\n    pass', 'assert calculer_ttc(100) == 120.0\nassert calculer_ttc(50) == 60.0\nprint(\"EXERCICE_REUSSI\")'),
(16, 1, 'Salutation personnalisée', 'salutation', 'Débutant', 'Dis bonjour en utilisant une variable.', 'Chaînes de caractères', 'Écris une fonction `saluer(nom)` qui retourne la phrase \"Bonjour \" suivie du nom. Exemple: si nom est \"Alice\", retourne \"Bonjour Alice\".', 100, 4, 'def saluer(nom):\n    # Ton code ici\n    pass', 'assert saluer(\"Alice\") == \"Bonjour Alice\"\nassert saluer(\"Bob\") == \"Bonjour Bob\"\nprint(\"EXERCICE_REUSSI\")'),
(17, 1, 'Taille du mot', 'taille-mot', 'Débutant', 'Trouve combien de lettres composent un mot.', 'Chaînes de caractères', 'Écris une fonction `longueur_mot(mot)` qui retourne le nombre de caractères d\'une chaîne. Indice : utilise une fonction native de Python.', 100, 5, 'def longueur_mot(mot):\n    # Ton code ici\n    pass', 'assert longueur_mot(\"python\") == 6\nassert longueur_mot(\"a\") == 1\nassert longueur_mot(\"\") == 0\nprint(\"EXERCICE_REUSSI\")'),
(18, 1, 'Crier un mot', 'crier-mot', 'Débutant', 'Transforme un texte en majuscules.', 'Chaînes de caractères', 'Écris une fonction `crier(texte)` qui prend une chaîne de caractères et la retourne entièrement en MAJUSCULES.', 100, 6, 'def crier(texte):\n    # Ton code ici\n    pass', 'assert crier(\"bonjour\") == \"BONJOUR\"\nassert crier(\"Attention\") == \"ATTENTION\"\nprint(\"EXERCICE_REUSSI\")'),
(19, 1, 'Autorisation de sortie', 'autorisation-sortie', 'Débutant', 'Vérifie si une personne est majeure.', 'Conditions', 'Écris une fonction `est_majeur(age)` qui retourne `True` si l\'âge est supérieur ou égal à 18, sinon `False`.', 100, 7, 'def est_majeur(age):\n    # Ton code ici\n    pass', 'assert est_majeur(18) == True\nassert est_majeur(17) == False\nassert est_majeur(42) == True\nprint(\"EXERCICE_REUSSI\")'),
(20, 1, 'Correction automatique', 'remplacer-lettre', 'Débutant', 'Modifie une lettre spécifique dans un texte.', 'Chaînes de caractères', 'Écris une fonction `remplacer_lettre(mot, ancienne, nouvelle)` qui remplace toutes les occurrences de l\'ancienne lettre par la nouvelle dans le mot.', 100, 9, 'def remplacer_lettre(mot, ancienne, nouvelle):\n    # Ton code ici\n    pass', 'assert remplacer_lettre(\"papa\", \"p\", \"t\") == \"tata\"\nassert remplacer_lettre(\"hello\", \"l\", \"r\") == \"herro\"\nprint(\"EXERCICE_REUSSI\")'),
(21, 1, 'Recherche du Zéro', 'recherche-zero', 'Débutant', 'Vérifie si un élément précis est dans une liste.', 'Listes', 'Écris une fonction `contient_zero(liste)` qui retourne `True` si le chiffre 0 est présent dans la liste, sinon `False`.', 100, 10, 'def contient_zero(liste):\n    # Ton code ici\n    pass', 'assert contient_zero([1, 2, 0, 4]) == True\nassert contient_zero([1, 2, 3]) == False\nprint(\"EXERCICE_REUSSI\")'),
(22, 1, 'La somme de tout', 'somme-liste', 'Débutant', 'Additionne tous les éléments d\'un tableau.', 'Listes', 'Écris une fonction `somme_totale(liste)` qui retourne l\'addition de tous les nombres d\'une liste.', 100, 11, 'def somme_totale(liste):\n    # Ton code ici\n    pass', 'assert somme_totale([1, 2, 3]) == 6\nassert somme_totale([10, -5, 5]) == 10\nassert somme_totale([]) == 0\nprint(\"EXERCICE_REUSSI\")'),
(23, 1, 'Sans aucun doublon', 'sans-doublons', 'Intermédiaire', 'Nettoie une liste de ses éléments en double.', 'Listes', 'Écris une fonction `sans_doublons(liste)` qui prend une liste pouvant contenir des doublons et retourne une nouvelle liste avec uniquement les éléments uniques (l\'ordre n\'a pas d\'importance). Indice : renseigne-toi sur les `set` en Python.', 100, 21, 'def sans_doublons(liste):\n    # Ton code ici\n    pass', 'assert sorted(sans_doublons([1, 2, 2, 3, 1, 4])) == [1, 2, 3, 4], \"Erreur avec 1, 2, 2, 3, 1, 4\"\nassert sorted(sans_doublons([\"a\", \"b\", \"a\"])) == [\"a\", \"b\"], \"Erreur avec des chaînes de caractères\"\nassert sans_doublons([]) == [], \"Une liste vide doit renvoyer une liste vide\"\nprint(\"EXERCICE_REUSSI\")'),
(24, 1, 'Le meilleur étudiant', 'meilleur-etudiant', 'Intermédiaire', 'Trouve l\'étudiant avec la meilleure note dans un dictionnaire.', 'Dictionnaires', 'Écris une fonction `meilleur_etudiant(notes)` qui prend un dictionnaire où les clés sont les prénoms et les valeurs sont les notes (sur 20). La fonction doit retourner le prénom de l\'étudiant qui a la note la plus haute.', 100, 22, 'def meilleur_etudiant(notes):\n    # Ton code ici\n    pass', 'assert meilleur_etudiant({\"Alice\": 14, \"Bob\": 19, \"Charlie\": 12}) == \"Bob\", \"Bob a la meilleure note (19)\"\nassert meilleur_etudiant({\"Zoe\": 20, \"Arthur\": 15}) == \"Zoe\", \"Zoe a 20\"\nprint(\"EXERCICE_REUSSI\")'),
(25, 1, 'Les Nombres Premiers', 'nombres-premiers', 'Intermédiaire', 'Vérifie si un nombre ne se divise que par un et par lui-même.', 'Mathématiques', 'Écris une fonction `est_premier(n)` qui retourne `True` si un entier positif `n` est un nombre premier, et `False` sinon. Rappel : 0 et 1 ne sont pas des nombres premiers.', 100, 23, 'def est_premier(n):\n    # Ton code ici\n    pass', 'assert est_premier(7) == True, \"7 est un nombre premier\"\nassert est_premier(10) == False, \"10 n\'est pas premier (divisible par 2 et 5)\"\nassert est_premier(1) == False, \"1 n\'est pas un nombre premier\"\nassert est_premier(13) == True, \"13 est premier\"\nprint(\"EXERCICE_REUSSI\")'),
(26, 1, 'Censure de texte', 'censure-texte', 'Intermédiaire', 'Remplace un mot interdit dans une phrase.', 'Chaînes de caractères', 'Écris une fonction `censurer(phrase, mot_interdit)` qui remplace toutes les apparitions du mot interdit dans la phrase par \"***\".', 100, 24, 'def censurer(phrase, mot_interdit):\n    # Ton code ici\n    pass', 'assert censurer(\"le chat noir\", \"chat\") == \"le *** noir\", \"Erreur basique\"\nassert censurer(\"mot de passe mot\", \"mot\") == \"*** de passe ***\", \"Erreur avec occurrences multiples\"\nprint(\"EXERCICE_REUSSI\")'),
(27, 1, 'Gestion des stocks', 'gestion-stocks', 'Intermédiaire', 'Additionne les quantités de deux inventaires.', 'Dictionnaires', 'Écris une fonction `fusionner_stocks(stock1, stock2)` qui prend deux dictionnaires représentant des stocks de fruits. Retourne un nouveau dictionnaire fusionné. Si un fruit est dans les deux, additionne les quantités.', 100, 25, 'def fusionner_stocks(stock1, stock2):\n    # Ton code ici\n    pass', 'assert fusionner_stocks({\"pomme\": 2}, {\"banane\": 3}) == {\"pomme\": 2, \"banane\": 3}, \"Erreur avec clés différentes\"\nassert fusionner_stocks({\"pomme\": 2}, {\"pomme\": 3, \"banane\": 1}) == {\"pomme\": 5, \"banane\": 1}, \"Erreur de cumul sur la pomme\"\nprint(\"EXERCICE_REUSSI\")'),
(28, 1, 'Filtrage Rapide', 'filtrage-rapide', 'Avancé', 'Utilise la puissance de Python pour filtrer une liste en une seule ligne.', 'Listes Avancées', 'Écris une fonction `mots_longs(liste_mots)` qui prend une liste de chaînes de caractères et retourne une nouvelle liste contenant uniquement les mots de strictement plus de 5 lettres. <strong>Défi :</strong> Essaie de le faire en une seule ligne avec une liste en compréhension !', 100, 27, 'def mots_longs(liste_mots):\n    # Ton code ici\n    pass', 'assert mots_longs([\"chat\", \"éléphant\", \"chien\", \"ordinateur\"]) == [\"éléphant\", \"ordinateur\"], \"Erreur de filtrage\"\nassert mots_longs([\"un\", \"deux\", \"trois\"]) == [], \"Si aucun mot n\'est assez long, retourne une liste vide\"\nprint(\"EXERCICE_REUSSI\")'),
(29, 1, 'Division Sécurisée', 'division-securisee', 'Avancé', 'Protège ton programme contre les crashs.', 'Exceptions', 'Écris une fonction `diviser(a, b)` qui retourne le résultat de `a / b`. Si `b` est égal à 0, Python génère normalement une `ZeroDivisionError`. Utilise un bloc `try... except` pour attraper cette erreur et retourner exactement la chaîne \"Erreur de division\".', 100, 28, 'def diviser(a, b):\n    # Ton code ici\n    pass', 'assert diviser(10, 2) == 5.0, \"10 / 2 doit faire 5.0\"\nassert diviser(5, 0) == \"Erreur de division\", \"Tu dois attraper l\'erreur et renvoyer le texte exact\"\nprint(\"EXERCICE_REUSSI\")'),
(30, 1, 'Créer son propre Tri', 'algorithme-tri', 'Avancé', 'Ordonne une liste sans utiliser les fonctions magiques.', 'Algorithmique', 'Écris une fonction `trier_liste(liste)` qui trie une liste de nombres par ordre croissant. <strong>Interdiction absolue</strong> d\'utiliser `liste.sort()` ou `sorted(liste)`. Tu dois écrire ton propre algorithme (par exemple, le tri à bulles ou le tri par sélection).', 100, 29, 'def trier_liste(liste):\n    # Ton code ici\n    pass', 'assert trier_liste([4, 2, 7, 1, 9]) == [1, 2, 4, 7, 9], \"Erreur sur une liste mélangée\"\nassert trier_liste([5, 5, 2, 8]) == [2, 5, 5, 8], \"Erreur avec des doublons\"\nassert trier_liste([]) == [], \"Erreur avec une liste vide\"\nprint(\"EXERCICE_REUSSI\")'),
(31, 1, 'Inversion d\'Annuaire', 'inversion-annuaire', 'Avancé', 'Échange les clés et les valeurs d\'un dictionnaire.', 'Dictionnaires', 'Écris une fonction `inverser_annuaire(annuaire)` qui prend un dictionnaire au format `{Nom: Numéro}` et retourne un nouveau dictionnaire où les numéros deviennent les clés et les noms deviennent les valeurs.', 100, 30, 'def inverser_annuaire(annuaire):\n    # Ton code ici\n    pass', 'assert inverser_annuaire({\"Alice\": \"123\", \"Bob\": \"456\"}) == {\"123\": \"Alice\", \"456\": \"Bob\"}, \"Erreur d\'inversion\"\nassert inverser_annuaire({}) == {}, \"Un annuaire vide doit rester vide\"\nprint(\"EXERCICE_REUSSI\")'),
(32, 1, 'La Factorielle', 'calcul-factorielle', 'Avancé', 'Calcule la factorielle d\'un nombre (n!).', 'Mathématiques', 'Écris une fonction `factorielle(n)` qui retourne la factorielle d\'un entier positif n. Par exemple, 5! = 5 × 4 × 3 × 2 × 1 = 120. Par convention, la factorielle de 0 est 1.', 100, 31, 'def factorielle(n):\n    # Ton code ici\n    pass', 'assert factorielle(5) == 120, \"La factorielle de 5 est 120\"\nassert factorielle(0) == 1, \"La factorielle de 0 est 1\"\nassert factorielle(3) == 6, \"La factorielle de 3 est 6\"\nprint(\"EXERCICE_REUSSI\")'),
(33, 1, 'Mon premier Objet', 'premier-objet', 'Avancé', 'Découvre les Classes et les Objets.', 'Orienté Objet (POO)', 'Crée une classe `Guerrier`. Cette classe doit avoir une méthode `__init__` qui initialise un attribut `points_de_vie` à 100. Ne crée rien d\'autre, juste la classe de base !', 100, 32, 'class Guerrier:\n    # Ton code ici\n    pass', 'try:\n    g = Guerrier()\n    assert g.points_de_vie == 100, \"Le guerrier doit avoir 100 points_de_vie à la création\"\n    print(\"EXERCICE_REUSSI\")\nexcept NameError:\n    print(\"Erreur: La classe Guerrier n\'est pas définie\")\nexcept AttributeError:\n    print(\"Erreur: L\'attribut points_de_vie est introuvable\")'),
(34, 1, 'Le Compte Bancaire', 'compte-bancaire', 'Avancé', 'Ajoute des actions (méthodes) à ton objet.', 'Orienté Objet (POO)', 'Crée une classe `Compte`. Elle doit avoir un attribut `solde` initialisé à 0. Ajoute ensuite une méthode `deposer(montant)` qui ajoute le montant au solde du compte.', 100, 33, 'class Compte:\n    # Ton code ici\n    pass', 'try:\n    mon_compte = Compte()\n    assert mon_compte.solde == 0, \"Le solde initial doit être 0\"\n    mon_compte.deposer(150)\n    assert mon_compte.solde == 150, \"Le solde devrait être de 150 après un dépôt\"\n    print(\"EXERCICE_REUSSI\")\nexcept Exception as e:\n    print(f\"Erreur dans la définition de la classe : {e}\")'),
(35, 1, 'Aplatir la Matrice', 'aplatir-matrice', 'Avancé', 'Transforme une liste de listes en une seule liste simple.', 'Listes Avancées', 'Écris une fonction `aplatir(matrice)` qui prend une grille 2D (une liste contenant d\'autres listes) et retourne une seule liste 1D contenant tous les éléments à la suite.', 100, 34, 'def aplatir(matrice):\n    # Ton code ici\n    pass', 'assert aplatir([[1, 2], [3, 4]]) == [1, 2, 3, 4], \"Erreur avec une matrice 2x2\"\nassert aplatir([[1], [2, 3, 4], [5]]) == [1, 2, 3, 4, 5], \"Erreur avec des sous-listes de tailles différentes\"\nassert aplatir([]) == [], \"Une matrice vide renvoie une liste vide\"\nprint(\"EXERCICE_REUSSI\")'),
(36, 1, 'Recherche Dichotomique', 'recherche-dichotomique', 'Avancé', 'Trouve un élément très rapidement dans une liste triée.', 'Algorithmique', 'Écris une fonction `recherche_rapide(liste, cible)` qui implémente l\'algorithme de recherche dichotomique (Binary Search). La liste fournie sera **toujours déjà triée**. La fonction retourne `True` si la cible est dedans, `False` sinon. (Interdiction morale d\'utiliser juste `cible in liste`, joue le jeu de l\'algorithme !)', 100, 35, 'def recherche_rapide(liste, cible):\n    # Ton code ici\n    pass', 'assert recherche_rapide([1, 3, 5, 7, 9, 11, 15], 7) == True, \"Le 7 est bien dans la liste\"\nassert recherche_rapide([1, 3, 5, 7, 9], 4) == False, \"Le 4 n\'y est pas\"\nassert recherche_rapide([], 10) == False, \"Erreur sur liste vide\"\nprint(\"EXERCICE_REUSSI\")'),
(37, 1, 'Validateur de syntaxe', 'validateur-parentheses', 'Expert', 'Vérifie que chaque parenthèse ouverte est correctement fermée.', 'Algorithmique', 'Écris une fonction `syntaxe_valide(chaine)` qui prend une chaîne contenant uniquement des parenthèses `()`, des crochets `[]` et des accolades `{}`. Elle doit retourner `True` si la chaîne est valide (chaque ouverture a sa fermeture correspondante dans le bon ordre) et `False` sinon.', 100, 36, 'def syntaxe_valide(chaine):\n    # Ton code ici\n    pass', 'assert syntaxe_valide(\"()\") == True\nassert syntaxe_valide(\"()[]{}\") == True\nassert syntaxe_valide(\"(]\") == False\nassert syntaxe_valide(\"([)]\") == False\nassert syntaxe_valide(\"{[]}\") == True\nprint(\"EXERCICE_REUSSI\")'),
(39, 1, 'L\'Héritage du Mage', 'heritage-mage', 'Expert', 'Fais hériter une classe d\'une autre.', 'Orienté Objet (POO)', 'Le code de base contient une classe `Personnage` avec 100 PV. Crée une classe `Mage` qui **hérite** de `Personnage`. Le `Mage` doit utiliser le constructeur de son parent pour avoir les 100 PV, mais doit aussi ajouter un nouvel attribut `mana` initialisé à 50.', 100, 37, 'class Personnage:\n    def __init__(self):\n        self.pv = 100\n\n# Crée ta classe Mage ici', 'try:\n    merlin = Mage()\n    assert merlin.pv == 100, \"Le mage doit hériter des PV\"\n    assert merlin.mana == 50, \"Le mage doit avoir 50 de mana\"\n    print(\"EXERCICE_REUSSI\")\nexcept Exception as e:\n    print(f\"Erreur : {e}\")'),
(40, 1, 'Le Code de César', 'code-cesar', 'Expert', 'Implémente le plus vieux système de chiffrement du monde.', 'Cryptographie', 'Écris une fonction `cesar(message, decalage)` qui décale chaque lettre de l\'alphabet d\'un certain nombre de crans. Exemple : avec un décalage de 1, \"a\" devient \"b\". <strong>Simplification :</strong> Le message ne contiendra que des lettres minuscules et des espaces (les espaces ne changent pas).', 100, 38, 'def cesar(message, decalage):\n    # Ton code ici\n    pass', 'assert cesar(\"abc\", 1) == \"bcd\", \"Décalage simple\"\nassert cesar(\"xyz\", 1) == \"yza\", \"Attention à la boucle de l\'alphabet (z -> a)\"\nassert cesar(\"le code\", 2) == \"ng eqfg\", \"Les espaces ne doivent pas être modifiés\"\nprint(\"EXERCICE_REUSSI\")'),
(41, 1, 'Chasseur d\'Emails', 'chasseur-emails', 'Expert', 'Extrait des données spécifiques d\'un texte brut.', 'Expressions Régulières', 'Écris une fonction `extraire_emails(texte)` qui utilise le module `re` de Python pour trouver toutes les adresses email valides dans un texte et les retourner sous forme de liste. (Indice : importe le module `re` dans ta fonction).', 100, 39, 'def extraire_emails(texte):\n    # Ton code ici\n    pass', 'assert extraire_emails(\"Contacte-moi à test@email.com ou admin@site.fr\") == [\"test@email.com\", \"admin@site.fr\"]\nassert extraire_emails(\"Pas d\'email ici !\") == []\nprint(\"EXERCICE_REUSSI\")'),
(42, 1, 'Aplatir le JSON', 'aplatir-json', 'Expert', 'Transforme un dictionnaire imbriqué en dictionnaire simple.', 'Algorithmique', 'Écris une fonction `aplatir_dict(d)` qui prend un dictionnaire contenant d\'autres dictionnaires, et qui remonte tout à la racine. Ex: `{\"a\": 1, \"b\": {\"c\": 2}}` devient `{\"a\": 1, \"c\": 2}`. Tu peux supposer que les clés sont uniques même imbriquées.', 100, 40, 'def aplatir_dict(d):\n    # Ton code ici\n    pass', 'assert aplatir_dict({\"a\": 1, \"b\": {\"c\": 2, \"d\": {\"e\": 3}}}) == {\"a\": 1, \"c\": 2, \"e\": 3}\nassert aplatir_dict({\"x\": 42}) == {\"x\": 42}\nprint(\"EXERCICE_REUSSI\")'),
(43, 1, 'La Paire Parfaite', 'paire-parfaite', 'Expert', 'Trouve deux nombres qui donnent une somme précise.', 'Optimisation', 'Écris une fonction `trouver_paire(liste, cible)` qui cherche deux nombres dans la liste dont la somme est égale à la cible. Elle doit retourner une liste ou un tuple avec ces **deux nombres**. S\'il n\'y a pas de solution, retourne `None`.', 100, 41, 'def trouver_paire(liste, cible):\n    # Ton code ici\n    pass', 'res1 = trouver_paire([2, 7, 11, 15], 9)\nassert set(res1) == {2, 7}, \"2 + 7 = 9\"\nres2 = trouver_paire([3, 2, 4], 6)\nassert set(res2) == {2, 4}, \"2 + 4 = 6\"\nassert trouver_paire([1, 2, 3], 10) == None, \"Pas de solution possible\"\nprint(\"EXERCICE_REUSSI\")'),
(44, 1, 'Décodeur Romain', 'decodeur-romain', 'Expert', 'Convertis un chiffre romain en nombre entier.', 'Logique Algorithmique', 'Écris une fonction `romain_vers_entier(s)` qui convertit une chaîne de chiffres romains (I, V, X, L, C, D, M) en entier classique. Souviens-toi que IV vaut 4 et non 6 !', 100, 42, 'def romain_vers_entier(s):\n    # Ton code ici\n    pass', 'assert romain_vers_entier(\"III\") == 3\nassert romain_vers_entier(\"IV\") == 4\nassert romain_vers_entier(\"IX\") == 9\nassert romain_vers_entier(\"LVIII\") == 58\nassert romain_vers_entier(\"MCMXCIV\") == 1994\nprint(\"EXERCICE_REUSSI\")'),
(45, 1, 'Compression RLE', 'compression-rle', 'Maître', 'Compresse une chaîne de caractères selon l\'algorithme Run-Length Encoding.', 'Algorithmique', 'Écris une fonction `compresser_rle(texte)` qui compte les suites de lettres identiques. Par exemple, \"AAAABBBCCDAA\" devient \"4A3B2C1D2A\". Si le texte est vide, retourne une chaîne vide.', 100, 43, 'def compresser_rle(texte):\n    # Ton code ici\n    pass', 'assert compresser_rle(\"AAAABBBCCDAA\") == \"4A3B2C1D2A\", \"Erreur sur AAAABBBCCDAA\"\nassert compresser_rle(\"A\") == \"1A\"\nassert compresser_rle(\"\") == \"\"\nprint(\"EXERCICE_REUSSI\")'),
(48, 1, 'Le Regroupeur d\'Anagrammes', 'grouper-anagrammes', 'Maître', 'Regroupe des mots par similarité de lettres.', 'Dictionnaires Avancés', 'Écris une fonction `grouper_anagrammes(mots)` qui prend une liste de mots et retourne une liste de listes, où chaque sous-liste contient les mots qui sont des anagrammes entre eux. L\'ordre des sous-listes n\'a pas d\'importance.', 100, 44, 'def grouper_anagrammes(mots):\n    # Ton code ici\n    pass', 'res = grouper_anagrammes([\"eat\", \"tea\", \"tan\", \"ate\", \"nat\", \"bat\"])\nassert len(res) == 3, \"Il doit y avoir 3 groupes\"\nassert sorted([\"eat\", \"tea\", \"ate\"]) in [sorted(g) for g in res], \"Le groupe eat/tea/ate est manquant ou incomplet\"\nprint(\"EXERCICE_REUSSI\")'),
(49, 1, 'La Calculatrice Polonaise', 'calculatrice-rpn', 'Maître', 'Évalue une expression mathématique complexe.', 'Structures de Données', 'Écris une fonction `evaluer_rpn(expression)` qui prend une liste de chaînes représentant une expression en Notation Polonaise Inverse (RPN) et retourne le résultat entier. Les opérateurs valides sont `+`, `-`, `*` et `/` (division entière). Exemple: `[\"2\", \"1\", \"+\", \"3\", \"*\"]` = ((2 + 1) * 3) = 9.', 100, 45, 'def evaluer_rpn(expression):\n    # Ton code ici\n    pass', 'assert evaluer_rpn([\"2\", \"1\", \"+\", \"3\", \"*\"]) == 9, \"((2 + 1) * 3) doit faire 9\"\nassert evaluer_rpn([\"4\", \"13\", \"5\", \"/\", \"+\"]) == 6, \"(4 + (13 / 5)) doit faire 6\"\nprint(\"EXERCICE_REUSSI\")'),
(50, 1, 'Le Panier E-commerce', 'panier-ecommerce', 'Maître', 'Conçois le système de gestion d\'un panier d\'achat.', 'Orienté Objet (POO)', 'Crée une classe `Panier`. Elle doit avoir : \n1. Un attribut `articles` (dictionnaire).\n2. Une méthode `ajouter(nom, prix, quantite)`.\n3. Une méthode `total()` qui retourne le prix total du panier en tenant compte des quantités.', 100, 46, 'class Panier:\n    # Ton code ici\n    pass', 'try:\n    p = Panier()\n    p.ajouter(\"Pomme\", 2.0, 3)\n    p.ajouter(\"Livre\", 15.0, 1)\n    assert p.total() == 21.0, \"Le total doit être de 21.0 (3*2 + 1*15)\"\n    print(\"EXERCICE_REUSSI\")\nexcept Exception as e:\n    print(f\"Erreur d\'implémentation: {e}\")'),
(51, 1, 'L\'Agent de Sécurité', 'validateur-mdp-pro', 'Maître', 'Vérifie la robustesse absolue d\'un mot de passe.', 'Expressions Régulières', 'Écris une fonction `mdp_robuste(mdp)` qui retourne `True` si le mot de passe respecte TOUTES ces règles : \n- Au moins 8 caractères\n- Au moins une majuscule\n- Au moins une minuscule\n- Au moins un chiffre\n- Au moins un caractère spécial parmi `!@#$%^&*`', 100, 47, 'import re\n\ndef mdp_robuste(mdp):\n    # Ton code ici\n    pass', 'assert mdp_robuste(\"Password123!\") == True\nassert mdp_robuste(\"pass123!\") == False, \"Manque une majuscule\"\nassert mdp_robuste(\"PASSWORD123!\") == False, \"Manque une minuscule\"\nassert mdp_robuste(\"Password!\") == False, \"Manque un chiffre\"\nprint(\"EXERCICE_REUSSI\")'),
(52, 1, 'Le Rendu de Monnaie', 'rendu-monnaie', 'Maître', 'Optimise le rendu de monnaie comme un distributeur automatique.', 'Optimisation', 'Écris une fonction `rendre_monnaie(montant)` qui retourne une liste des pièces à rendre pour atteindre ce montant avec le MOINS de pièces possible. Les pièces disponibles sont : 50, 20, 10, 5, 2, 1. (Ex: 68 retourne `[50, 10, 5, 2, 1]`).', 100, 48, 'def rendre_monnaie(montant):\n    # Ton code ici\n    pass', 'assert rendre_monnaie(68) == [50, 10, 5, 2, 1], \"Erreur pour 68\"\nassert rendre_monnaie(100) == [50, 50], \"Erreur pour 100\"\nassert rendre_monnaie(0) == [], \"Erreur pour 0\"\nprint(\"EXERCICE_REUSSI\")'),
(53, 1, 'L\'Inspecteur Sudoku', 'validateur-sudoku', 'Maître', 'Analyse une grille pour vérifier si elle respecte les règles.', 'Algorithmique Avancée', 'Écris une fonction `sudoku_valide(grille)` qui prend une grille 9x9 (liste de listes). Elle doit retourner `True` s\'il n\'y a aucun doublon sur les lignes et les colonnes. (Pour simplifier, on ignorera la vérification des carrés 3x3). Les cases vides sont représentées par des `0`.', 100, 49, 'def sudoku_valide(grille):\n    # Ton code ici\n    pass', 'grille_ok = [[1,2,3,4,5,6,7,8,9], [9,1,2,3,4,5,6,7,8]] + [[0]*9]*7\ngrille_fausse = [[1,2,3,4,5,6,7,8,1]] + [[0]*9]*8\nassert sudoku_valide(grille_ok) == True, \"Cette grille partielle est valide\"\nassert sudoku_valide(grille_fausse) == False, \"Il y a deux 1 sur la première ligne\"\nprint(\"EXERCICE_REUSSI\")'),
(54, 1, 'Le Jeu de la Vie', 'jeu-de-la-vie', 'Maître', 'L\'épreuve ultime : simule un automate cellulaire.', 'Simulation', 'Le Jeu de la Vie de Conway sur une grille (0=mort, 1=vivant). Écris une fonction `generation_suivante(grille)` qui retourne la grille à l\'étape d\'après. Règles pour une cellule : \n1. Vivante avec 2 ou 3 voisines -> Reste vivante.\n2. Morte avec exactement 3 voisines -> Devient vivante.\n3. Dans tous les autres cas -> Meurt (ou reste morte).', 100, 50, 'def generation_suivante(grille):\n    # Ton code ici\n    pass', 'grille_depart = [[0,1,0], [0,1,0], [0,1,0]]\ngrille_fin = [[0,0,0], [1,1,1], [0,0,0]]\nassert generation_suivante(grille_depart) == grille_fin, \"Un clignotant vertical devient horizontal\"\nprint(\"EXERCICE_REUSSI\")'),
(55, 2, 'L\'addition simple', 'js-addition', 'Débutant', 'Les bases de JS.', 'Les Variables', 'Écris une fonction `addition(a, b)` qui retourne la somme de a et b.', 100, 1, 'function addition(a, b) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(addition(2, 3), 5, \"Erreur : 2+3 doit faire 5\");\nconsole.log(\"EXERCICE_REUSSI\");'),
(56, 2, 'Pair ou Impair', 'js-pair-impair', 'Débutant', 'Utilisation du modulo.', 'Conditions', 'Écris une fonction `estPair(n)` qui retourne `true` si le nombre est pair, et `false` sinon.', 100, 2, 'function estPair(n) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(estPair(4), true, \"4 est pair\");\nassert.strictEqual(estPair(7), false, \"7 est impair\");\nconsole.log(\"EXERCICE_REUSSI\");'),
(57, 2, 'Salutation JS', 'js-salutation', 'Débutant', 'Concaténation (ou Template Literals).', 'Chaînes de caractères', 'Écris une fonction `saluer(nom)` qui retourne \"Bonjour \" suivi du nom. Essaie d\'utiliser les backticks (``) !', 100, 3, 'function saluer(nom) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(saluer(\"Alice\"), \"Bonjour Alice\", \"Erreur avec Alice\");\nconsole.log(\"EXERCICE_REUSSI\");'),
(58, 2, 'Calcul TTC', 'js-calcul-ttc', 'Débutant', 'Multiplication simple.', 'Mathématiques', 'Écris une fonction `calculerTTC(prixHT)` qui ajoute 20% de TVA au prix donné.', 100, 4, 'function calculerTTC(prixHT) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(calculerTTC(100), 120);\nassert.strictEqual(calculerTTC(50), 60);\nconsole.log(\"EXERCICE_REUSSI\");'),
(59, 2, 'Longueur du mot', 'js-longueur-mot', 'Débutant', 'Propriété native JS.', 'Chaînes de caractères', 'Écris une fonction `tailleDuMot(mot)` qui retourne le nombre de lettres. Indice : utilise la propriété `.length`.', 100, 5, 'function tailleDuMot(mot) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(tailleDuMot(\"javascript\"), 10);\nassert.strictEqual(tailleDuMot(\"\"), 0);\nconsole.log(\"EXERCICE_REUSSI\");'),
(60, 2, 'Crier un mot', 'js-crier', 'Débutant', 'Méthode de string.', 'Chaînes de caractères', 'Écris une fonction `crier(texte)` qui retourne le texte en MAJUSCULES.', 100, 6, 'function crier(texte) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(crier(\"hello\"), \"HELLO\");\nconsole.log(\"EXERCICE_REUSSI\");'),
(61, 2, 'Premier élément', 'js-premier-element', 'Débutant', 'Accès à un Array.', 'Tableaux (Arrays)', 'Écris une fonction `premier(tableau)` qui retourne le tout premier élément de la liste. Si le tableau est vide, retourne `null`.', 100, 7, 'function premier(tableau) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(premier([10, 20, 30]), 10);\nassert.strictEqual(premier([]), null);\nconsole.log(\"EXERCICE_REUSSI\");'),
(62, 2, 'La somme du tableau', 'js-somme-tableau', 'Débutant', 'Boucle for classique.', 'Tableaux (Arrays)', 'Écris une fonction `somme(tableau)` qui additionne tous les nombres du tableau.', 150, 8, 'function somme(tableau) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(somme([1, 2, 3]), 6);\nassert.strictEqual(somme([]), 0);\nconsole.log(\"EXERCICE_REUSSI\");'),
(63, 2, 'FizzBuzz JS', 'js-fizzbuzz', 'Débutant', 'Conditions imbriquées.', 'Conditions', 'Écris la fonction `fizzBuzz(n)` en JavaScript (divisible par 3 = Fizz, par 5 = Buzz, les deux = FizzBuzz, sinon le nombre en texte).', 150, 9, 'function fizzBuzz(n) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nassert.strictEqual(fizzBuzz(3), \"Fizz\");\nassert.strictEqual(fizzBuzz(5), \"Buzz\");\nassert.strictEqual(fizzBuzz(15), \"FizzBuzz\");\nassert.strictEqual(fizzBuzz(4), \"4\");\nconsole.log(\"EXERCICE_REUSSI\");'),
(64, 2, 'Créer un objet', 'js-creer-objet', 'Débutant', 'Syntaxe JSON / Objet littéral.', 'Objets', 'Écris une fonction `creerProfil(nom, age)` qui retourne un objet avec deux propriétés : `nom` et `age`.', 150, 10, 'function creerProfil(nom, age) {\n    // Ton code ici\n}', 'const assert = require(\"assert\");\nconst obj = creerProfil(\"Alice\", 25);\nassert.strictEqual(obj.nom, \"Alice\");\nassert.strictEqual(obj.age, 25);\nconsole.log(\"EXERCICE_REUSSI\");');

-- --------------------------------------------------------

--
-- Structure de la table `progresser`
--

DROP TABLE IF EXISTS `progresser`;
CREATE TABLE IF NOT EXISTS `progresser` (
  `id_utilisateur` int NOT NULL,
  `id_exercice` int NOT NULL,
  `status_progression` enum('en_cours','termine') DEFAULT 'en_cours',
  `completed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`,`id_exercice`),
  KEY `fk_exercice_progression` (`id_exercice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `progresser`
--

INSERT INTO `progresser` (`id_utilisateur`, `id_exercice`, `status_progression`, `completed_at`) VALUES
(1, 1, 'termine', '2026-03-11 17:53:06'),
(2, 1, 'termine', '2026-03-11 18:44:55'),
(2, 2, 'termine', '2026-03-21 18:51:17'),
(2, 3, 'termine', '2026-03-23 12:58:15'),
(2, 55, 'termine', '2026-03-23 20:29:44'),
(3, 1, 'termine', '2026-03-15 23:01:00'),
(3, 2, 'termine', '2026-03-21 18:00:41'),
(5, 1, 'termine', '2026-03-21 22:30:32'),
(5, 2, 'termine', '2026-03-21 22:34:17');

-- --------------------------------------------------------

--
-- Structure de la table `soumission`
--

DROP TABLE IF EXISTS `soumission`;
CREATE TABLE IF NOT EXISTS `soumission` (
  `id_soumission` int NOT NULL AUTO_INCREMENT,
  `id_utilisateur` int NOT NULL,
  `id_exercice` int NOT NULL,
  `code` text NOT NULL,
  `status_soumission` enum('pending','success','failed') DEFAULT 'pending',
  `version` int DEFAULT '1',
  `test_output` text,
  PRIMARY KEY (`id_soumission`),
  KEY `fk_utilisateur_soumission` (`id_utilisateur`),
  KEY `fk_exercice_soumission` (`id_exercice`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `soumission`
--

INSERT INTO `soumission` (`id_soumission`, `id_utilisateur`, `id_exercice`, `code`, `status_soumission`, `version`, `test_output`) VALUES
(1, 1, 1, 'def addition(a,b):\n    return a+b', 'success', 1, ''),
(2, 1, 1, 'def addition():\n    return a+b', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmpqtd5x06q.py\", line 4, in <module>\n    assert addition(2,3)==5\n           ^^^^^^^^^^^^^\nTypeError: addition() takes 0 positional arguments but 2 were given'),
(3, 1, 1, 'def addition(a,b):\n    return a+b', 'success', 1, ''),
(4, 1, 1, 'def ma_fonction(a,b):\n    # Ton code ici\n    return a+b', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmpi0rcvbog.py\", line 5, in <module>\n    assert addition(2,3)==5\n           ^^^^^^^^\nNameError: name \'addition\' is not defined'),
(5, 1, 1, 'def addition(a,b):\n    # Ton code ici\n    return a+b', 'success', 1, ''),
(6, 1, 1, 'def addition(a, b):\n    # Ton code ici\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmp7rnizfxt.py\", line 5, in <module>\n    assert addition(2,3)==5\n           ^^^^^^^^^^^^^^^^\nAssertionError'),
(7, 2, 1, 'def addition(a, b):\n    return a+b', 'success', 1, ''),
(8, 3, 1, 'def addition(a, b):\n    return a+b\n    pass', 'success', 1, ''),
(9, 3, 1, 'def addition(a, b):\n    return a+a+b\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmp2pikh1xb.py\", line 5, in <module>\n    assert addition(2,3)==5\n           ^^^^^^^^^^^^^^^^\nAssertionError'),
(10, 3, 2, 'def est_pair(n):\n    if n % 2 == 0:\n        return True\n    return False\n    pass', 'success', 1, 'EXERCICE_REUSSI'),
(11, 2, 2, 'def est_pair(n):\n    if n %2==0:\n        return True\n    return False\n    pass', 'success', 1, 'EXERCICE_REUSSI'),
(12, 5, 1, 'def addition(a, b):\n    return a + b\n    pass', 'success', 1, ''),
(13, 5, 2, 'def est_pair(n):\n    if n%2==0:\n        return True\n    return True\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmpxan2y240.py\", line 8, in <module>\n    assert est_pair(7) == False, \"Erreur avec 7\"\n           ^^^^^^^^^^^^^^^^^^^^\nAssertionError: Erreur avec 7'),
(14, 5, 2, 'def est_pair(n):\n    if n%2==0:\n        return True\n    print(False)\n\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmpsxckqa4y.py\", line 9, in <module>\n    assert est_pair(7) == False, \"Erreur avec 7\"\n           ^^^^^^^^^^^^^^^^^^^^\nAssertionError: Erreur avec 7'),
(15, 5, 2, 'def est_pair(n):\n    if n%2==0:\n        return True\n    print(\"False\")\n\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmp43bdisdz.py\", line 9, in <module>\n    assert est_pair(7) == False, \"Erreur avec 7\"\n           ^^^^^^^^^^^^^^^^^^^^\nAssertionError: Erreur avec 7'),
(16, 5, 2, 'def est_pair(n):\n    if n%2==0:\n        return True\n    return False\n\n    pass', 'success', 1, 'EXERCICE_REUSSI'),
(17, 2, 2, 'def est_pair(n):\n    # Ton code ici\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmp1c560lmc.py\", line 5, in <module>\n    assert est_pair(4) == True, \"Erreur avec 4\"\n           ^^^^^^^^^^^^^^^^^^^\nAssertionError: Erreur avec 4'),
(18, 2, 3, 'def compter_voyelles(texte):\n    # Ton code ici\n    a=0\n    for i in texte :\n        if i in \"aeiouy\":\n            a+=1\n    return a\n', 'success', 1, 'EXERCICE_REUSSI'),
(19, 6, 37, 'def syntaxe_valide(chaine):\n    # Ton code ici\n    chaine = \'\'\n    return True', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmpx4riptbi.py\", line 8, in <module>\n    assert syntaxe_valide(\"(]\") == False\n           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\nAssertionError'),
(20, 2, 55, 'function addition(a, b) {\n    // Ton code ici\n        return a + b;\n}', 'failed', 1, 'File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmpbwmjn0xt.py\", line 1\n    function addition(a, b) {\n             ^^^^^^^^\nSyntaxError: invalid syntax'),
(21, 2, 55, 'function addition(a, b) {\n    return a + b;\n}', 'failed', 1, 'File \"C:\\Users\\ELVE~1\\AppData\\Local\\Temp\\tmp3monbpo5.py\", line 1\n    function addition(a, b) {\n             ^^^^^^^^\nSyntaxError: invalid syntax'),
(22, 2, 55, 'function addition(a, b) {\n    return a+b\n}', 'success', 1, 'EXERCICE_REUSSI');

-- --------------------------------------------------------

--
-- Structure de la table `suivre`
--

DROP TABLE IF EXISTS `suivre`;
CREATE TABLE IF NOT EXISTS `suivre` (
  `id_utilisateur` int NOT NULL,
  `id_track` int NOT NULL,
  `grade_actuel` varchar(50) DEFAULT 'Débutant',
  `track_xp` int DEFAULT '0',
  PRIMARY KEY (`id_utilisateur`,`id_track`),
  KEY `fk_track_suivre` (`id_track`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `track`
--

DROP TABLE IF EXISTS `track`;
CREATE TABLE IF NOT EXISTS `track` (
  `id_track` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `chemin_url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id_track`),
  UNIQUE KEY `slug` (`chemin_url`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `track`
--

INSERT INTO `track` (`id_track`, `name`, `chemin_url`, `is_active`) VALUES
(1, 'Python', 'python', 1),
(2, 'JavaScript', 'javascript', 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE IF NOT EXISTS `utilisateur` (
  `id_utilisateur` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `bio` text,
  `avatar_url` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `role` varchar(50) DEFAULT 'student',
  `global_level` int DEFAULT '1',
  `global_xp` int DEFAULT '0',
  PRIMARY KEY (`id_utilisateur`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `username`, `email`, `password_hash`, `bio`, `avatar_url`, `created_at`, `role`, `global_level`, `global_xp`) VALUES
(1, 'AdminTest', 'admin@test.com', 'motdepassebidon', NULL, NULL, '2026-03-11 17:50:40', 'student', 1, 100),
(2, 'Samira_V972', 'samirav@gmail.com', 'scrypt:32768:8:1$ZKenUiu5zOkop3sl$b912cb903e5ce473dada01f763cdf6ea37f76626307e1f9a6435c808e9c0e5588ee7ce15d331dee3acfa6633e2bf8c670ef646158e9407e6fd4f95e434815f84', NULL, 'uploads/avatars/user_2_BEYONCE.jpg', '2026-03-11 18:37:42', 'student', 1, 450),
(3, 'admin', 'admin@admin.com', 'scrypt:32768:8:1$bTbiqx14gPKFUhHP$00376eaa458be019e36af408e9f7fafb9c67441ff90dff96e38da69584352ccfbfaeeba4507e15f2c7a007930b506c46f82af046b1951507865dc0f23a0511e6', NULL, NULL, '2026-03-15 22:56:47', 'admin', 1, 200),
(5, 'Aude', 'Aude@gmail.com', 'scrypt:32768:8:1$NaUZGuowlMGxccbG$dd200a69ad5337ec09736eb46a7890ef4c7c3ee6f4a9614128921d574efde0443c951280dc82f828e5ab8c4a3cd2b295c80fc0b51475a28d8c15bff9637a719b', NULL, NULL, '2026-03-21 22:29:41', 'student', 1, 200),
(6, 'RobotMan', 'robot-man@gmail.com', 'scrypt:32768:8:1$QuU1bZUh8qP85vtK$6427c2b7d81c0d5585dde7c6a515a96c0c77f09539f81df83c7ecf89fba1a56d9a4782677290e645514524c50317f5d06ad468f1d7149a4bef302dc76c6a3e29', NULL, NULL, '2026-03-23 16:30:54', 'student', 1, 2900);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `exercice`
--
ALTER TABLE `exercice`
  ADD CONSTRAINT `fk_track_exercice` FOREIGN KEY (`id_track`) REFERENCES `track` (`id_track`) ON DELETE CASCADE;

--
-- Contraintes pour la table `progresser`
--
ALTER TABLE `progresser`
  ADD CONSTRAINT `fk_exercice_progression` FOREIGN KEY (`id_exercice`) REFERENCES `exercice` (`id_exercice`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_utilisateur_progression` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `soumission`
--
ALTER TABLE `soumission`
  ADD CONSTRAINT `fk_exercice_soumission` FOREIGN KEY (`id_exercice`) REFERENCES `exercice` (`id_exercice`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_utilisateur_soumission` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;

--
-- Contraintes pour la table `suivre`
--
ALTER TABLE `suivre`
  ADD CONSTRAINT `fk_track_suivre` FOREIGN KEY (`id_track`) REFERENCES `track` (`id_track`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_utilisateur_suivre` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id_utilisateur`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
