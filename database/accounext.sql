-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 30 mai 2025 à 18:07
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `accounext`
--

-- --------------------------------------------------------

--
-- Structure de la table `benefices`
--

CREATE TABLE `benefices` (
  `id` int(11) NOT NULL,
  `annee` int(11) NOT NULL,
  `montant` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `benefices`
--

INSERT INTO `benefices` (`id`, `annee`, `montant`) VALUES
(1, 2020, 125000.00),
(2, 2021, 185000.00),
(3, 2022, 220000.00),
(4, 2023, 275000.00),
(5, 2024, 310000.00);

-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

CREATE TABLE `classes` (
  `num_Class` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `classes`
--

INSERT INTO `classes` (`num_Class`, `nom`) VALUES
(1, 'Comptes de financement permanent'),
(2, 'Comptes d\'actif immobilisé'),
(3, 'Comptes d\'actif circulant (hors trésorerie)'),
(4, 'Comptes de passif circulant (hors trésorerie)'),
(5, 'Comptes de trésorerie'),
(6, 'Comptes de charges'),
(7, 'Comptes de produits'),
(8, 'Comptes de résultats'),
(9, 'Comptes de produits et charges réfléchis'),
(10, 'Comptes spéciaux');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `solde` decimal(12,2) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `email`, `telephone`, `adresse`, `solde`, `description`) VALUES
(1, 'benalla mounaime', '', '065103464', '', 0.00, ''),
(2, 'mounaime', 'parentgta520@gmail.com', '065460', '', 0.00, ''),
(3, 'mounaime', 'parentgta520@gmail.com', '065460', 'fasdfas fdasfas errachidia', 0.00, 'f,dsa/,f/asf'),
(4, 'clients username', 'rgdgdg@gmail.com', '06496446446', 'fadfafadadfadsffdfa', 1324534.00, 'afadfafaf'),
(5, 'tbi9a tb9', 'tb9tb9@gmail.com', '06496446446', 'Errachidia', 3000.00, 'ba9i makhlsni'),
(6, 'lionel messi', 'messi@gmail.com', '06496446446', 'Errachidia', 0.00, 'fdaffaf'),
(7, 'benalla abdelatif', 'benalla@gmail.com', '0650940922', 'Errachidia', 7894.00, 'test');

-- --------------------------------------------------------

--
-- Structure de la table `client_transactions`
--

CREATE TABLE `client_transactions` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `montant` decimal(12,2) NOT NULL,
  `description` text DEFAULT NULL,
  `justificatif` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `client_transactions`
--

INSERT INTO `client_transactions` (`id`, `client_id`, `date`, `montant`, `description`, `justificatif`) VALUES
(1, 3, '2025-05-27', 6000.00, 'payee 6000', 'uploads/justificatifs/6835fc5f9df6a_canvaLogo.png'),
(2, 3, '2025-05-27', 743.00, 'paye 743', NULL),
(3, 6, '2025-05-28', 4000.00, 'payee 4000 dh', NULL),
(4, 6, '2025-05-28', 565.00, 'payee 565', 'uploads/justificatifs/683758e043124_canvaLogo.png'),
(5, 1, '2025-05-29', 400.00, '', NULL),
(6, 1, '2025-05-29', 2000.00, 'payee 2000', 'uploads/justificatifs/68387ea9cc87d_canvaLogo.png');

-- --------------------------------------------------------

--
-- Structure de la table `comptes`
--

CREATE TABLE `comptes` (
  `id` int(11) NOT NULL,
  `numero_compte` varchar(10) NOT NULL,
  `nom_compte` varchar(255) NOT NULL,
  `class_id` int(11) NOT NULL,
  `montant_debit` decimal(12,2) DEFAULT 0.00,
  `montant_credit` decimal(12,2) DEFAULT 0.00,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comptes`
--

INSERT INTO `comptes` (`id`, `numero_compte`, `nom_compte`, `class_id`, `montant_debit`, `montant_credit`, `created_at`, `updated_at`) VALUES
(1, '11', 'CAPITAUX PROPRES', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(2, '111', 'Capital social ou personnel', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(3, '1111', 'Capital social', 1, 58326.00, 0.00, '2025-05-18 15:52:57', '2025-05-29 13:07:18'),
(4, '1112', 'Fonds de dotation', 1, 6000.00, 2500.00, '2025-05-18 15:52:57', '2025-05-26 17:23:10'),
(5, '1117', 'Capital personnel', 1, 10789.00, 22000.00, '2025-05-18 15:52:57', '2025-05-26 17:23:10'),
(6, '11171', 'Capital individuel', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(7, '11175', 'Compte de l\'exploitant', 1, 543543.00, 543543.00, '2025-05-18 15:52:57', '2025-05-29 12:04:55'),
(8, '1119', 'Actionnaires, capital souscrit-non appelé', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(9, '112', 'Primes d\'émission, de fusion et d\'apport', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(10, '1121', 'Primes d\'émission', 1, 5000.00, 5000.00, '2025-05-18 15:52:57', '2025-05-28 20:01:31'),
(11, '1122', 'Primes de fusion', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(12, '1123', 'Primes d\'apport', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(13, '113', 'Ecarts de réévaluation', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(14, '1130', 'Ecarts de réévaluation', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(15, '114', 'Réserve légale', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(16, '1140', 'Réserve légale', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(17, '115', 'Autres réserves', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(18, '1151', 'Réserves statutaires ou contractuelles', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(19, '1152', 'Réserves facultatives', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(20, '1155', 'Réserves réglementées', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(21, '116', 'Report à nouveau', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(22, '1161', 'Report à nouveau (solde créditeur)', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(23, '1169', 'Report à nouveau (solde débiteur)', 1, 0.00, 32432.00, '2025-05-18 15:52:57', '2025-05-29 13:07:18'),
(24, '118', 'Résultats nets en instance d\'affectation', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(25, '1181', 'Résultats nets en instance d\'affectation (solde créditeur)', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(26, '1189', 'Résultats nets en instance d\'affectation (solde débiteur)', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(27, '119', 'Résultat net de l\'exercice', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(28, '1191', 'Résultat net de l\'exercice (solde créditeur)', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(29, '1199', 'Résultat net de l\'exercice (solde débiteur)', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(30, '13', 'CAPITAUX PROPRES ASSIMILES', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(31, '131', 'Subventions d\'investissement', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(32, '1311', 'Subventions d\'investissement reçues', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(33, '1319', 'Subventions d\'investissement inscrites au CPC', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(34, '135', 'Provisions réglementées', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(35, '1351', 'Provisions pour amortissements dérogatoires', 1, 0.00, 7894.00, '2025-05-18 15:52:57', '2025-05-22 00:44:07'),
(36, '1352', 'Provisions pour plus-values en instance d\'imposition', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(37, '1354', 'Provisions pour investissements', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(38, '1355', 'Provisions pour reconstitution des gisements', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(39, '1356', 'Provisions pour acquisition et construction de logements', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(40, '1358', 'Autres provisions réglementées', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(41, '14', 'DETTES DE FINANCEMENT', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(42, '141', 'Emprunts obligataires', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(43, '1410', 'Emprunts obligataires', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(44, '148', 'Autres dettes de financement', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(45, '1481', 'Emprunts auprès des établissements de crédit', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(46, '1482', 'Avances de l\'Etat', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(47, '1483', 'Dettes rattachées à des participations', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(48, '1484', 'Billets de fonds', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(49, '1485', 'Avances reçues et comptes courants bloqués', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(50, '1486', 'Fournisseurs d\'immobilisation', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(51, '1487', 'Dépôts et cautionnements reçues', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(52, '1488', 'Dettes de financement diverses', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(53, '15', 'Provisions durables pour risques et charges', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(54, '151', 'Provisions pour risques', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(55, '1511', 'Provisions pour litiges', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(56, '1512', 'Provisions pour garanties données aux clients', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(57, '1513', 'Provision pour propre assureur', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(58, '1514', 'Provision pour pertes sur marchés à terme', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(59, '1515', 'Provisions pour amendes, double droits, pénalités', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(60, '1516', 'Provisions pour pertes de change', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(61, '1518', 'Autres provisions pour risques', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(62, '155', 'Provisions pour charges', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(63, '1551', 'Provisions pour impôts', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(64, '1552', 'Provisions pour pensions de retraite et obligations similaires', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(65, '1555', 'Provisions pour charges à répartir sur plusieurs exercices', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(66, '1558', 'Autres provisions pour charges', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(67, '16', 'COMPTES DE LIAISON DES ETABLISSEMENTS ET SUCCURSALES', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(68, '160', 'Comptes de liaison des établissements et succursales', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(69, '1601', 'Comptes de liaison du siège', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(70, '1605', 'Comptes de liaison des établissements', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(71, '17', 'Ecarts de conversion - Passif', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(72, '171', 'Augmentation des créances immobilisées', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(73, '1710', 'Augmentation des créances immobilisées', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(74, '172', 'Diminution des dettes de financement', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(75, '1720', 'Diminution des dettes de financement', 1, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(76, '21', 'IMMOBILISATIONS EN NON-VALEURS', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(77, '211', 'Frais préliminaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(78, '2111', 'Frais de constitution', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(79, '2112', 'Frais préalables au démarrage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(80, '2113', 'Frais d\'augmentation du capital', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(81, '2114', 'Frais sur opérations de fusions, scissions et transformations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(82, '2116', 'Frais de prospection', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(83, '2117', 'Frais de publicité', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(84, '2118', 'Autres frais préliminaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(85, '212', 'Charges à répartir sur plusieurs exercices', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(86, '2121', 'Frais d\'acquisition des immobilisations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(87, '2125', 'Frais d\'émission des emprunts', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(88, '2128', 'Autres charges à répartir', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(89, '213', 'Primes de remboursement des obligations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(90, '2130', 'Primes de remboursement des obligations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(91, '22', 'IMMOBILISATIONS INCORPORELLES', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(92, '221', 'Immobilisation en recherche et développement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(93, '2210', 'Immobilisation en recherche et développement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(94, '222', 'Brevets, marques, droits et valeurs similaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(95, '2220', 'Brevets, marques, droits et valeurs similaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(96, '223', 'Fonds commercial', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(97, '2230', 'Fonds commercial', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(98, '228', 'Autres immobilisations incorporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(99, '2285', 'Autres immobilisations incorporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(100, '23', 'IMMOBILISATIONS CORPORELLES', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(101, '231', 'Terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(102, '2311', 'Terrains nus', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(103, '2312', 'Terrains aménagés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(104, '2313', 'Terrains bâtis', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(105, '2314', 'Terrains de gisement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(106, '2316', 'Agencements et aménagements de terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(107, '2318', 'Autres terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(108, '232', 'Constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(109, '2321', 'Bâtiments', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(110, '23211', 'Bâtiments industriels (A,B,,,)', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(111, '23214', 'Bâtiments administratifs et commerciaux (A,B,,,)', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(112, '23218', 'Autres bâtiments', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(113, '2323', 'Constructions sur terrains d\'autrui', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(114, '2325', 'Ouvrages d\'infrastructure', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(115, '2327', 'Agencements et aménagements des constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(116, '2328', 'Autres constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(117, '233', 'Installations techniques, matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(118, '2331', 'Installations techniques', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(119, '2332', 'Matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(120, '2332.1', 'Matériel', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(121, '2332.4', 'Outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(122, '2333', 'Emballages récupérables identifiables', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(123, '2338', 'Autres installations techniques, matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(124, '234', 'Matériel de transport', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(125, '2340', 'Matériel de transport', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(126, '235', 'Mobilier, matériel de bureau et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(127, '2351', 'Mobilier de bureau', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(128, '2352', 'Matériel de bureau', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(129, '2355', 'Matériel informatique', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(130, '2356', 'Agencements, installations et aménagements divers (biens n\'appartenant pas à l\'entreprise)', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(131, '2358', 'Autres mobilier, matériel de bureau et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(132, '238', 'Autres immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(133, '2380', 'Autres immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(134, '239', 'Immobilisations corporelles en cours', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(135, '2392', 'Immobilisations corporelles en cours des terrains et constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(136, '2393', 'Immobilisations corporelles en cours des installations techniques, matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(137, '2394', 'Immobilisations corporelles en cours de matériel de transport', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(138, '2395', 'Immobilisations corporelles en cours de mobilier, matériel de bureau et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(139, '2397', 'Avances et acomptes versés sur commandes d\'immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(140, '2398', 'Autres immobilisations corporelles en cours', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(141, '24', 'IMMOBILISATIONS FINANCIERES', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(142, '241', 'Prêts immobilsés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(143, '2441', 'Prêts au personnel', 2, 1233.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 20:27:51'),
(144, '2415', 'Prêts aux associés', 2, 0.00, 4233.00, '2025-05-18 15:52:57', '2025-05-27 00:04:09'),
(145, '2416', 'Billets de fonds', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(146, '2418', 'Autres prêts', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(147, '248', 'Autres créances financières', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(148, '2481', 'Titres immobilisés (droits de créance)', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(149, '24811', 'Obligations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(150, '24813', 'Bons d\'équipement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(151, '24818', 'Bons divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(152, '2483', 'Créances rattachées à des participations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(153, '2486', 'Dépôts et cautionnements versés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(154, '24861', 'Dépôts', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(155, '24864', 'Cautionnements', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(156, '2487', 'Créances immobilisées', 2, 0.00, 6789.00, '2025-05-18 15:52:57', '2025-05-22 00:45:25'),
(157, '2488', 'Créances financières diverses', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(158, '251', 'Titres de participation', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(159, '2510', 'Titres de participation', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(160, '258', 'Autres titres immobilisés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(161, '2581', 'Actions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(162, '2588', 'Titres divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(163, '27', 'ECARTS DE CONVERSION - ACTIF', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(164, '271', 'Diminution des créances immobilisées', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(165, '2710', 'Diminution des créances immobilisées', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(166, '272', 'Augmentation des dettes de financement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(167, '2720', 'Augmentation des dettes de financement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(168, '28', 'AMORTISSEMENTS DES IMMOBILISATIONS', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(169, '281', 'Amortissements des non-valeurs', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(170, '2811', 'Amortissements des frais préliminaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(171, '28111', 'Amortissements des frais de constitution', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(172, '28112', 'Amortissements des frais préliminaires au démarrage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(173, '28113', 'Amortissements des frais d\'augmentation du capital', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(174, '28114', 'Amortissements des frais sur opérations de fusions, scissions, et transformations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(175, '28116', 'Amortissements des frais de prospection', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(176, '28117', 'Amortissements des frais de publicité', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(177, '28118', 'Amortissements des autres frais préliminaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(178, '2812', 'Amortissements des charges à répartir', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(179, '28121', 'Amortissements des frais d\'acquisition des immobilisations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(180, '28125', 'Amortissements des frais d\'émission des emprunts', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(181, '28128', 'Amortissements des autres charges à répartir', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(182, '2813', 'Amortissements des primes de remboursement des obligations', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(183, '282', 'Amortissements des immobilisations incorporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(184, '2821', 'Amortissements de l\'immobilisation en recherche et développement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(185, '2822', 'Amortissements des brevets, marques, droits et valeurs similaires', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(186, '2823', 'Amortissements du fonds commercial', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(187, '2828', 'Amortissements des autres immobilisations incorporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(188, '283', 'Amortissements des immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(189, '2831', 'Amortissements des terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(190, '28311', 'Amortissements des terrains nus', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(191, '28312', 'Amortissements des terrains aménagés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(192, '28313', 'Amortissements des terrains bâtis', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(193, '28314', 'Amortissements des terrains de gisement', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(194, '28136', 'Amortissements des agencements et aménagements de terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(195, '28138', 'Amortissements des autres terrains', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(196, '2832', 'Amortissements des constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(197, '28321', 'Amortissements des bâtiments', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(198, '28323', 'Amortissements des constructions sur terrains d\'autrui', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(199, '28325', 'Amortissements des ouvrages d\'infrastructure', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(200, '28327', 'Amortissements des installations, agencements et aménagements des constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(201, '28328', 'Amortissements des autres constructions', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(202, '2833', 'Amortissements des installations techniques, matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(203, '28331', 'Amortissements des installations techniques', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(204, '28332', 'Amortissements du matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(205, '28333', 'Amortissements des emballages récupérables identifiables', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(206, '28338', 'Amortissements des autres installations techniques, matériel et outillage', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(207, '2834', 'Amortissements du matériel de transport', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(208, '2835', 'Amortissements du mobilier, matériel de bureau et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(209, '28351', 'Amortissements du mobilier de bureau', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(210, '28352', 'Amortissements du matériel de bureau', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(211, '28355', 'Amortissements du matériel informatique', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(212, '28356', 'Amortissements des agencements, installations et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(213, '28358', 'Amortissements des autres mobilier, matériel de bureau et aménagements divers', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(214, '2838', 'Amortissements des autres immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(215, '29', 'PROVISIONS POUR DÉPRÉCIATION DES IMMOBILISATIONS', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(216, '292', 'Provisions pour dépréciation des immobilisations incorporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(217, '2920', 'Provisions pour dépréciation des immobilisations incorporelles', 2, 0.00, 100000.00, '2025-05-18 15:52:57', '2025-05-21 23:06:48'),
(218, '293', 'Provisions pour dépréciation des immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(219, '2930', 'Provisions pour dépréciation des immobilisations corporelles', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(220, '294', 'Provisions pour dépréciation des immobilisations financières', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(221, '2941', 'Provisions pour dépréciation des prêts immobilisés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(222, '2948', 'Provisions pour dépréciation des autres créances financières', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(223, '2951', 'Provisions pour dépréciation des titres de participation', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(224, '2958', 'Provisions pour dépréciation des autres titres immobilisés', 2, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(225, '31', 'STOCKS', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(226, '311', 'Marchandises', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(227, '3111', 'Marchandises (groupe A)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(228, '3112', 'Marchandises (groupe B)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(229, '3116', 'Marchandises en cours de route', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(230, '3118', 'Autres marchandises', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(231, '312', 'Matières et fournitures consommables', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(232, '3121', 'Matières premières', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(233, '31211', 'Matières premières (groupe A)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(234, '31212', 'Matières premières (groupe B)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(235, '3122', 'Matières et fournitures consommables', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(236, '31221', 'Matières consommables (groupe A)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(237, '31222', 'Matières consommables (groupe B)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(238, '31223', 'Combustibles', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(239, '31224', 'Produits d\'entretien', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(240, '31225', 'Fournitures d\'atelier et d\'usine', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(241, '31226', 'Fournitures de magasin', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(242, '31227', 'Fournitures de bureau', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(243, '3123', 'Emballages', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(244, '31231', 'Emballages perdus', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(245, '31232', 'Emballages récupérables non identifiables', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(246, '31233', 'Emballages à usage mixte', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(247, '3126', 'Matières et fournitures consommables en cours de route', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(248, '3128', 'Autres matières et fournitures consommables', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(249, '313', 'Produits en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(250, '3131', 'Biens en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(251, '31311', 'Biens produits en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(252, '31312', 'Biens intermédiaires en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(253, '31317', 'Biens résiduels en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(254, '3134', 'Services en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(255, '31341', 'Travaux en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(256, '31342', 'Etudes en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(257, '31343', 'Prestations en cours', 3, 3000.00, 0.00, '2025-05-18 15:52:57', '2025-05-27 00:04:09'),
(258, '3138', 'Autres produits en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(259, '314', 'Produits intermédiaires et produits résiduels', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(260, '3141', 'Produits intermédiaires', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(261, '31411', 'Produits intermédiaires (groupe A)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(262, '31412', 'Produits intermédiaires (groupe B)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(263, '3145', 'Produits résiduels (ou matières de récupération)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(264, '31451', 'Déchets', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(265, '31452', 'Rebut', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(266, '31453', 'Matières de récupération', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(267, '3148', 'Autres produits intermédiaires et produits résiduels', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(268, '315', 'Produits finis', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(269, '3151', 'Produits finis (groupe A)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(270, '3152', 'Produits finis (groupe B)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(271, '3156', 'Produits finis en cours de route', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(272, '3158', 'Autres produits finis', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(273, '34', 'CREANCES DE L\'ACTIF CIRCULANT', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(274, '341', 'Fournisseurs débiteurs, avances et acomptes', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(275, '3411', 'Fournisseurs - avances et acomptes versés sur commandes d\'exploitation', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(276, '3413', 'Fournisseurs - créances pour emballages et matériel à rendre', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(277, '3417', 'Rabais, remises et ristournes à obtenir - avoirs non encore reçus', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(278, '3418', 'Autres fournisseurs débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(279, '342', 'Clients et comptes rattachés', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(280, '3421', 'Clients', 3, 2000.00, 0.00, '2025-05-18 15:52:57', '2025-05-27 15:22:28'),
(281, '34211', 'Clients - catégorie A', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(282, '34212', 'Clients - catégorie B', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(283, '3423', 'Clients - retenues de garantie', 3, 0.00, 5000.00, '2025-05-18 15:52:57', '2025-05-22 13:30:47'),
(284, '3424', 'Clients douteux ou litigieux', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(285, '3425', 'Clients - effets à recevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(286, '3427', 'Clients - factures à établir et créances sur travaux non encore facturés', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(287, '34271', 'Clients - factures à établir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(288, '34272', 'Créances sur travaux non encore facturables', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(289, '3428', 'Autres clients et comptes rattachés', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(290, '343', 'Personnel - débiteur', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(291, '3431', 'Avances et acomptes au personnel', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(292, '3438', 'Personnel - autres débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(293, '345', 'Etat - débiteur', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(294, '3451', 'Subventions à recevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(295, '34511', 'Subventions d\'investissement à recevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(296, '34512', 'Subventions d\'exploitation à recevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(297, '34513', 'Subventions d\'équilibre à recevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(298, '3453', 'Acomptes sur impôts sur les résultats', 3, 43243.00, 43243.00, '2025-05-18 15:52:57', '2025-05-29 11:52:39'),
(299, '3455', 'Etat - TVA récupérable', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(300, '34551', 'Etat - TVA récupérable sur immobilisations', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(301, '34552', 'Etat - TVA récupérable sur charges', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(302, '3456', 'Etat - crédit de TVA (suivant déclaration)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(303, '3458', 'Etat - autres comptes débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(304, '346', 'Comptes d\'associés - débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(305, '3461', 'Associés - comptes d\'apport en société', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(306, '3462', 'Actionnaires - capital souscrit et appelé non versé', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(307, '3463', 'Comptes courants des associés débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(308, '3464', 'Associés - opérations faites en commun', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(309, '3467', 'Créances rattachées aux comptes d\'associés', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(310, '3468', 'Autres comptes d\'associés débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(311, '348', 'Autres débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(312, '3481', 'Créances sur cessions d\'immobilisations', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(313, '3482', 'Créances sur cessions d\'éléments d\'actif circulant', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(314, '3487', 'Créances rattachées aux autres débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(315, '3488', 'Divers débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(316, '349', 'Comptes de régularisation - actif', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(317, '3491', 'Charges constatées d\'avance', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(318, '3493', 'Intérêts courus et non échus à percevoir', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(319, '3495', 'Comptes de répartition périodique des charges', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(320, '3497', 'Comptes transitoires ou d\'attente - débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(321, '35', 'TITRES ET VALEURS DE PLACEMENT', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(322, '350', 'Titres et valeurs de placement', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(323, '3501', 'Actions, partie libérée', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(324, '3502', 'Actions, partie non libérée', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(325, '3504', 'Obligations', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(326, '3506', 'Bons de caisse et bons de trésor', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(327, '35061', 'Bons de caisse', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(328, '35062', 'Bons de trésor', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(329, '3508', 'Autres titres et valeurs de placement similaires', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(330, '37', 'ECART DE CONVERSION - ACTIF (Eléments circulants)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(331, '370', 'Ecart de conversion - Actif (éléments circulants)', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(332, '3701', 'Diminution des créances circulantes', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(333, '3702', 'Augmentation des dettes circulantes', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(334, '39', 'PROVISIONS POUR DÉPRÉCIATION DES COMPTES DE L\'ACTIF CIRCULANT', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(335, '391', 'Provisions pour dépréciation des stocks', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(336, '3911', 'Provisions pour dépréciation des marchandises', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(337, '3912', 'Provisions pour dépréciation des matières et fournitures', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(338, '3913', 'Provisions pour dépréciation des produits en cours', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(339, '3914', 'Provisions pour dépréciation des produits intermédiaires', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(340, '3915', 'Provisions pour dépréciation des produits finis', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(341, '394', 'Provisions pour dépréciation des créances de l\'actif circulant', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(342, '3941', 'Provisions pour dépréciation - fournisseurs débiteurs, avances et acomptes', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(343, '3942', 'Provisions pour dépréciation des clients et comptes rattachés', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(344, '3943', 'Provisions pour dépréciation du personnel - débiteur', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(345, '3946', 'Provisions pour dépréciation des comptes d\'associés débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(346, '3948', 'Provisions pour dépréciation des autres débiteurs', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(347, '395', 'Provisions pour dépréciation des titres et valeurs de placement', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(348, '3950', 'Provisions pour dépréciation des titres et valeurs de placement', 3, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(349, '44', 'DETTES DU PASSIF CIRCULANT', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(350, '441', 'Fournisseurs et comptes rattachés', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(351, '4411', 'Fournisseurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(352, '44111', 'Fournisseurs - catégorie A', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(353, '44112', 'Fournisseurs - catégorie B', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(354, '4413', 'Fournisseurs - retenues de garantie', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(355, '4415', 'Fournisseurs - effets à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(356, '4417', 'Fournisseurs - factures non parvenues', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(357, '4418', 'Autres fournisseurs et comptes rattachés', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(358, '442', 'Clients créditeurs, avances et acomptes', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(359, '4421', 'Clients - avances et acomptes reçus sur commandes en cours', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(360, '4425', 'Clients - dettes pour emballages et matériel consignés', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(361, '4427', 'Rabais, remises et ristournes à accorder - avoirs à établir', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(362, '4428', 'Autres clients créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(363, '443', 'Personnel - créditeur', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(364, '4432', 'Rémunérations dues au personnel', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(365, '4433', 'Dépôts du personnel créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(366, '4434', 'Oppositions sur salaires', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(367, '4437', 'Charges du personnel à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(368, '4438', 'Personnel - autres créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(369, '444', 'Organismes sociaux', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(370, '4441', 'Caisse Nationale de la Sécurité Sociale', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(371, '4443', 'Caisses de retraite', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(372, '4445', 'Mutuelles', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(373, '4447', 'Charges sociales à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(374, '4448', 'Autres organismes sociaux', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(375, '445', 'Etat - créditeur', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(376, '4452', 'Etat Impôts, taxes et assimilés', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(377, '44521', 'Etat, taxe urbaine et taxe d\'édilité', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(378, '44522', 'Etat, patente', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(379, '44525', 'Etat, IGR', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(380, '4453', 'Etat, impôts sur les résultats', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(381, '4455', 'Etat, TVA facturée', 4, 0.00, 100.00, '2025-05-18 15:52:57', '2025-05-27 15:22:28'),
(382, '4456', 'Etat, TVA due (suivant déclarations)', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(383, '4457', 'Etat, impôts et taxes à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(384, '4458', 'Etat - autres comptes créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(385, '446', 'Comptes d\'associés - créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(386, '4461', 'Associés - capital à rembourser', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(387, '4462', 'Associés - versements reçus sur augmentation de capital', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(388, '4463', 'Comptes courants des associés créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(389, '4464', 'Associés - opérations faites en commun', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(390, '4465', 'Associés - dividendes à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(391, '4468', 'Autres comptes d\'associés - créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(392, '448', 'Autres créanciers', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(393, '4481', 'Dettes sur acquisitions d\'immobilisations', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(394, '4483', 'Dettes sur acquisitions de titres et valeurs de placement', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(395, '4484', 'Obligations échues à rembourser', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(396, '4485', 'Obligations, coupons à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(397, '4487', 'Dettes rattachées aux autres créanciers', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(398, '4488', 'Divers créanciers', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(399, '449', 'Comptes de régularisation - passif', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(400, '4491', 'Produits constatés d\'avance', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(401, '4493', 'Intérêts courus et non échus à payer', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(402, '4495', 'Comptes de répartition périodique des produits', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(403, '4497', 'Comptes transitoires ou d\'attente - créditeurs', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(404, '45', 'AUTRES PROVISIONS POUR RISQUES ET CHARGES', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(405, '450', 'Autres provisions pour risques et charges', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(406, '4501', 'Provisions pour litiges', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(407, '4502', 'Provisions pour garanties données aux clients', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(408, '4505', 'Provisions pour amendes, doubles droits et pénalités', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(409, '4506', 'Provisions pour pertes de change', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(410, '4507', 'Provisions pour impôts', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(411, '4508', 'Autres provisions pour risques et charges', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(412, '47', 'ECARTS DE CONVERSION - PASSIF (Eléments circulants)', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(413, '470', 'Ecarts de conversion - passif (Eléments circulants)', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(414, '4701', 'Augmentation des créances circulantes', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(415, '4702', 'Diminution des dettes circulantes', 4, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(416, '51', 'TRESORERIE - ACTIF', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(417, '511', 'Chèques et valeurs à encaisser', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(418, '5111', 'Chèques à encaisser ou à l\'encaissement', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(419, '51111', 'Chèques en portefeuille', 5, 10000.00, 0.00, '2025-05-18 15:52:57', '2025-05-22 13:30:47'),
(420, '51112', 'Chèques à l\'encaissement', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(421, '5113', 'Effets à encaisser ou à l\'encaissement', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(422, '51131', 'Effets échus à encaisser', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(423, '51132', 'Effets à l\'encaissement', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(424, '5115', 'Virement de fonds', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(425, '5118', 'Autres valeurs à encaisser', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(426, '514', 'Banques, Trésorerie Générale et chèques postaux débiteurs', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(427, '5141', 'Banques (solde débiteur)', 5, 15000.00, 0.00, '2025-05-18 15:52:57', '2025-05-22 10:40:46'),
(428, '5143', 'Trésorerie Générale', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(429, '5146', 'Chèques postaux', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(430, '5148', 'Autres établissements financiers et assimilés (soldes débiteurs)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(431, '516', 'Caisses, règles d\'avances et accréditifs', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(432, '5161', 'Caisses', 5, 8000.00, 0.00, '2025-05-18 15:52:57', '2025-05-22 10:41:15'),
(433, '51611', 'Caisse Centrale', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(434, '51613', 'Caisse (succursale ou agence A)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(435, '51614', 'Caisse (succursale ou agence B)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(436, '5165', 'Règles d\'avances et accréditifs', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(437, '55', 'TRESORERIE - PASSIF', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(438, '552', 'Crédits d\'escompte', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(439, '5520', 'Crédits d\'escompte', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(440, '553', 'Crédits de trésorerie', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(441, '5530', 'Crédits de trésorerie', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(442, '554', 'Banques (solde créditeur)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(443, '5541', 'Banques (solde créditeur)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(444, '5548', 'Autres établissements financiers et assimilés (soldes créditeurs)', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57');
INSERT INTO `comptes` (`id`, `numero_compte`, `nom_compte`, `class_id`, `montant_debit`, `montant_credit`, `created_at`, `updated_at`) VALUES
(445, '59', 'PROVISIONS POUR DEPRECIATION DES COMPTES DE TRESORERIE', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(446, '590', 'Provisions pour dépréciation des comptes de trésorerie', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(447, '5900', 'Provisions pour dépréciation des comptes de trésorerie', 5, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(448, '61', 'CHARGES D\'EXPLOITATION', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(449, '611', 'Achats revendus de marchandises', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(450, '6111', 'Achats de marchandises \"groupe A\"', 6, 0.00, 3000.00, '2025-05-18 15:52:57', '2025-05-18 20:15:06'),
(451, '6112', 'Achats de marchandises \"groupe B\"', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(452, '6114', 'Variation de stocks de marchandises', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(453, '6118', 'Achats revendus de marchandises des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(454, '6119', 'Rabais, remises et ristournes obtenus sur achats de marchandises', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(455, '612', 'Achats consommés de matières et fournitures', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(456, '6121', 'Achats de matières premières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(457, '61211', 'Achats de matières premières A', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(458, '61212', 'Achats de matières premières B', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(459, '6122', 'Achats de matières et fournitures consommables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(460, '61221', 'Achats de matières et fournitures A', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(461, '61222', 'Achats de matières et fournitures B', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(462, '61223', 'Achats de combustibles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(463, '61224', 'Achats de produits d\'entretien', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(464, '61225', 'Achats de fournitures d\'atelier et d\'usine', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(465, '61226', 'Achats de fournitures de magasin', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(466, '61227', 'Achats de fournitures de bureau', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(467, '6123', 'Achats d\'emballages', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(468, '61231', 'Achats d\'emballages perdus', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(469, '61232', 'Achats d\'emballages récupérables non identifiables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(470, '61233', 'Achats d\'emballages à usage mixte', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(471, '6124', 'Variation des stocks de matières et fournitures', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(472, '61241', 'Variation des stocks de matières premières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(473, '61242', 'Variation des stocks de matières et fournitures consommables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(474, '61243', 'Variation des stocks des emballages', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(475, '6125', 'Achats non stockés de matières et fournitures', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(476, '61251', 'Achats de fournitures non stockables (eau, électricité,,)', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(477, '61252', 'Achats de fournitures d\'entretien', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(478, '61253', 'Achats de petit outillage et petit équipement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(479, '61254', 'Achats de fournitures de bureau', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(480, '6126', 'Achats de travaux, études et prestations de service', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(481, '61261', 'Achats des travaux', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(482, '61262', 'Achats des études', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(483, '61263', 'Achats des prestations de service', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(484, '6128', 'Achats de matières et de fournitures des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(485, '6129', 'Rabais, remises et ristournes obtenus sur achats consommés de matières et fournitures', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(486, '61291', 'Rabais, remises et ristournes obtenus sur achats de matières premières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(487, '61292', 'Rabais, remises et ristournes obtenus sur achats de matières et fournitures consommables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(488, '61293', 'Rabais, remises et ristournes obtenus sur achats des emballages', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(489, '61295', 'Rabais, remises et ristournes obtenus sur achats non stockés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(490, '61296', 'Rabais, remises et ristournes obtenus sur achats de travaux, études et prestations de service', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(491, '61298', 'Rabais, remises et ristournes obtenus sur achats de matières et fournitures des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(492, '613', 'Autres charges externes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(493, '6131', 'Locations et charges locatives', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(494, '61311', 'Locations de terrains', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(495, '61312', 'Locations de constructions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(496, '61313', 'Locations de matériel et d\'outillage', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(497, '61314', 'Locations de mobilier et de matériel de bureau', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(498, '61315', 'Locations de matériel informatique', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(499, '61316', 'Locations de matériel de transport', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(500, '61317', 'Mails sur emballages rendus', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(501, '61318', 'Locations et charges locatives diverses', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(502, '6132', 'Redevances de crédit-bail', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(503, '61321', 'Redevances de crédit-bail - mobilier et matériel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(504, '6133', 'Entretien et réparations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(505, '61331', 'Entretien et réparations des biens immobiliers', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(506, '61332', 'Entretien et réparations des biens mobiliers', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(507, '61335', 'Maintenance', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(508, '6134', 'Primes d\'assurances', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(509, '61341', 'Assurances multirisque (vol, incendie,R,C,)', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(510, '61343', 'Assurances - risques d\'exploitation', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(511, '61345', 'Assurances - Matériel de transport', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(512, '61348', 'Autres assurances', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(513, '6135', 'Rémunérations du personnel extérieur à l\'entreprise', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(514, '61351', 'Rémunérations du personnel occasionnel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(515, '61352', 'Rémunérations du personnel intérimaire', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(516, '61353', 'Rémunérations du personnel détaché ou prêté à l\'entreprise', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(517, '6136', 'Rémunérations d\'intermédiaires et honoraires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(518, '61361', 'Commissions et courtages', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(519, '61365', 'Honoraires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(520, '61367', 'Frais d\'actes et de contentieux', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(521, '6137', 'Redevances pour brevets, marques, droits et valeurs similaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(522, '61371', 'Redevances pour brevets', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(523, '61378', 'Autres redevances', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(524, '6141', 'Etudes, recherches et documentation', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(525, '61411', 'Etudes générales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(526, '61413', 'Recherches', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(527, '61415', 'Documentation générale', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(528, '61416', 'Documentation technique', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(529, '6142', 'Transports', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(530, '61421', 'Transports du personnel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(531, '61425', 'Transports sur achats', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(532, '61426', 'Transports sur ventes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(533, '61428', 'Autres transports', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(534, '6143', 'Déplacements, missions et réceptions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(535, '61431', 'Voyages et déplacements', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(536, '61433', 'Frais de déménagement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(537, '61435', 'Missions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(538, '61436', 'Réceptions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(539, '6144', 'Publicité, publications et relations publiques', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(540, '61441', 'Annonces et insertions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(541, '61442', 'Echantillons, catalogues et imprimés publicitaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(542, '61443', 'Foires et expositions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(543, '61444', 'Primes de publicité', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(544, '61446', 'Publications', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(545, '61447', 'Cadeaux à la clientèle', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(546, '61448', 'Autres charges de publicité et relations publiques', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(547, '6145', 'Frais postaux et frais de télécommunications', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(548, '61451', 'Frais postaux', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(549, '61455', 'Frais de téléphone', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(550, '61456', 'Frais de télex et de télégrammes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(551, '6146', 'Cotisations et dons', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(552, '61461', 'Cotisations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(553, '61462', 'Dons', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(554, '6147', 'Services bancaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(555, '61471', 'Frais d\'achat et de vente des titres', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(556, '61472', 'Frais sur effets de commerce', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(557, '61473', 'Frais et commissions sur services bancaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(558, '6148', 'Autres charges externes des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(559, '6149', 'Rabais, remises et ristournes obtenus sur autres charges externes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(560, '616', 'Impôts et taxes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(561, '6161', 'Impôts et taxes directs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(562, '61611', 'Taxe urbaine et taxe d\'édilité', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(563, '61612', 'Patente', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(564, '61615', 'Taxes locales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(565, '6165', 'Impôts et taxes directs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(566, '6167', 'Impôts, taxes et droits assimilés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(567, '61671', 'Droits d\'enregistrement et de timbre', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(568, '61673', 'Taxes sur les véhicules', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(569, '61678', 'Autres impôts, taxes et droits assimilés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(570, '6168', 'Impôts et taxes des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(571, '617', 'Charges de personnel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(572, '6171', 'Rémunérations du personnel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(573, '61711', 'Appointements et salaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(574, '61712', 'Primes et gratifications', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(575, '61713', 'Indemnités et avantages divers', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(576, '61714', 'Commissions au personnel', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(577, '61715', 'Rémunérations des administrateurs, gérants et associés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(578, '6174', 'Charges sociales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(579, '61741', 'Cotisations de sécurité sociale', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(580, '61742', 'Cotisations aux caisses de retraite', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(581, '61743', 'Cotisations aux mutuelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(582, '61744', 'Prestations familiales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(583, '61745', 'Assurances accidents de travail', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(584, '6176', 'Charges sociales diverses', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(585, '61761', 'Assurances groupe', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(586, '61762', 'Prestations de retraites', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(587, '61763', 'Allocations aux œuvres sociales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(588, '61764', 'Habillement et vêtements de travail', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(589, '61765', 'Indemnités de préavis et de licenciement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(590, '61766', 'Médecine de travail, pharmacie', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(591, '61768', 'Autres charges sociales diverses', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(592, '6177', 'Rémunération de l\'exploitant', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(593, '61771', 'Appointements et salaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(594, '61774', 'Charges sociales sur appointements et salaires de l\'exploitant', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(595, '6178', 'Charges du personnel des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(596, '618', 'Autres charges d\'exploitation', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(597, '6181', 'Jetons de présence', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(598, '6182', 'Pertes sur créances irrécouvrables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(599, '6185', 'Pertes sur opérations faites en commun', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(600, '6186', 'Transfert de profits sur opérations faites en commun', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(601, '6188', 'Autres charges d\'exploitation des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(602, '619', 'Dotations d\'exploitation', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(603, '6191', 'Dotations d\'exploitation aux amortissements de l\'immobilisation en non valeur', 6, 100000.00, 0.00, '2025-05-18 15:52:57', '2025-05-21 23:06:48'),
(604, '61911', 'D.E.A. des frais préliminaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(605, '61912', 'D.E.A. des charges à répartir', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(606, '6192', 'Dotations d\'exploitation aux amortissements des immobilisations incorporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(607, '61921', 'D.E.A. de l\'immobilisation en recherche et développement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(608, '61922', 'D.E.A. des brevets, marques, droits et valeurs similaires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(609, '61923', 'D.E.A. du fonds commercial', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(610, '61928', 'D.E.A. des autres immobilisations incorporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(611, '6193', 'Dotations d\'exploitation aux amortissements des immobilisations corporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(612, '61931', 'D.E.A. des terrains', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(613, '61932', 'D.E.A. des constructions', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(614, '61933', 'D.E.A. des installations techniques, matériel et outillage', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(615, '61934', 'D.E.A. du matériel de transport', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(616, '61935', 'D.E.A. des mobiliers, matériels de bureau et aménagements divers', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(617, '61938', 'D.E.A. des autres immobilisations corporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(618, '6194', 'Dotations d\'exploitation aux provisions pour dépréciation des immobilisations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(619, '61942', 'D.E.P. pour dépréciation des immobilisations incorporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(620, '61943', 'D.E.P. pour dépréciation des immobilisations corporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(621, '6195', 'Dotations d\'exploitation aux provisions pour risques et charges', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(622, '61955', 'D.E.P. pour risques et charges durables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(623, '61957', 'D.E.P. pour risques et charges momentanés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(624, '6196', 'Dotations d\'exploitation aux provisions pour dépréciations de l\'actif circulant', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(625, '61961', 'D.E.P. pour dépréciation des stocks', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(626, '61964', 'D.E.P. pour dépréciation des créances de l\'actif circulant', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(627, '6198', 'Dotations d\'exploitation des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(628, '61981', 'D.E. aux amortissements des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(629, '61984', 'D.E. aux provisions des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(630, '63', 'CHARGES FINANCIERES', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(631, '631', 'Charges d\'intérêts', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(632, '6311', 'Intérêts des emprunts et dettes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(633, '63111', 'Intérêts des emprunts', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(634, '63113', 'Intérêts des dettes rattachées à des participations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(635, '63114', 'Intérêts des comptes courants et dépôts créditeurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(636, '63115', 'Intérêts bancaires et sur opérations de financement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(637, '63118', 'Autres intérêts des emprunts et dettes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(638, '6318', 'Charges d\'intérêts des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(639, '633', 'Pertes de change', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(640, '6331', 'Pertes de change propres à l\'exercice', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(641, '6338', 'Pertes de change des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(642, '638', 'Autres charges financières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(643, '6382', 'Pertes sur créances liées à des participations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(644, '6385', 'Charges nettes sur cession de titres et valeurs de placement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(645, '6386', 'Escomptes accordés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(646, '6388', 'Autres charges financières des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(647, '639', 'Dotations financières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(648, '6391', 'Dotations aux amortissements des primes de remboursement des obligations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(649, '6392', 'Dotations aux provisions pour dépréciations des immobilisations financières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(650, '6393', 'Dotations aux provisions pour risques et charges financières', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(651, '6394', 'Dotation aux provisions pour dépréciation des titres et valeurs de placement', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(652, '9396', 'Dotations aux provisions pour dépréciation des compte de trésorerie', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(653, '6398', 'Dotations financières des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(654, '65', 'CHARGES NON COURANTES', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(655, '651', 'Valeurs nettes d\'amortissements des immobilisations cédées ( V.N.A )', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(656, '6512', 'VNA des immobilisations incorporelles cédées', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(657, '6513', 'VNA des immobilisations corporelles cédées', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(658, '6514', 'VNA provisions des immobilisations financières cédées (droits de propriété)', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(659, '6518', 'VNA des immobilisations cédées des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(660, '656', 'Subventions accordées', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(661, '6561', 'Subventions accordées de l\'exercice', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(662, '6568', 'Subventions accordées des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(663, '658', 'Autres charges non courantes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(664, '6581', 'Pénalités sur marchés et dédits', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(665, '65811', 'Pénalités sur marchés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(666, '65812', 'Dédits', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(667, '6582', 'Rappels d\'impôts (autres qu\'impôts sur les résultats)', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(668, '6583', 'Pénalités et amendes fiscales ou pénales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(669, '65831', 'Pénalités et amendes fiscales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(670, '65833', 'Pénalités et amendes pénales', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(671, '6585', 'Créances devenues irrécouvrables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(672, '6586', 'Dons, libéralités et lots', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(673, '65861', 'Dons', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(674, '65862', 'Libéralités', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(675, '65863', 'Lots', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(676, '6588', 'Autres charges non courantes des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(677, '659', 'Dotations non courantes', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(678, '6591', 'Dotations aux amortissements exceptionnels des immobilisations', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(679, '65911', 'D.A.E. de l\'immobilisation en non-valeurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(680, '65912', 'D.A.E. des immobilisations incorporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(681, '65913', 'D.A.E. des immobilisations corporelles', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(682, '6594', 'Dotations non courantes aux provisions réglementées', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(683, '65941', 'D.N.C. pour amortissements dérogatoires', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(684, '65942', 'D.N.C. pour plus-values en instance d\'imposition', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(685, '65944', 'D.N.C. pour investissements', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(686, '65945', 'D.N.C. pour reconstitution de gisements', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(687, '65946', 'D.N.C. pour acquisition et construction de logements', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(688, '6595', 'Dotations non courantes aux provisions pour risques et charges', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(689, '65955', 'D.N.C. aux provisions pour risques et charges durables', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(690, '65957', 'D.N.C. aux provisions pour risques et charges momentanés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(691, '6596', 'Dotations non courantes aux provisions pour dépréciation', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(692, '65962', 'D.N.C. aux provisions pour dépréciation de l\'actif immobilisé', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(693, '65963', 'D.N.C. aux provisions pour dépréciation de l\'actif circulant', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(694, '6598', 'Dotations non courantes des exercices antérieurs', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(695, '67', 'IMPOTS SUR LES RESULTATS', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(696, '670', 'Impôts sur les résultats', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(697, '6701', 'Impôts sur les bénéfices', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(698, '6705', 'Imposition minimale annuelle des sociétés', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(699, '6708', 'Rappels et dégrèvements d\'impôts sur les résultats', 6, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(700, '71', 'PRODUITS D\'EXPLOITATION', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(701, '711', 'Ventes de marchandises', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(702, '7111', 'Ventes de marchandises au Maroc', 7, 0.00, 1900.00, '2025-05-18 15:52:57', '2025-05-27 15:22:28'),
(703, '7113', 'Ventes de marchandises à l\'étranger', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(704, '7118', 'Ventes de marchandises des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(705, '7119', 'Rabais, remises et ristournes accordés par l\'entreprise', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(706, '712', 'Ventes de biens et services produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(707, '7121', 'Ventes de biens produits au Maroc', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(708, '71211', 'Ventes de produits finis', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(709, '71212', 'Ventes de produits intermédiaires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(710, '71217', 'Ventes de produits résiduels', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(711, '7122', 'Ventes de biens produits à l\'étranger', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(712, '71221', 'Ventes de produits finis', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(713, '71222', 'Ventes de produits intermédiaires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(714, '71224', 'Ventes de services produits au Maroc', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(715, '71241', 'Travaux', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(716, '71242', 'Etudes', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(717, '71243', 'Prestations de services', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(718, '7125', 'Ventes de services produits à l\'étranger', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(719, '71251', 'Travaux', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(720, '71252', 'Etudes', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(721, '71253', 'Prestations de services', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(722, '7126', 'Redevances pour brevets, marques, droits et valeurs similaires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(723, '7127', 'Ventes de produits accessoires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(724, '71271', 'Locations diverses reçues', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(725, '71272', 'Commissions et courtages reçus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(726, '71273', 'Produits de services exploités dans l\'intérêt du personnel', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(727, '71275', 'Bonis sur reprises d\'emballages consignés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(728, '71276', 'Ports et frais accessoires facturés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(729, '71278', 'Autres ventes et produits accessoires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(730, '7128', 'Ventes de biens et services produits des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(731, '7129', 'Rabais, remises et ristournes accordés par l\'entreprise', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(732, '71291', 'R,R,R accordées sur ventes au Maroc des biens produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(733, '71292', 'R,R,R accordées sur ventes à l\'étranger des biens produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(734, '71294', 'R,R,R accordées sur ventes au Maroc des services produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(735, '71295', 'R,R,R accordées sur ventes à l\'étranger des services produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(736, '71298', 'Rabais, remises et ristournes accordés sur ventes de B & S produits des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(737, '713', 'Variation des stocks de produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(738, '7131', 'Variation des stocks de produits en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(739, '71311', 'Variation des stocks de biens produits en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(740, '71312', 'Variation des stocks de produits intermédiaires en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(741, '71317', 'Variation des stocks de produits résiduels en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(742, '7132', 'Variation des stocks de biens produits', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(743, '71321', 'Variation des stocks de produits finis', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(744, '71322', 'Variation des stocks de produits intermédiaires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(745, '71327', 'Variation des stocks de produits résiduels', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(746, '7134', 'Variation des stocks de services en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(747, '71341', 'Variation des stocks de travaux en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(748, '71342', 'Variation des stocks d\'études en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(749, '71343', 'Variation des stocks de prestations en cours', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(750, '714', 'Immobilisations produites par l\'entreprise pour elle même', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(751, '7141', 'Immobilisation en non valeurs produite', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(752, '7142', 'Immobilisations incorporelles produites', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(753, '7143', 'Immobilisations corporelles produites', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(754, '7148', 'Immobilisations produites des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(755, '716', 'Subventions d\'exploitation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(756, '7161', 'Subventions d\'exploitations reçues de l\'exercice', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(757, '7168', 'Subventions d\'exploitation reçues des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(758, '718', 'Autres produits d\'exploitation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(759, '7181', 'Jetons de présence reçus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(760, '7182', 'Revenus des immeubles non affectés à l\'exploitation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(761, '7185', 'Profits sur opérations faites en commun', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(762, '7186', 'Transfert de pertes sur opérations faites en commun', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(763, '7188', 'Autres produits d\'exploitation des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(764, '719', 'Reprise d\'exploitation, transferts de charges', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(765, '7191', 'Reprises sur amortissements de l\'immobilisation en non valeurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(766, '7192', 'Reprises sur amortissements des immobilisations incorporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(767, '7193', 'Reprises sur amortissements des immobilisations corporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(768, '7194', 'Reprises sur provisions pour dépréciation des immobilisations', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(769, '7195', 'Reprises sur provisions pour risques et charges', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(770, '7196', 'Reprises sur provisions pour dépréciation de l\'actif circulant', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(771, '7197', 'Transferts des charges d\'exploitation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(772, '71971', 'T,C,E - Achats de marchandises', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(773, '71972', 'T,C,E - Achats consommés de matières et fournitures', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(774, '71973', 'T,C,E - Autes charges externes', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(775, '71975', 'T,C,E - Impôts et taxes', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(776, '71976', 'T,C,E - Charges de personnel', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(777, '71978', 'T,C,E - Autres charges d\'exploitation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(778, '7198', 'Reprises sur amortissements et provisions des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(779, '71981', 'Reprises sur amortissements des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(780, '71984', 'Reprises sur provisions des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(781, '73', 'PRODUITS FINANCIERS', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(782, '732', 'Produits des titres de participation et des autres titres immobilisés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(783, '7321', 'Revenus des titres de participation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(784, '7325', 'Revenus des titres immobilisés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(785, '7328', 'Produits des titres de participation et des autres titres immobilisés des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(786, '733', 'Gains de change', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(787, '7331', 'Gains de change propres à l\'exercice', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(788, '7338', 'Gains de change des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(789, '738', 'Intérêts et autres produits financiers', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(790, '7381', 'Intérêts et produits assimilés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(791, '73811', 'Intérêts des prêts', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(792, '73813', 'Revenus des autres créances financières', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(793, '7383', 'Revenus des créances rattachées à des participations', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(794, '7384', 'Revenus des titres et valeurs de placement', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(795, '7385', 'Produits nets sur cessions de titres et valeurs de placement', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(796, '7386', 'Escomptes obtenus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(797, '7388', 'Intérêts et autres produits financiers des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(798, '739', 'Reprises financières, transferts de charges', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(799, '7391', 'Reprises sur amortissements des primes de remboursement des obligations', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(800, '7392', 'Reprises sur provisions pour dépréciation des immobilisations financières', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(801, '7393', 'Reprises sur provisions pour risques et charges financières', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(802, '7394', 'Reprise sur provisions pour dépréciation des titres et valeurs de placement', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(803, '7396', 'Reprises sur provisions pour dépréciation des comptes de trésorerie', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(804, '7397', 'Transfert de charges financières', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(805, '73971', 'Transfert - Charges d\'intérêts', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(806, '73973', 'Transfert - Pertes de change', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(807, '73978', 'Transfert - Autres charges financières', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(808, '7398', 'Reprises sur dotations financières des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(809, '75', 'PRODUITS NON COURANTS', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(810, '751', 'Produits des cessions d\'immobilisations', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(811, '7512', 'Produits des cessions des immobilisations incorporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(812, '7513', 'Produits des cessions des immobilisations corporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(813, '7514', 'Produits des cessions des immobilisations financières (droits de propriété)', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(814, '7518', 'Produits des cessions des immobilisations des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(815, '756', 'Subventions d\'équilibre', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(816, '7561', 'Subventions d\'équilibre reçues de l\'exercice', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(817, '7568', 'Subventions d\'équilibre reçues des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(818, '757', 'Reprise sur subventions d\'investissements', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(819, '7577', 'Reprises sur subventions d\'investissement de l\'exercice', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(820, '7578', 'Reprises sur subventions d\'investissement des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(821, '758', 'Autres produits non courants', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(822, '7581', 'Pénalités et dédits reçus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(823, '75811', 'Pénalités reçues sur marchés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(824, '75812', 'Dédits reçus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(825, '7582', 'Dégrèvement d\'impôts (autres qu\'impôts sur les résultats)', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(826, '7585', 'Rentrées sur créances soldées', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(827, '7586', 'Dons, libéralités et lots reçus', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(828, '75861', 'Dons', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(829, '75862', 'Libéralités', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(830, '75863', 'Lots', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(831, '7588', 'Autres produits non courants des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(832, '7591', 'Reprises non courantes sur amortissements exceptionnels des immobilisations', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(833, '75911', 'R.A.E de l\'immobilisation en non valeurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(834, '75912', 'R.A.E des immobilisations incorporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(835, '75913', 'R.A.E des immobilisations corporelles', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(836, '7594', 'Reprises non courantes sur provisions réglementées', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(837, '75941', 'Reprises sur amortissements dérogatoires', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(838, '75942', 'Reprises sur plus-values en instance d\'imposition', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(839, '75944', 'Reprises sur provisions pour investissements', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(840, '75945', 'Reprises sur provisions pour reconstitution de gisements', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(841, '75946', 'Reprises sur provisions pour acquisition et construction de logements', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(842, '7595', 'Reprises non courantes sur provisions pour risques et charges', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(843, '75955', 'Reprises sur provisions pour risques et charges durables', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(844, '75957', 'Reprises sur provisions pour risques et charges momentanés', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(845, '7596', 'Reprises non courantes sur provisions pour dépréciation', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(846, '75962', 'R.N.C sur provisions pour dépréciation de l\'actif immobilisé', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(847, '75963', 'R.N.C sur provisions pour dépréciation de l\'actif circulant', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(848, '7597', 'Transferts de charges non courantes', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(849, '7598', 'Reprises non courantes des exercices antérieurs', 7, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(850, '81', 'RESULTAT D\'EXPLOITATION', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(851, '810', 'Résultat d\'exploitation', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(852, '8100', 'Résultat d\'exploitation', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(853, '811', 'Marge brute', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(854, '8110', 'Marge brute', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(855, '814', 'Valeur ajoutée', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(856, '8140', 'Valeur ajoutée', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(857, '817', 'Excédent brut d\'exploitation', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(858, '8171', 'Excédent brut d\'exploitation (créditeur)', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(859, '8179', 'Insuffisance brute d\'exploitation (déditeur)', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(860, '83', 'RESULTAT FINANCIER', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(861, '830', 'Résultat financier', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(862, '8300', 'Résultat financier', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(863, '84', 'RESULTAT COURANT', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(864, '840', 'Résultat courant', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(865, '8400', 'Résultat courant', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(866, '85', 'RESULTAT NON COURANT', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(867, '850', 'Résultat non courant', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(868, '8500', 'Résultat non courant', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(869, '86', 'RESULTAT AVANT IMPOTS', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57');
INSERT INTO `comptes` (`id`, `numero_compte`, `nom_compte`, `class_id`, `montant_debit`, `montant_credit`, `created_at`, `updated_at`) VALUES
(870, '860', 'Résultat avant impôts', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(871, '8600', 'Résultat avant impôts', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(872, '88', 'RESULTAT APRES IMPOTS', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(873, '880', 'Résultat après impôts', 8, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(874, '8800', 'Résultat après impôts', 8, 3000.00, 0.00, '2025-05-18 15:52:57', '2025-05-22 10:41:45'),
(875, '90', 'COMPTES DE PRODUITS ET CHARGES REFLECHIS', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(876, '903', 'Stocks et provisions pour dépréciation des stocks réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(877, '9031', 'Stocks réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(878, '9039', 'Provisions pour dépréciation des stocks réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(879, '906', 'Charges réfléchies', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(880, '9061', 'Charges d\'exploitation réfléchies', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(881, '9063', 'Charges financières réfléchies', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(882, '9065', 'Charges non courantes réfléchies', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(883, '9067', 'Impôts sur les résultats réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(884, '907', 'Produits réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(885, '9071', 'produits d\'exploitation réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(886, '9073', 'Produits financiers réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(887, '9075', 'Produits non courants réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(888, '908', 'Résultats réfléchis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(889, '9081', 'Résultat d\'exploitation réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(890, '9083', 'Résultat financier réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(891, '9084', 'Résultat courant réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(892, '9085', 'Résultat non courant réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(893, '9086', 'Résultat avant impôts réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(894, '9088', 'Résultat après impôts réfléchi', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(895, '91', 'COMPTES DE REclass_idMENT ET D\'ANALYSE', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(896, '92', 'SECTIONS ANALYTIQUES', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(897, '921', 'Sections générales', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(898, '9211', 'Section A', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(899, '9212', 'Section B', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(900, '923', 'Sections d\'approvisionnement', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(901, '9231', 'Section A', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(902, '9232', 'Section B', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(903, '925', 'Sections de production', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(904, '9251', 'Section A', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(905, '9252', 'Section B', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(906, '927', 'Section de distribution', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(907, '9271', 'Section A', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(908, '9272', 'Section B', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(909, '928', 'Autres sections analytiques', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(910, '9281', 'Section A', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(911, '9282', 'Section B', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(912, '93', 'COUTS D\'ACHAT OU DE PRODUCTION', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(913, '933', 'Coûts d\'achat', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(914, '9331', 'Coût d\'achat de marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(915, '9335', 'Coûts d\'achat de matière et de fournitures', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(916, '935', 'Coûts de production', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(917, '9351', 'Coûts de production des produits (groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(918, '9352', 'Coûts de production des produits ( groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(919, '938', 'Autres coûts d\'achat ou de production', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(920, '9381', 'Coûts de production des immobilisations', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(921, '94', 'INVENTAIRE PERMANENT DES STOCKS', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(922, '941', 'Inventaire permanent des marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(923, '9411', 'Marchandises (groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(924, '9412', 'Marchandises (groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(925, '9416', 'Marchandises en cours de route', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(926, '9418', 'Autres marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(927, '942', 'Inventaire permanent des matières et fournitures consommables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(928, '9421', 'Matières premières', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(929, '9422', 'Matières et fournitures consommables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(930, '9423', 'Emballages', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(931, '9426', 'Matières et fournitures consommables en cours de route', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(932, '9428', 'Autres matières et fournitures consommables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(933, '943', 'Inventaire permanent des produits en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(934, '9431', 'Biens en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(935, '9434', 'Services en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(936, '9438', 'Autres produits en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(937, '944', 'Inventaire permanent des produits intermédiaires et produits résiduels', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(938, '9441', 'Produits intermédiaires', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(939, '9445', 'Produits résiduels', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(940, '9448', 'Autres produits intermédiaires et produits résiduels', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(941, '945', 'Inventaire permanent des produits finis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(942, '9451', 'Produits finis (groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(943, '9452', 'Produits finis (groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(944, '9456', 'Produits finis en cours de route', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(945, '9458', 'Autres produits finis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(946, '949', 'Provisions sur dépréciation des stocks', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(947, '9491', 'Provisions pour dépréciation des marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(948, '9492', 'Provisions pour dépréciation des matières et fournitures consommables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(949, '9493', 'Provisions pour dépréciation des produits en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(950, '9494', 'Provisions pour dépréciation des produits intermédiaires et produits résiduels', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(951, '9495', 'Provisions pour dépréciation des produits finis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(952, '95', 'COUTS DE REVIENT', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(953, '953', 'Coûts de revient des marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(954, '9531', 'Coûts de revient des marchandises (groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(955, '9532', 'Coûts de revient des marchandises (groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(956, '955', 'Coûts de revient des produits', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(957, '9551', 'Coûts de revient des produits (groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(958, '9552', 'Coûts de revient des produits (groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(959, '958', 'Autres coûts de revient', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(960, '9581', 'Coûts de revient ( groupe A)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(961, '9582', 'Coûts de revient ( groupe B)', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(962, '96', 'ECARTS SUR COUTS PRÉETABLIS', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(963, '962', 'Ecarts sur sections', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(964, '9621', 'Ecarts sur quantités', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(965, '9622', 'Ecarts sur coûts', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(966, '964', 'Ecarts sur inventaire permanent des stocks', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(967, '9641', 'Ecarts sur quantités', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(968, '9642', 'Ecarts sur coûts', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(969, '97', 'DIFFERENCE D\'INCORPORATION', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(970, '971', 'Charges non incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(971, '9710', 'Charges non incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(972, '972', 'Charges supplétives incorporées', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(973, '9720', 'Charges supplétives incorporées', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(974, '973', 'Produits non incorporés', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(975, '9730', 'Produits non incorporés', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(976, '974', 'Différences sur charges incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(977, '9740', 'Différences sur charges incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(978, '975', 'Différences sur produits incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(979, '9750', 'Différences sur produits incorporables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(980, '976', 'Différences d\'inventaire', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(981, '9761', 'Différences d\'inventaire sur marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(982, '9762', 'Différences d\'inventaire sur matières et fournitures consommables', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(983, '9763', 'Différences d\'inventaire sur produits en cours', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(984, '9764', 'Différences d\'inventaire sur produits intermédiaires et produits résiduels', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(985, '9765', 'Différences d\'inventaire sur produits finis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(986, '977', 'Différences sur niveau d\'activité', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(987, '9770', 'Différences sur niveau d\'activité', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(988, '978', 'Autres différences d\'incorporation', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(989, '9780', 'Autres différences d\'incorporation', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(990, '98', 'RESULTATS ANALYTIQUES', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(991, '981', 'Résultats analytiques sur marchandises', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(992, '9811', 'Résultats analytiques sur marchandises ( groupe A )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(993, '9812', 'Résultats analytiques sur marchandises ( groupe B )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(994, '982', 'Résultats analytiques sur biens produits', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(995, '9821', 'Résultats analytiques sur biens produits ( groupe A )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(996, '9822', 'Résultats analytiques sur biens produits ( groupe B )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(997, '983', 'Résultats analytiques sur services produits', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(998, '9831', 'Résultats analytiques sur services produits ( groupe A )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(999, '9832', 'Résultats analytiques sur services produits ( groupe B )', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1000, '986', 'Reports des écarts sur coûts préétablis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1001, '9860', 'Reports des écarts sur coûts préétablis', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1002, '987', 'Reports des différences d\'incorporation', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1003, '9870', 'Reports des différences d\'incorporation', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1004, '99', 'COMPTES DE LIAISON INTERNE', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1005, '991', 'Liaisons internes propres a un même établissement', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1006, '9910', 'Liaisons internes propres a un même établissement', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1007, '995', 'Cessions à d\'autres établissements', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1008, '9951', 'Cessions fournies à d\'autres établissements', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57'),
(1009, '9955', 'Cessions reçues d\'autres établissements', 9, 0.00, 0.00, '2025-05-18 15:52:57', '2025-05-18 15:52:57');

-- --------------------------------------------------------

--
-- Structure de la table `entreprise`
--

CREATE TABLE `entreprise` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `age_annee` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `entreprise`
--

INSERT INTO `entreprise` (`id`, `nom`, `age_annee`) VALUES
(4, 'accounext', 5);

-- --------------------------------------------------------

--
-- Structure de la table `entries`
--

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `journal_entry_id` varchar(36) DEFAULT NULL,
  `compteNum` varchar(50) NOT NULL,
  `compteNom` varchar(255) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `type` enum('debit','credit') NOT NULL,
  `date_operation` date NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `justification` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `entries`
--

INSERT INTO `entries` (`id`, `journal_entry_id`, `compteNum`, `compteNom`, `montant`, `type`, `date_operation`, `libelle`, `justification`, `created_at`) VALUES
(1, NULL, '12', '12', 12.00, 'debit', '2025-05-15', 'test', 'uploads/justifications/justif_68265ccf83ac9.jpg', '2025-05-15 21:29:51'),
(2, NULL, '12', '12', 12.00, 'credit', '2025-05-15', 'test', 'uploads/justifications/justif_68265ccf83ac9.jpg', '2025-05-15 21:29:51'),
(3, NULL, '6111', 'achat de marchendise', 6000.00, 'debit', '2025-05-16', 'achat test', 'uploads/justifications/justif_682752c4709f4.png', '2025-05-16 14:59:16'),
(4, NULL, '6113', 'achat de produits', 3000.00, 'debit', '2025-05-16', 'achat test', 'uploads/justifications/justif_682752c4709f4.png', '2025-05-16 14:59:16'),
(5, NULL, '5141', 'banque', 9000.00, 'credit', '2025-05-16', 'achat test', 'uploads/justifications/justif_682752c4709f4.png', '2025-05-16 14:59:16'),
(6, 'cbc91425-bfa3-435d-8ae0-7e0ccc0be185', '12', 'test compte', 2343.00, 'debit', '2025-05-16', 'test', 'uploads/justifications/justif_6827631c67969.jpg', '2025-05-16 16:09:00'),
(7, 'cbc91425-bfa3-435d-8ae0-7e0ccc0be185', '6113', 'test compte2', 2343.00, 'credit', '2025-05-16', 'test', 'uploads/justifications/justif_6827631c67969.jpg', '2025-05-16 16:09:00'),
(8, 'c5b24f3f-49a9-4022-ab85-54f7fcc37015', '12', 'test compte', 23432.00, 'debit', '2025-05-16', 'yr', NULL, '2025-05-16 16:10:22'),
(9, 'c5b24f3f-49a9-4022-ab85-54f7fcc37015', '6113', 'fdsgsgsg', 23432.00, 'credit', '2025-05-16', 'yr', NULL, '2025-05-16 16:10:22'),
(10, '6a291aba-ca60-4c5a-bb56-0b5737a8f89c', '6112', 'compte n2', 5000.00, 'debit', '2025-05-17', 'achat de voiture', NULL, '2025-05-17 21:14:28'),
(11, '6a291aba-ca60-4c5a-bb56-0b5737a8f89c', '5100', 'compte n3', 2500.00, 'credit', '2025-05-17', 'achat de voiture', NULL, '2025-05-17 21:14:28'),
(12, '6a291aba-ca60-4c5a-bb56-0b5737a8f89c', '7000', 'compte n4', 2500.00, 'credit', '2025-05-17', 'achat de voiture', NULL, '2025-05-17 21:14:28'),
(13, 'ef7d0f6a-8eaf-4a2f-89fc-5c25be1c5bf5', '1111', 'Capital social', 3000.00, 'debit', '2025-05-18', 'test', NULL, '2025-05-18 20:15:06'),
(14, 'ef7d0f6a-8eaf-4a2f-89fc-5c25be1c5bf5', '6111', 'Achats de marchandises \"groupe A\"', 3000.00, 'credit', '2025-05-18', 'test', NULL, '2025-05-18 20:15:06'),
(15, 'ec3f7849-a30f-4c82-8313-6eaf44d80b77', '2441', 'Prêts au personnel', 1233.00, 'debit', '2025-05-18', 'test', NULL, '2025-05-18 20:27:51'),
(16, 'ec3f7849-a30f-4c82-8313-6eaf44d80b77', '2415', 'Prêts aux associés', 1233.00, 'credit', '2025-05-18', 'test', NULL, '2025-05-18 20:27:51'),
(17, '261c1900-a5b8-4109-baaa-618bcc7cb1c1', '6191', 'Dotations d\'exploitation aux amortissements de l\'immobilisation en non valeur', 100000.00, 'debit', '2025-05-21', 'achat de chihaja', 'uploads/justifications/justif_682e5c8802be5.jpg', '2025-05-21 23:06:48'),
(18, '261c1900-a5b8-4109-baaa-618bcc7cb1c1', '2920', 'Provisions pour dépréciation des immobilisations incorporelles', 100000.00, 'credit', '2025-05-21', 'achat de chihaja', 'uploads/justifications/justif_682e5c8802be5.jpg', '2025-05-21 23:06:48'),
(19, '3aba1da0-0cf7-4484-82d9-853ad619bb82', '1111', 'Capital social', 7894.00, 'debit', '2025-05-22', 'test 1111', NULL, '2025-05-22 00:44:07'),
(20, '3aba1da0-0cf7-4484-82d9-853ad619bb82', '1351', 'Provisions pour amortissements dérogatoires', 7894.00, 'credit', '2025-05-22', 'test 1111', NULL, '2025-05-22 00:44:07'),
(21, '82273002-b187-4a21-a72e-ed9fabddc546', '1117', 'Capital personnel', 6789.00, 'debit', '2025-05-22', 'test 1117', NULL, '2025-05-22 00:45:25'),
(22, '82273002-b187-4a21-a72e-ed9fabddc546', '2487', 'Créances immobilisées', 6789.00, 'credit', '2025-05-22', 'test 1117', NULL, '2025-05-22 00:45:25'),
(23, 'be97e544-71a0-48a5-bf94-b00d14fbdf76', '51111', 'Chèques en portefeuille', 10000.00, 'debit', '2025-05-22', 'achat de marchendise', 'uploads/justifications/justif_682f27070200c.pdf', '2025-05-22 13:30:47'),
(24, 'be97e544-71a0-48a5-bf94-b00d14fbdf76', '3423', 'Clients - retenues de garantie', 5000.00, 'credit', '2025-05-22', 'achat de marchendise', 'uploads/justifications/justif_682f27070200c.pdf', '2025-05-22 13:30:47'),
(25, 'be97e544-71a0-48a5-bf94-b00d14fbdf76', '1117', 'Capital personnel', 5000.00, 'credit', '2025-05-22', 'achat de marchendise', 'uploads/justifications/justif_682f27070200c.pdf', '2025-05-22 13:30:47'),
(26, '57af2c87-91f1-4997-aa8a-768163bfd3fe', '1111', 'Capital social', 10000.00, 'debit', '2025-05-22', 'test', 'uploads/justifications/justif_682f3087c50aa.pdf', '2025-05-22 14:11:19'),
(27, '57af2c87-91f1-4997-aa8a-768163bfd3fe', '1117', 'Capital personnel', 10000.00, 'credit', '2025-05-22', 'test', 'uploads/justifications/justif_682f3087c50aa.pdf', '2025-05-22 14:11:19'),
(28, '8af18d83-d51b-4c65-99fd-f543897d27d7', '1111', 'Capital social', 5000.00, 'debit', '2025-05-26', 'test final', 'uploads/justifications/justif_6834a37e47941.pdf', '2025-05-26 17:23:10'),
(29, '8af18d83-d51b-4c65-99fd-f543897d27d7', '1117', 'Capital personnel', 2500.00, 'credit', '2025-05-26', 'test final', 'uploads/justifications/justif_6834a37e47941.pdf', '2025-05-26 17:23:10'),
(30, '8af18d83-d51b-4c65-99fd-f543897d27d7', '1112', 'Fonds de dotation', 2500.00, 'credit', '2025-05-26', 'test final', 'uploads/justifications/justif_6834a37e47941.pdf', '2025-05-26 17:23:10'),
(31, '8779f7d4-2d33-447f-aedc-28dc4f11fa9f', '31343', 'Prestations en cours', 3000.00, 'debit', '2025-05-27', 'final', 'uploads/justifications/justif_683501799f7f5.jpg', '2025-05-27 00:04:09'),
(32, '8779f7d4-2d33-447f-aedc-28dc4f11fa9f', '2415', 'Prêts aux associés', 3000.00, 'credit', '2025-05-27', 'final', 'uploads/justifications/justif_683501799f7f5.jpg', '2025-05-27 00:04:09'),
(33, '6554f0f3-cfa0-4489-b0a6-ddd0d50819d0', '3421', 'Clients', 2000.00, 'debit', '2025-05-27', 'vente par creance client', NULL, '2025-05-27 15:22:28'),
(34, '6554f0f3-cfa0-4489-b0a6-ddd0d50819d0', '7111', 'Ventes de marchandises au Maroc', 1900.00, 'credit', '2025-05-27', 'vente par creance client', NULL, '2025-05-27 15:22:28'),
(35, '6554f0f3-cfa0-4489-b0a6-ddd0d50819d0', '4455', 'Etat, TVA facturée', 100.00, 'credit', '2025-05-27', 'vente par creance client', NULL, '2025-05-27 15:22:28'),
(36, '2fa26c5c-df8e-4b0c-9dc8-f3a8dac477c5', '1111', 'Capital social', 32432.00, 'debit', '2025-05-29', 'test', 'uploads/justifications/justif_68385c060516d.pdf', '2025-05-29 13:07:18'),
(37, '2fa26c5c-df8e-4b0c-9dc8-f3a8dac477c5', '1169', 'Report à nouveau (solde débiteur)', 32432.00, 'credit', '2025-05-29', 'test', 'uploads/justifications/justif_68385c060516d.pdf', '2025-05-29 13:07:18');

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

CREATE TABLE `fournisseurs` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `solde` decimal(12,2) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `fournisseurs`
--

INSERT INTO `fournisseurs` (`id`, `nom`, `email`, `telephone`, `adresse`, `solde`, `description`) VALUES
(1, 'mounaime', 'parentgta520@gmail.com', '065460', 'fasdfas fdasfas errachidia', 6743.00, 'f,dsa/,f/asf'),
(2, 'amhezould abdessamad', 'amehzoul@gmail.com', '03469879', 'in ati 1', 12000.00, 'description test'),
(3, 'test name', 'fsdhkfhdk@gmail.com', '065465', 'fadfafadadfadsffdfa', 467678.00, 'fdafdaf'),
(4, 'test username', 'M150014769@taalim.ma', '06496446446', 'adress test', 97978.12, 'fadsfadsfadsfasf');

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur_transactions`
--

CREATE TABLE `fournisseur_transactions` (
  `id` int(11) NOT NULL,
  `fournisseur_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `montant` decimal(12,2) NOT NULL,
  `description` text DEFAULT NULL,
  `justificatif` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `fournisseur_transactions`
--

INSERT INTO `fournisseur_transactions` (`id`, `fournisseur_id`, `date`, `montant`, `description`, `justificatif`) VALUES
(1, 2, '2025-05-27', 6000.00, 'paye 6000', 'uploads/justificatifs/6835fe90bb5af_canvaLogo.png');

-- --------------------------------------------------------

--
-- Structure de la table `tresorerie_solde`
--

CREATE TABLE `tresorerie_solde` (
  `id` int(11) NOT NULL,
  `banque` decimal(12,2) NOT NULL DEFAULT 0.00,
  `caisse` decimal(12,2) NOT NULL DEFAULT 0.00,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tresorerie_solde`
--

INSERT INTO `tresorerie_solde` (`id`, `banque`, `caisse`, `updated_at`) VALUES
(1, 12345.67, 12567.89, '2025-05-22 02:05:45');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Younes Ouba', 'younes123ouba@gmail.com', '$2y$10$CI5DxGpxUn0aVirX/1vZvuEHANZ3Vvk6LfDQqx0xyBJmQskl9T1hK', '2025-05-15 13:11:35', '2025-05-15 13:11:35'),
(2, 'Younes Kroos', 'younesouba66@gmail.com', '$2y$10$ukR6gqyOCDRJjcZvY9s6luuAp7GdjvjhOcym6O.9eHgq1hitDrqx.', '2025-05-15 13:21:51', '2025-05-15 16:50:56'),
(3, 'Cristiano Ronaldo', 'Cristiano@gmail.com', '$2y$10$n6LA8JD0miuYpw2vaqZZTe4n4owz1cjyksHboJ8uMyT2kk2Yeox.i', '2025-05-15 16:45:26', '2025-05-15 16:45:26'),
(4, 'bouincha mohamed', 'bouinchamohamed1@gmail.com', '$2y$10$afiy1XUdkW48PKqFg/T/Vu6fD9nOQ7UzXcXbfA2G5fu6sG1kM5ok6', '2025-05-16 19:06:43', '2025-05-16 19:06:43'),
(5, 'Toni Kroos', 'Kroos@gmail.com', '$2y$10$sfbZgYACGv.V1BieKOQ0uuzfTj8p28Hocad9I.9o8SjhNRRVa7k.e', '2025-05-21 22:36:53', '2025-05-21 22:36:53'),
(0, 'mounaime benalla', 'benalla@gmail.com', '$2y$10$HK3UjnBm8AtpwuBJOaV5S.I2OgDNoaOynDu6ZS13pHpLhgvt7NEq6', '2025-05-22 17:56:07', '2025-05-22 17:56:07'),
(0, 'benalla', 'mounaime@gmail.com', '$2y$10$zyztt//Dsy1gyN2GE5urPeywaT2GYMexKQIx8Uq6FjYvbM5qegv92', '2025-05-28 13:33:29', '2025-05-28 13:33:29');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `benefices`
--
ALTER TABLE `benefices`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`num_Class`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `client_transactions`
--
ALTER TABLE `client_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Index pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_compte` (`numero_compte`),
  ADD KEY `class_id` (`class_id`);

--
-- Index pour la table `entreprise`
--
ALTER TABLE `entreprise`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `entries`
--
ALTER TABLE `entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_journal_entry_id` (`journal_entry_id`);

--
-- Index pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `fournisseur_transactions`
--
ALTER TABLE `fournisseur_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fournisseur_id` (`fournisseur_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `benefices`
--
ALTER TABLE `benefices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `classes`
--
ALTER TABLE `classes`
  MODIFY `num_Class` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `client_transactions`
--
ALTER TABLE `client_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `comptes`
--
ALTER TABLE `comptes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1682;

--
-- AUTO_INCREMENT pour la table `entreprise`
--
ALTER TABLE `entreprise`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `entries`
--
ALTER TABLE `entries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `fournisseurs`
--
ALTER TABLE `fournisseurs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `fournisseur_transactions`
--
ALTER TABLE `fournisseur_transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `client_transactions`
--
ALTER TABLE `client_transactions`
  ADD CONSTRAINT `client_transactions_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Contraintes pour la table `comptes`
--
ALTER TABLE `comptes`
  ADD CONSTRAINT `comptes_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`num_Class`);

--
-- Contraintes pour la table `fournisseur_transactions`
--
ALTER TABLE `fournisseur_transactions`
  ADD CONSTRAINT `fournisseur_transactions_ibfk_1` FOREIGN KEY (`fournisseur_id`) REFERENCES `fournisseurs` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
