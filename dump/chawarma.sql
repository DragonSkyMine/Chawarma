-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Jeu 15 Février 2018 à 02:49
-- Version du serveur :  5.7.21-0ubuntu0.16.04.1
-- Version de PHP :  7.0.22-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `chawarma`
--
CREATE DATABASE IF NOT EXISTS `chawarma` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `chawarma`;

-- --------------------------------------------------------

--
-- Structure de la table `Classe`
--

CREATE TABLE `Classe` (
  `cla_id` int(11) NOT NULL,
  `niv_id` int(11) NOT NULL,
  `cla_nom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Enseignant`
--

CREATE TABLE `Enseignant` (
  `ens_id` int(11) NOT NULL,
  `per_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Etudiant`
--

CREATE TABLE `Etudiant` (
  `etu_id` int(10) NOT NULL,
  `per_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Etudiant`
--

INSERT INTO `Etudiant` (`etu_id`, `per_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Niveau`
--

CREATE TABLE `Niveau` (
  `niv_id` int(11) NOT NULL,
  `niv_libelle` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Personne`
--

CREATE TABLE `Personne` (
  `per_id` int(11) NOT NULL,
  `per_nom` varchar(20) NOT NULL,
  `per_prenom` varchar(20) NOT NULL,
  `per_mail` varchar(40) NOT NULL,
  `per_mdp` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Personne`
--

INSERT INTO `Personne` (`per_id`, `per_nom`, `per_prenom`, `per_mail`, `per_mdp`) VALUES
(1, 'Sagnes', 'Joey', 'joey.sagnes@truc.com', '6607a999607711cd339dce1de6d64425a0985cfd');

-- --------------------------------------------------------

--
-- Structure de la table `Question`
--

CREATE TABLE `Question` (
  `que_id` int(11) NOT NULL,
  `son_id` int(11) NOT NULL,
  `que_question` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Reponse`
--

CREATE TABLE `Reponse` (
  `rep_id` int(11) NOT NULL,
  `rep_vrai` tinyint(1) NOT NULL,
  `que_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `ReponseEtu`
--

CREATE TABLE `ReponseEtu` (
  `rpe_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  `etu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `Sondage`
--

CREATE TABLE `Sondage` (
  `son_id` int(11) NOT NULL,
  `son_refe` varchar(10) NOT NULL,
  `ens_id` int(11) NOT NULL,
  `cla_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Classe`
--
ALTER TABLE `Classe`
  ADD PRIMARY KEY (`cla_id`),
  ADD KEY `cla_id` (`cla_id`),
  ADD KEY `niv_id` (`niv_id`);

--
-- Index pour la table `Enseignant`
--
ALTER TABLE `Enseignant`
  ADD PRIMARY KEY (`ens_id`),
  ADD KEY `ens_id` (`ens_id`),
  ADD KEY `etu_id` (`per_id`);

--
-- Index pour la table `Etudiant`
--
ALTER TABLE `Etudiant`
  ADD PRIMARY KEY (`etu_id`),
  ADD KEY `etu_id` (`etu_id`),
  ADD KEY `per_id` (`per_id`);

--
-- Index pour la table `Niveau`
--
ALTER TABLE `Niveau`
  ADD PRIMARY KEY (`niv_id`),
  ADD KEY `niv_id` (`niv_id`);

--
-- Index pour la table `Personne`
--
ALTER TABLE `Personne`
  ADD PRIMARY KEY (`per_id`),
  ADD KEY `etu_id` (`per_id`);

--
-- Index pour la table `Question`
--
ALTER TABLE `Question`
  ADD PRIMARY KEY (`que_id`),
  ADD KEY `que_id` (`que_id`),
  ADD KEY `son_id` (`son_id`);

--
-- Index pour la table `Reponse`
--
ALTER TABLE `Reponse`
  ADD PRIMARY KEY (`rep_id`),
  ADD KEY `rep_id` (`rep_id`),
  ADD KEY `que_id` (`que_id`);

--
-- Index pour la table `ReponseEtu`
--
ALTER TABLE `ReponseEtu`
  ADD PRIMARY KEY (`rpe_id`),
  ADD KEY `rpe_id` (`rpe_id`),
  ADD KEY `rep_id` (`rep_id`),
  ADD KEY `etu_id` (`etu_id`);

--
-- Index pour la table `Sondage`
--
ALTER TABLE `Sondage`
  ADD PRIMARY KEY (`son_id`),
  ADD UNIQUE KEY `son_refe` (`son_refe`),
  ADD KEY `son_id` (`son_id`,`ens_id`,`cla_id`),
  ADD KEY `fk_ens_id` (`ens_id`),
  ADD KEY `fk_cla_id` (`cla_id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Classe`
--
ALTER TABLE `Classe`
  MODIFY `cla_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Enseignant`
--
ALTER TABLE `Enseignant`
  MODIFY `ens_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Etudiant`
--
ALTER TABLE `Etudiant`
  MODIFY `etu_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Niveau`
--
ALTER TABLE `Niveau`
  MODIFY `niv_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Personne`
--
ALTER TABLE `Personne`
  MODIFY `per_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Question`
--
ALTER TABLE `Question`
  MODIFY `que_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Reponse`
--
ALTER TABLE `Reponse`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `ReponseEtu`
--
ALTER TABLE `ReponseEtu`
  MODIFY `rpe_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Sondage`
--
ALTER TABLE `Sondage`
  MODIFY `son_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Classe`
--
ALTER TABLE `Classe`
  ADD CONSTRAINT `fk_niv_id` FOREIGN KEY (`niv_id`) REFERENCES `Niveau` (`niv_id`);

--
-- Contraintes pour la table `Enseignant`
--
ALTER TABLE `Enseignant`
  ADD CONSTRAINT `fk_per_id_ens` FOREIGN KEY (`per_id`) REFERENCES `Personne` (`per_id`);

--
-- Contraintes pour la table `Etudiant`
--
ALTER TABLE `Etudiant`
  ADD CONSTRAINT `fk_per_id_etu` FOREIGN KEY (`per_id`) REFERENCES `Personne` (`per_id`);

--
-- Contraintes pour la table `Question`
--
ALTER TABLE `Question`
  ADD CONSTRAINT `fk_son_id` FOREIGN KEY (`son_id`) REFERENCES `Sondage` (`son_id`);

--
-- Contraintes pour la table `Reponse`
--
ALTER TABLE `Reponse`
  ADD CONSTRAINT `fk_que_id` FOREIGN KEY (`que_id`) REFERENCES `Question` (`que_id`);

--
-- Contraintes pour la table `ReponseEtu`
--
ALTER TABLE `ReponseEtu`
  ADD CONSTRAINT `fk_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `Reponse` (`rep_id`),
  ADD CONSTRAINT `fk_rpe_etu_id` FOREIGN KEY (`etu_id`) REFERENCES `Personne` (`per_id`);

--
-- Contraintes pour la table `Sondage`
--
ALTER TABLE `Sondage`
  ADD CONSTRAINT `fk_cla_id` FOREIGN KEY (`cla_id`) REFERENCES `Classe` (`cla_id`),
  ADD CONSTRAINT `fk_ens_id` FOREIGN KEY (`ens_id`) REFERENCES `Enseignant` (`ens_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
