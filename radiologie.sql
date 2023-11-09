-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 09 nov. 2023 à 19:21
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
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `demande`
--

DROP TABLE IF EXISTS `demande`;
CREATE TABLE IF NOT EXISTS `demande` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_patient` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `datenais` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rdv` date NOT NULL,
  `id_type` int NOT NULL,
  `id_sous_type` int NOT NULL,
  `status` enum('non pris','pris') NOT NULL DEFAULT 'non pris',
  `id_medecin` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_type` (`id_type`,`id_sous_type`),
  KEY `id_sous_type` (`id_sous_type`)
) ENGINE=InnoDB;

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
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_envoyeur` (`id_envoyeur`),
  KEY `id_receveur` (`id_receveur`)
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `soustypes`
--

DROP TABLE IF EXISTS `soustypes`;
CREATE TABLE IF NOT EXISTS `soustypes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_sous_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

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
) ENGINE=InnoDB AUTO_INCREMENT=4;

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `tel` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `rpps` varchar(50) NOT NULL,
  `role` enum('admin','radiologue','medecin') NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `tel`, `email`, `password`, `rpps`, `role`, `is_verified`) VALUES
(1, 'Tommy', '0344824468', 'tommymiza20@gmail.com', '$2b$10$srkZ0csYhp7MfHsqS5eHTuDsthS1rchw2AgYedfaQ1JAS5DQ1rPjK', '0315225422', 'admin', 1),
(3, 'Tommy Miza', '0336350015', 'tommymiza6@gmail.com', '$2b$10$mWcXd8bP1Fcudz65nt3RQua4fzk9dfssJphBssn9BY.2seUIPGzb2', '0315225512', 'radiologue', 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `demande`
--
ALTER TABLE `demande`
  ADD CONSTRAINT `demande_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `types` (`id`) ON DELETE RESTRICT,
  ADD CONSTRAINT `demande_ibfk_2` FOREIGN KEY (`id_sous_type`) REFERENCES `soustypes` (`id`) ON DELETE RESTRICT;

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
