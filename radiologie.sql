-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 25 nov. 2023 à 12:37
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 7.3.27

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

CREATE TABLE `codes` (
  `id` int(11) NOT NULL,
  `code` int(11) NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(24, 961815, 'ainajh11@gmail.com'),
(25, 930796, 'ainajh11@gmail.com'),
(26, 689931, 'ainajh11@gmail.com'),
(27, 138918, 'vujyqil@mailinator.com'),
(28, 119821, 'ainajh11@gmail.com'),
(29, 566805, 'ainajh11@gmail.com'),
(30, 584679, 'ainajh11@gmail.com'),
(31, 905210, 'ainajh11@gmail.com'),
(32, 99478, 'ainajh11@gmail.com'),
(33, 736894, 'ainajh11@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `demandes`
--

CREATE TABLE `demandes` (
  `id` int(11) NOT NULL,
  `nom_patient` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datenais` date NOT NULL,
  `tel` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `rdv` date DEFAULT NULL,
  `id_type` int(11) NOT NULL,
  `id_medecin` int(11) DEFAULT NULL,
  `lieu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_rdv` date DEFAULT NULL,
  `ordonnance` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `demandes`
--

INSERT INTO `demandes` (`id`, `nom_patient`, `email`, `datenais`, `tel`, `created_at`, `rdv`, `id_type`, `id_medecin`, `lieu`, `date_rdv`, `ordonnance`) VALUES
(47, 'Aina  JH', 'ainajh11@gmail.com', '2023-11-01', '56465858', '2023-11-25 10:49:47', '2023-11-28', 5, NULL, 'Athis', '2023-11-25', NULL),
(48, 'RAKOTO Jean', 'ainajh11@gmail.com', '2023-01-01', '54574886', '2023-11-25 10:50:34', '2023-05-27', 8, NULL, NULL, NULL, NULL),
(49, 'HALAL Kri', 'jikixir@mailinator.com', '1979-03-02', '+1 (303) 946-9556', '2023-06-14 11:19:14', NULL, 3, 20, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `id_envoyeur` int(11) NOT NULL,
  `id_receveur` int(11) NOT NULL,
  `message` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lu` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `messages`
--

INSERT INTO `messages` (`id`, `id_envoyeur`, `id_receveur`, `message`, `lu`, `created_at`) VALUES
(19, 1, 12, 'Coucou', 1, '2023-11-23 12:39:27'),
(20, 12, 1, 'Salut', 1, '2023-11-23 12:39:36'),
(21, 1, 12, 'Hola', 1, '2023-11-23 12:39:50'),
(22, 12, 1, 'Ouii ?', 1, '2023-11-23 12:39:53'),
(23, 1, 12, 'Ouiiii', 1, '2023-11-23 12:40:18'),
(24, 1, 12, 'Salut', 1, '2023-11-23 12:40:52'),
(25, 12, 1, 'Eeeeeu', 1, '2023-11-23 12:40:59'),
(26, 1, 12, 'Quoi ?', 1, '2023-11-23 12:41:01'),
(27, 1, 12, 'Non rien', 1, '2023-11-23 12:41:07'),
(28, 12, 1, 'Oke', 1, '2023-11-23 12:41:14'),
(29, 12, 1, 'Quoi ?', 1, '2023-11-23 12:41:22'),
(30, 12, 1, 'Non rien', 1, '2023-11-23 12:41:34'),
(31, 1, 12, 'Quoi ?', 1, '2023-11-23 12:42:18'),
(32, 12, 1, 'Quoi ?', 1, '2023-11-23 12:42:24'),
(33, 1, 12, 'Quoi ?', 1, '2023-11-23 12:42:27'),
(34, 12, 1, 'Quoi ?', 1, '2023-11-23 12:42:33'),
(35, 1, 12, 'Quoi ?', 1, '2023-11-23 12:42:37'),
(36, 12, 1, 'Ouii ?', 1, '2023-11-23 12:43:27'),
(37, 1, 12, 'Qoziuodiua', 1, '2023-11-23 12:43:30'),
(38, 1, 12, 'lzelfkjzelkfj*', 1, '2023-11-23 12:43:34'),
(39, 12, 1, 'ùfmlezùmflz', 1, '2023-11-23 12:43:37'),
(40, 1, 12, 'Coucou', 1, '2023-11-23 12:45:03'),
(41, 12, 1, 'Ouiii ?', 1, '2023-11-23 12:45:07'),
(42, 12, 1, 'Non rien', 1, '2023-11-23 12:45:19'),
(43, 1, 12, 'Ouii ?', 1, '2023-11-23 12:45:32'),
(44, 1, 12, 'Coucou', 1, '2023-11-23 12:52:19'),
(45, 12, 1, 'Ouiii ?', 1, '2023-11-23 12:52:22'),
(46, 1, 12, 'Non Rien', 1, '2023-11-23 12:52:26'),
(47, 12, 1, 'Hehe', 1, '2023-11-23 12:52:28'),
(48, 12, 1, 'Kaiza', 1, '2023-11-23 12:58:25'),
(49, 1, 12, 'De aona eh', 1, '2023-11-23 12:58:30'),
(50, 12, 1, 'Hola', 1, '2023-11-23 14:58:01'),
(51, 1, 12, 'Coucou', 1, '2023-11-23 14:58:42'),
(52, 12, 1, 'Oui ?', 1, '2023-11-23 14:58:56'),
(53, 1, 12, 'Non rien', 1, '2023-11-23 14:59:00'),
(54, 1, 12, 'Quoi ?', 1, '2023-11-23 14:59:05'),
(55, 12, 1, 'Hola', 1, '2023-11-23 14:59:26'),
(56, 12, 1, 'Oui ?', 1, '2023-11-23 14:59:31'),
(57, 12, 1, 'Non rien', 1, '2023-11-23 14:59:34'),
(58, 12, 1, 'Hola', 1, '2023-11-23 15:00:17'),
(59, 1, 12, 'zclkjzkdj', 1, '2023-11-23 15:00:34'),
(60, 1, 12, 'cmekmlzkd', 1, '2023-11-23 15:00:36'),
(61, 1, 12, 'cjzdljkcsl', 1, '2023-11-23 15:00:37'),
(62, 12, 1, 'clzlkdmlzkcml', 1, '2023-11-23 15:00:54'),
(63, 12, 1, 'c', 1, '2023-11-24 11:00:22'),
(64, 12, 1, 'Hola', 1, '2023-11-24 11:00:27'),
(65, 1, 12, 'Coucou', 1, '2023-11-24 11:02:27'),
(66, 1, 12, 'Encore coucou', 1, '2023-11-24 11:02:43'),
(67, 1, 12, 'Quoi', 1, '2023-11-24 11:03:08'),
(68, 1, 12, 'Non rien', 1, '2023-11-24 11:03:36'),
(69, 12, 1, 'Ouiii ?', 1, '2023-11-24 11:03:44'),
(70, 12, 1, 'Non ', 1, '2023-11-24 11:03:46'),
(71, 12, 1, 'Non', 1, '2023-11-24 11:03:47'),
(72, 1, 12, 'efkzmlefkzmlk', 1, '2023-11-24 11:03:50'),
(73, 12, 1, 'lckzejlkcjez', 1, '2023-11-24 11:09:01'),
(74, 12, 1, 'cmlzkeclkld', 1, '2023-11-24 11:09:15'),
(75, 1, 12, 'Hohoh', 1, '2023-11-24 11:14:38'),
(76, 1, 12, 'Hola', 1, '2023-11-24 11:15:44'),
(77, 1, 12, 'Hola', 1, '2023-11-24 11:16:12'),
(78, 1, 12, 'Hola', 1, '2023-11-24 11:16:23'),
(79, 1, 12, 'Test', 1, '2023-11-24 11:16:50'),
(80, 1, 12, 'FEZlfk', 1, '2023-11-24 11:16:54'),
(81, 1, 12, 'fmelzkmfl', 1, '2023-11-24 11:16:56'),
(82, 12, 1, 'fmelzkmlfkze', 1, '2023-11-24 12:08:51'),
(83, 12, 1, 'fezkfmlzk', 1, '2023-11-24 12:09:05'),
(84, 12, 1, 'lfùezmlf', 1, '2023-11-24 12:10:12'),
(85, 12, 1, 'lfmeùzlf', 1, '2023-11-24 12:10:16'),
(86, 12, 1, 'meflkzlmfk', 1, '2023-11-24 12:10:20'),
(87, 12, 1, 'mflzkez', 1, '2023-11-24 12:12:41'),
(88, 12, 1, 'mflezkfmlkds', 1, '2023-11-24 12:12:44'),
(89, 12, 1, 'cmdslkc', 1, '2023-11-24 12:12:48'),
(90, 1, 12, 'fmezlkflmzk', 1, '2023-11-24 12:13:00'),
(91, 1, 12, 'mflkezlmfk', 0, '2023-11-24 12:13:06'),
(92, 1, 12, 'zeer', 0, '2023-11-25 11:29:53');

-- --------------------------------------------------------

--
-- Structure de la table `soustypes`
--

CREATE TABLE `soustypes` (
  `id` int(11) NOT NULL,
  `nom_sous_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `soustypes`
--

INSERT INTO `soustypes` (`id`, `nom_sous_type`) VALUES
(1, 'PIED'),
(2, 'CHEVILLE');

-- --------------------------------------------------------

--
-- Structure de la table `tokens`
--

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `token` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `tokens`
--

INSERT INTO `tokens` (`id`, `id_user`, `token`, `created_at`) VALUES
(47, 12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImRhdGUiOjE3MDA3MjgwODc0MTgsImlhdCI6MTcwMDcyODA4N30.g10r5nX0W-Na3Y9EtjQ-pSgADIGM9iB6WX8PgxJlTxs', '2023-11-23 08:28:07'),
(48, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDcyODE2MjcxNiwiaWF0IjoxNzAwNzI4MTYyfQ.Cc3h92pEKERQXs9byCBCgQH2eLkPnDXz8JHqpoKVnnE', '2023-11-23 08:29:22'),
(49, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczMDA5MTc2OCwiaWF0IjoxNzAwNzMwMDkxfQ.qFe6GWK-sN1QoYel373qa3Doo67si4pyTE8fT0jH4lM', '2023-11-23 09:01:31'),
(50, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczMDQ5MDY1NiwiaWF0IjoxNzAwNzMwNDkwfQ.nEKWkNBOfAXdrtRw4hDDMjQ1-77KLovSSnwKmazcdmQ', '2023-11-23 09:08:10'),
(51, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDczNjY1MjMxNSwiaWF0IjoxNzAwNzM2NjUyfQ.aZBz1t9GCVf_MBXjFgdPby1AsuHRgmKyWIHpUoWc-oQ', '2023-11-23 10:50:52'),
(52, 12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImRhdGUiOjE3MDA3MzkxNDU5NDgsImlhdCI6MTcwMDczOTE0NX0.sf1qxS8_KZCU8NuZzI6H3u050xeIyGHATk-sIbPWHlI', '2023-11-23 11:32:25'),
(53, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDgyMzAxMzY4NywiaWF0IjoxNzAwODIzMDEzfQ.3EtIOiO9rA_rnu03ZIj4AnOwQ_w7XK8hIeesGCRDKN8', '2023-11-24 10:50:13'),
(54, 12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTIsImRhdGUiOjE3MDA4MjMwNDU1MjcsImlhdCI6MTcwMDgyMzA0NX0.UvRGDpAEkUNjGBq_tzC7XGhfwCbJCnFVFTIxAroPVt8', '2023-11-24 10:50:45'),
(55, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDg0MjcxODg4OCwiaWF0IjoxNzAwODQyNzE4fQ.sRu4ihF-umzG2vRZuzt3O9y2_ni8-ZIWsCfCQMe3Wh4', '2023-11-24 16:18:38'),
(56, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDkwNTIxMzk0NCwiaWF0IjoxNzAwOTA1MjEzfQ.cFuob1EiE_vo0qKPE0Jcmvsl3K7EJCWOzBE2_m6I8M4', '2023-11-25 09:40:13'),
(58, 1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZGF0ZSI6MTcwMDkxMTE4NTA5MywiaWF0IjoxNzAwOTExMTg1fQ.3NxawjoyZ4PipwtbvZRPDGh-Ry-Kc77cLdgc1MAIl8E', '2023-11-25 11:19:45');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE `types` (
  `id` int(11) NOT NULL,
  `nom_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nom_sous_type` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(9, 'TDM', 'GENOUX'),
(10, 'TDM', 'JAMBE');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tel` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adresse` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `rpps` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` enum('admin','radiologue','medecin') COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `tel`, `adresse`, `email`, `password`, `rpps`, `role`, `is_verified`) VALUES
(1, 'Tommy', '0344824468', 'Tanambao', 'tommymiza20@gmail.com', '$2b$10$srkZ0csYhp7MfHsqS5eHTuDsthS1rchw2AgYedfaQ1JAS5DQ1rPjK', '0315225422', 'admin', 1),
(12, 'Tommy Miza', '0336350015', 'Tanambao', 'tommymiza6@gmail.com', '$2b$10$v6hTYMu5ckODoOJ/pKMANujd1z1gvCgdezXaEXkbQHcnNoAKPQ6jO', '255222', 'radiologue', 1),
(20, 'JOHN DOE', '+1 (512) 167-1599', 'Sunt quam dolore lib', 'ainajh11@gmail.com', '$2b$10$e2y6wj.vhh.kY5bj57Zbv.DAk4izvMJE6VicTWjT.R1b4LNSTIdmi', 'Et necessitatibus es', 'medecin', 1),
(21, 'Voluptatem Nemo rei', '+1 (177) 593-5751', 'Irure totam anim ut ', 'lyxyxi@mailinator.com', '$2b$10$ev4vEQtrizAUZfZcTfajxOdACA.vJgAPy.A.vhbc04bU2Oq1RdYcq', 'Et tenetur ipsam in ', 'radiologue', 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `codes`
--
ALTER TABLE `codes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `demandes`
--
ALTER TABLE `demandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_type` (`id_type`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_envoyeur` (`id_envoyeur`),
  ADD KEY `id_receveur` (`id_receveur`);

--
-- Index pour la table `soustypes`
--
ALTER TABLE `soustypes`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `tokens`
--
ALTER TABLE `tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `codes`
--
ALTER TABLE `codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT pour la table `demandes`
--
ALTER TABLE `demandes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT pour la table `soustypes`
--
ALTER TABLE `soustypes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `tokens`
--
ALTER TABLE `tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT pour la table `types`
--
ALTER TABLE `types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `demandes`
--
ALTER TABLE `demandes`
  ADD CONSTRAINT `demandes_ibfk_1` FOREIGN KEY (`id_type`) REFERENCES `types` (`id`);

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
