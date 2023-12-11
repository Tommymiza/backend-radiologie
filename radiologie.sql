-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : lun. 11 déc. 2023 à 16:42
-- Version du serveur : 8.0.31
-- Version de PHP : 8.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `radiologie`
--

-- --------------------------------------------------------

--
-- Structure de la table `codes`
--

DROP TABLE IF EXISTS `codes`;
CREATE TABLE IF NOT EXISTS `codes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` int NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 ;

--
-- Déchargement des données de la table `codes`
--

INSERT INTO `codes` (`id`, `code`, `email`) VALUES
(17, 935701, 'tommymiza6@gmail.com'),
(19, 393520, 'tommymiza6@gmail.com'),
(20, 357416, 'tommymiza6@gmail.com'),
(21, 103620, 'tommymiza20@gmail.com'),
(22, 953757, 'tommymiza20@gmail.com'),
(23, 993142, 'tommymiza20@gmail.com'),
(24, 350367, ''),
(25, 309817, ''),
(26, 719124, 'tommymiza6@gmail.com'),
(27, 870267, 'tommymiza6@gmail.com'),
(28, 651846, 'tommymiza6@gmail.com'),
(29, 476392, 'tommymiza6@gmail.com'),
(30, 304579, 'tommymiza6@gmail.com'),
(31, 784064, 'tommymiza6@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `demandes`
--

DROP TABLE IF EXISTS `demandes`;
CREATE TABLE IF NOT EXISTS `demandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_patient` varchar(100) NOT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL,
  `datenais` date NOT NULL,
  `tel` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rdv` date DEFAULT NULL,
  `id_type` int NOT NULL,
  `id_medecin` int DEFAULT NULL,
  `lieu` varchar(255) NOT NULL,
  `date_rdv` date DEFAULT NULL,
  `ordonnance` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type` (`id_type`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 ;

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_envoyeur` int NOT NULL,
  `id_receveur` int NOT NULL,
  `message` text NOT NULL,
  `lu` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` varchar(100) NOT NULL,
  `ajout` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_envoyeur` (`id_envoyeur`),
  KEY `id_receveur` (`id_receveur`)
) ENGINE=InnoDB AUTO_INCREMENT=138 DEFAULT CHARSET=utf8mb4 ;

-- --------------------------------------------------------

--
-- Structure de la table `tokens`
--

DROP TABLE IF EXISTS `tokens`;
CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_user` int NOT NULL,
  `token` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 ;

--
-- Déchargement des données de la table `tokens`
--

INSERT INTO `tokens` (`id`, `id_user`, `token`, `created_at`) VALUES
(48, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDcyODE2MjcxNiwiaWF0IjoxNzAwNzI4MTYyfQ.Cc3h92pEKERQXs9byCBCgQH2eLkPnDXz8JHqpoKVnnE', '2023-11-23 08:29:22'),
(49, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczMDA5MTc2OCwiaWF0IjoxNzAwNzMwMDkxfQ.qFe6GWK-sN1QoYel373qa3Doo67si4pyTE8fT0jH4lM', '2023-11-23 09:01:31'),
(50, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczMDQ5MDY1NiwiaWF0IjoxNzAwNzMwNDkwfQ.nEKWkNBOfAXdrtRw4hDDMjQ1-77KLovSSnwKmazcdmQ', '2023-11-23 09:08:10'),
(51, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczNjY1MjMxNSwiaWF0IjoxNzAwNzM2NjUyfQ.aZBz1t9GCVf_MBXjFgdPby1AsuHRgmKyWIHpUoWc-oQ', '2023-11-23 10:50:52'),
(53, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDgyMzAxMzY4NywiaWF0IjoxNzAwODIzMDEzfQ.3EtIOiO9rA_rnu03ZIj4AnOwQ_w7XK8hIeesGCRDKN8', '2023-11-24 10:50:13'),
(55, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDg0MjcxODg4OCwiaWF0IjoxNzAwODQyNzE4fQ.sRu4ihF-umzG2vRZuzt3O9y2_ni8-ZIWsCfCQMe3Wh4', '2023-11-24 16:18:38'),
(56, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDkxOTE3MDQzNCwiaWF0IjoxNzAwOTE5MTcwfQ.xLh3_4H6oPWCSdewjS4spLXKnxmyu_yDHP6wvX-9Xps', '2023-11-25 13:32:50'),
(58, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDkyNDM0NTgxNiwiaWF0IjoxNzAwOTI0MzQ1fQ.LWCyDhs9jav8EqT2JdE27y0cPAOOO5PjQ3iJbhcLGjc', '2023-11-25 14:59:05'),
(59, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDkzMTM4MjMyMiwiaWF0IjoxNzAwOTMxMzgyfQ.yGyABqXVmVN1JIX8KTCGHbzgYb5LKchFts01zhuYOyY', '2023-11-25 16:56:22'),
(60, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTM2NjcxODU3NCwiaWF0IjoxNzAxMzY2NzE4fQ.rOKBF1v78lSh5NnT0bXyoth2ncmCmONJhhi_sDlC5OU', '2023-11-30 17:51:58'),
(61, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDEzOTM2MTc1MzAsImlhdCI6MTcwMTM5MzYxN30.PBQCISwnDUbVsl4DW-IWGxVn9mWK8zJLiN_6NhIq8KM', '2023-12-01 01:20:17'),
(62, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDEzOTcxMjYwNTYsImlhdCI6MTcwMTM5NzEyNn0.h64ztGFC8bG3ooeANGsTAElfivE3El8IhPWiMqLiB1U', '2023-12-01 02:18:46'),
(63, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDEzOTc1NDU2NTQsImlhdCI6MTcwMTM5NzU0NX0.v26tf9Vj5SzAcbJ_h9YNrylhrn_D1YI6v3N_C9hEwAc', '2023-12-01 02:25:45'),
(64, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDEzOTc4ODY2NTgsImlhdCI6MTcwMTM5Nzg4Nn0.LnLS45iNdynTQw1NSmv_iXDtuEA4y-8W-TJN7DTiinI', '2023-12-01 02:31:26'),
(65, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE0MDAzMjMyMzAsImlhdCI6MTcwMTQwMDMyM30.RvyUpG3bcNWE4gs5nAURM3ZDuy62a0-tI3ctM6npSOg', '2023-12-01 03:12:03'),
(66, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTQxMDI5Mzc4MCwiaWF0IjoxNzAxNDEwMjkzfQ.I2lzxB2CpCyi0qFTpWf0GtqNGWuSWY-jhkScsOPdEX8', '2023-12-01 05:58:13'),
(67, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE0MTAzNzAyODEsImlhdCI6MTcwMTQxMDM3MH0.nYzSX2yrNOE9G4wTOVTPSQ6PalJH7zQYuAbPJFYIqI4', '2023-12-01 05:59:30'),
(68, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTc4MTYxNTY1NywiaWF0IjoxNzAxNzgxNjE1fQ.ITdQ9-dd0eAEgT5Fy8Jyz15YU8KZ5VzSEkEh4ToKIcI', '2023-12-05 13:06:55'),
(69, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTgwNjYzMTQ2MywiaWF0IjoxNzAxODA2NjMxfQ.M1jMWLVffFyAte95FM5dj6Bmsrc4VbwKw-O3X8NY8AY', '2023-12-05 20:03:51'),
(70, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTgwNjcyOTU5NywiaWF0IjoxNzAxODA2NzI5fQ.x3rr8gP1bRGuOiE2y5UUEpf4UVS-xt7T5T3zaFD6DZc', '2023-12-05 20:05:29'),
(71, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE4MDY3NzczMzksImlhdCI6MTcwMTgwNjc3N30.RnJZc4rLjDlAjLyJ7CTzAsV8litlfFUkMbmFdz_efjk', '2023-12-05 20:06:17'),
(72, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTgwODg1MDAwMiwiaWF0IjoxNzAxODA4ODUwfQ.4Jf2c6iNFKAFmEqzPkJ5FEJZG9zupYwD1nXjiEADiVo', '2023-12-05 20:40:50'),
(73, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE4MDg4NzI2MzEsImlhdCI6MTcwMTgwODg3Mn0.KS_u8S5jxOqgnv0_iGgo2UFBOCVuWRvtvPqhhB7Yb2Y', '2023-12-05 20:41:12'),
(74, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTg4NTU4NTI0OSwiaWF0IjoxNzAxODg1NTg1fQ.jMibIPRgOaX3Bb4-lKWIkfhw-3o-ZsfBAf8dahNBIE0', '2023-12-06 17:59:45'),
(75, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE4ODU2Mjg5ODYsImlhdCI6MTcwMTg4NTYyOH0.YUGjw7bKPMfFVGUZggmduG6xBsYCO1zaHY30UOurjKs', '2023-12-06 18:00:28'),
(76, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTg4NjUwMzc3MCwiaWF0IjoxNzAxODg2NTAzfQ.cVY9Dp3ox1IOLoUAN6p67KpmLSIc_TDtRfcPMuctmCg', '2023-12-06 18:15:03'),
(77, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE4ODY4NDkzMjgsImlhdCI6MTcwMTg4Njg0OX0.zaPNfjkXdyy252TDnluVsu-bzzyY4onotyCWbCdiIsc', '2023-12-06 18:20:49'),
(78, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTk2NjE3NTM2NCwiaWF0IjoxNzAxOTY2MTc1fQ.-2xjBklV0mPopN0-6rfOUa3Ro1uCCxPtFPA_Wk_-olc', '2023-12-07 16:22:55'),
(79, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDE5NjYxODcwMDcsImlhdCI6MTcwMTk2NjE4N30.HZf3Y9aX3GEDoCwVydL5VfYMCPtYRawcypCzqikRVh0', '2023-12-07 16:23:07'),
(80, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMTk2NzA3MjY3OSwiaWF0IjoxNzAxOTY3MDcyfQ.eJBxM83JISFIydrh72rrRtkTicqbNNEAF35LW-4WgDc', '2023-12-07 16:37:52'),
(81, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMjAwNDA3MTUzMywiaWF0IjoxNzAyMDA0MDcxfQ.QDGzKwfSKy4T6IlQ1xhQ54BeYVlqt4mkQR2YcIS4S1g', '2023-12-08 02:54:31'),
(82, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDIwMDQxMDM2MzYsImlhdCI6MTcwMjAwNDEwM30.z2spxRjnAhnKKimCKG3ZRW-dyBM6wPbOvsjPTvkn4NU', '2023-12-08 02:55:03'),
(83, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDIwMDcwMjAxNjksImlhdCI6MTcwMjAwNzAyMH0.Uf2iPnEw7vkTS8eHAqnzMqMaF9Ko3ze5sobcITNtLWM', '2023-12-08 03:43:40'),
(84, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMjMwNTYxMDE0MSwiaWF0IjoxNzAyMzA1NjEwfQ.wBMbaDiOiqDzR4526Uvuo_Lh3KNZXvbw59WndgGPn_8', '2023-12-11 14:40:10'),
(85, 17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTcsImRhdGUiOjE3MDIzMDU2Nzk4MTEsImlhdCI6MTcwMjMwNTY3OX0.qqGcFpjZI2EdtfNRZ3FgOQRPR9L08eK_s6pnfBHqqzU', '2023-12-11 14:41:19'),
(86, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMjMwNzQzMjI2NywiaWF0IjoxNzAyMzA3NDMyfQ.B13WMIrPXXbM3yTplOM_drOjxi6pBanqk-zvtRrWF08', '2023-12-11 15:10:32');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_type` varchar(50) NOT NULL,
  `nom_sous_type` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 ;

--
-- Déchargement des données de la table `types`
--

INSERT INTO `types` (`id`, `nom_type`, `nom_sous_type`) VALUES
(2, 'TDM', 'VENTRE'),
(3, 'IRM', 'PIED'),
(5, 'ECHO', 'ABDOMINALE'),
(6, 'TDM', 'CHEVILLE'),
(7, 'TDM', 'POIGNET'),
(8, 'IRM', 'CERVEAU'),
(9, 'TDM', 'GENOUX');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `adresse` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `rpps` varchar(50) NOT NULL,
  `role` enum('admin','radiologue','secretaire','medecin') CHARACTER SET utf8mb4 NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 ;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `tel`, `adresse`, `email`, `password`, `rpps`, `role`, `is_verified`) VALUES
(1, 'Tommy', '0344824468', 'Tanambao', 'tommymiza20@gmail.com', '$2b$10$srkZ0csYhp7MfHsqS5eHTuDsthS1rchw2AgYedfaQ1JAS5DQ1rPjK', '0315225422', 'admin', 1),
(17, 'Miza', '0336350015', 'Fianarantsoa', 'tommymiza6@gmail.com', '$2b$10$ZUvs1W61FEh2G/wrzFGhne9gxpDgBIQAvZ2h71rDbZIsFkvXR3CM2', '655', 'radiologue', 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `demandes`
--
ALTER TABLE `demandes`
  ADD CONSTRAINT `demandes_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `types` (`id`) ON DELETE RESTRICT;

--
-- Contraintes pour la table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`id_receveur`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`id_envoyeur`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `tokens`
--
ALTER TABLE `tokens`
  ADD CONSTRAINT `tokens_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
