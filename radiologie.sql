-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 25 nov. 2023 à 13:52
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
) ENGINE=InnoDB AUTO_INCREMENT=24;

--
-- Déchargement des données de la table `codes`
--

INSERT INTO `codes` (`id`, `code`, `email`) VALUES
(17, 935701, 'tommymiza6@gmail.com'),
(19, 393520, 'tommymiza6@gmail.com'),
(20, 357416, 'tommymiza6@gmail.com'),
(21, 103620, 'tommymiza20@gmail.com'),
(22, 953757, 'tommymiza20@gmail.com'),
(23, 993142, 'tommymiza20@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `demandes`
--

DROP TABLE IF EXISTS `demandes`;
CREATE TABLE IF NOT EXISTS `demandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_patient` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=27;

--
-- Déchargement des données de la table `demandes`
--

INSERT INTO `demandes` (`id`, `nom_patient`, `email`, `datenais`, `tel`, `created_at`, `rdv`, `id_type`, `id_medecin`, `lieu`, `date_rdv`, `ordonnance`) VALUES
(22, 'Miza Tommy', 'tommymiza20@gmail.com', '2023-11-09', '0336350015', '2023-11-23 08:28:36', NULL, 6, 12, 'Savigny', '2023-11-23', '/files/ordonnance_1700728116878.png'),
(23, 'Miza Tommy', 'tommymiza20@gmail.com', '2023-11-09', '0336350015', '2023-11-23 08:35:25', '2023-11-30', 5, 12, 'Athis', '2023-11-24', NULL);

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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_envoyeur` (`id_envoyeur`),
  KEY `id_receveur` (`id_receveur`)
) ENGINE=InnoDB AUTO_INCREMENT=92;

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
) ENGINE=InnoDB AUTO_INCREMENT=58;

--
-- Déchargement des données de la table `tokens`
--

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
) ENGINE=InnoDB AUTO_INCREMENT=10;

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
  `role` enum('admin','radiologue','secretaire','medecin') NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=17;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `tel`, `adresse`, `email`, `password`, `rpps`, `role`, `is_verified`) VALUES
(1, 'Tommy', '0344824468', 'Tanambao', 'tommymiza20@gmail.com', '$2b$10$srkZ0csYhp7MfHsqS5eHTuDsthS1rchw2AgYedfaQ1JAS5DQ1rPjK', '0315225422', 'admin', 1),
(16, 'Tommy Miza', '0336350015', 'Fianarantsoa', 'tommymiza6@gmail.com', '$2b$10$Kqg6.2RQ9lb1I/bgwTxsc.Xbq.9K.DfPqaSBIb1gQ2bSm/kjgwKfS', '25512', 'secretaire', 1);

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
