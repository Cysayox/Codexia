-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : dim. 15 mars 2026 à 22:31
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `exercice`
--

INSERT INTO `exercice` (`id_exercice`, `id_track`, `title`, `chemin_url`, `grade_exercice`, `description`, `theme_chapitre`, `instructions`, `xp_reward`, `numero_ordre`, `base_code`, `test_code`) VALUES
(1, 1, 'L\'addition simple', 'addition-simple', 'Débutant', NULL, 'Les bases', NULL, 100, 1, 'def addition(a, b):\r\n    # Ton code ici\r\n    pass', 'assert addition(2,3)==5');

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
(2, 1, 'termine', '2026-03-11 18:44:55');

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(7, 2, 1, 'def addition(a, b):\n    return a+b', 'success', 1, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id_utilisateur`, `username`, `email`, `password_hash`, `bio`, `avatar_url`, `created_at`, `role`, `global_level`, `global_xp`) VALUES
(1, 'AdminTest', 'admin@test.com', 'motdepassebidon', NULL, NULL, '2026-03-11 17:50:40', 'student', 1, 100),
(2, 'Samira_V972', 'samirav@gmail.com', 'scrypt:32768:8:1$ZKenUiu5zOkop3sl$b912cb903e5ce473dada01f763cdf6ea37f76626307e1f9a6435c808e9c0e5588ee7ce15d331dee3acfa6633e2bf8c670ef646158e9407e6fd4f95e434815f84', NULL, NULL, '2026-03-11 18:37:42', 'student', 1, 100);

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
