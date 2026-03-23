-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 23 mars 2026 à 12:51
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `exercice`
--

INSERT INTO `exercice` (`id_exercice`, `id_track`, `title`, `chemin_url`, `grade_exercice`, `description`, `theme_chapitre`, `instructions`, `xp_reward`, `numero_ordre`, `base_code`, `test_code`) VALUES
(1, 1, 'L\'addition simple', 'addition-simple', 'Débutant', 'Crée une fonction simple pour additionner deux nombres.', 'Les bases', NULL, 100, 1, 'def addition(a, b):\r\n    # Ton code ici\r\n    pass', 'assert addition(2,3)==5'),
(2, 1, 'Pair ou Impair', 'pair-ou-impair', 'Débutant', 'Vérifie si un nombre entier donné est pair ou impair.', 'Conditions', 'Écris une fonction `est_pair(n)` qui prend un nombre entier en paramètre. Elle doit retourner `True` s\'il est pair, et `False` s\'il est impair.', 100, 2, 'def est_pair(n):\n    # Ton code ici\n    pass', 'assert est_pair(4) == True, \"Erreur avec 4\"\nassert est_pair(7) == False, \"Erreur avec 7\"\nassert est_pair(0) == True, \"Erreur avec 0\"\nprint(\"EXERCICE_REUSSI\")'),
(3, 1, 'Compteur de voyelles', 'compteur-voyelles', 'Débutant', 'Compte le nombre de voyelles présentes dans une chaîne de caractères.', 'Chaînes de caractères', 'Écris une fonction `compter_voyelles(texte)` qui retourne le nombre de voyelles (a, e, i, o, u, y) présentes dans un mot en minuscules.', 150, 3, 'def compter_voyelles(texte):\n    # Ton code ici\n    pass', 'assert compter_voyelles(\"hello\") == 2, \"hello contient 2 voyelles\"\nassert compter_voyelles(\"codexia\") == 4, \"codexia contient 4 voyelles\"\nassert compter_voyelles(\"xyz\") == 1, \"y est une voyelle\"\nprint(\"EXERCICE_REUSSI\")'),
(4, 1, 'Le plus grand nombre', 'plus-grand-nombre', 'Intermédiaire', 'Trouve la valeur maximale dans une liste sans utiliser de fonction native.', 'Listes', 'Écris une fonction `trouver_max(liste)` qui prend une liste de nombres et retourne le plus grand élément. Attention : tu n\'as pas le droit d\'utiliser la fonction native `max()` de Python !', 200, 4, 'def trouver_max(liste):\n    # Ton code ici\n    pass', 'assert trouver_max([1, 5, 3, 9, 2]) == 9, \"Le max est 9\"\nassert trouver_max([-5, -2, -10]) == -2, \"Attention aux nombres négatifs\"\nprint(\"EXERCICE_REUSSI\")'),
(5, 1, 'Inverser un mot', 'inverser-mot', 'Intermédiaire', 'Conçois un algorithme pour inverser l\'ordre des lettres d\'un mot.', 'Algorithmique', 'Écris une fonction `inverser(mot)` qui prend une chaîne de caractères et la retourne à l\'envers (ex: \"python\" devient \"nohtyp\").', 250, 5, 'def inverser(mot):\n    # Ton code ici\n    pass', 'assert inverser(\"python\") == \"nohtyp\", \"Erreur avec python\"\nassert inverser(\"codexia\") == \"aixedoc\", \"Erreur avec codexia\"\nprint(\"EXERCICE_REUSSI\")'),
(6, 1, 'Suite de Fibonacci', 'suite-fibonacci', 'Avancé', 'Génère le n-ième terme de la célèbre suite mathématique de Fibonacci.', 'Mathématiques', 'Écris une fonction `fibonacci(n)` qui retourne le n-ième terme de la suite de Fibonacci. Sachant que $F(0)=0$, $F(1)=1$, et $F(n) = F(n-1) + F(n-2)$.', 300, 6, 'def fibonacci(n):\n    # Ton code ici\n    pass', 'assert fibonacci(0) == 0\nassert fibonacci(1) == 1\nassert fibonacci(5) == 5\nassert fibonacci(10) == 55\nprint(\"EXERCICE_REUSSI\")');

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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(17, 2, 2, 'def est_pair(n):\n    # Ton code ici\n    pass', 'failed', 1, 'Traceback (most recent call last):\n  File \"C:\\Users\\User\\AppData\\Local\\Temp\\tmp1c560lmc.py\", line 5, in <module>\n    assert est_pair(4) == True, \"Erreur avec 4\"\n           ^^^^^^^^^^^^^^^^^^^\nAssertionError: Erreur avec 4');

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `track`
--

INSERT INTO `track` (`id_track`, `name`, `chemin_url`, `is_active`) VALUES
(1, 'Python', 'python', 1);

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `username`, `email`, `password_hash`, `bio`, `avatar_url`, `created_at`, `role`, `global_level`, `global_xp`) VALUES
(1, 'AdminTest', 'admin@test.com', 'motdepassebidon', NULL, NULL, '2026-03-11 17:50:40', 'student', 1, 100),
(2, 'Samira_V972', 'samirav@gmail.com', 'scrypt:32768:8:1$ZKenUiu5zOkop3sl$b912cb903e5ce473dada01f763cdf6ea37f76626307e1f9a6435c808e9c0e5588ee7ce15d331dee3acfa6633e2bf8c670ef646158e9407e6fd4f95e434815f84', NULL, 'uploads/avatars/user_2_BEYONCE.jpg', '2026-03-11 18:37:42', 'student', 1, 200),
(3, 'admin', 'admin@admin.com', 'scrypt:32768:8:1$bTbiqx14gPKFUhHP$00376eaa458be019e36af408e9f7fafb9c67441ff90dff96e38da69584352ccfbfaeeba4507e15f2c7a007930b506c46f82af046b1951507865dc0f23a0511e6', NULL, NULL, '2026-03-15 22:56:47', 'admin', 1, 200),
(5, 'Aude', 'Aude@gmail.com', 'scrypt:32768:8:1$NaUZGuowlMGxccbG$dd200a69ad5337ec09736eb46a7890ef4c7c3ee6f4a9614128921d574efde0443c951280dc82f828e5ab8c4a3cd2b295c80fc0b51475a28d8c15bff9637a719b', NULL, NULL, '2026-03-21 22:29:41', 'student', 1, 200);

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
