-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Dim 25 Février 2018 à 15:17
-- Version du serveur :  5.7.21-0ubuntu0.17.10.1
-- Version de PHP :  7.1.11-1+ubuntu17.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `chawarma`
--
DROP VIEW IF EXISTS `v_etudiant`;
DROP VIEW IF EXISTS `v_enseignant`;
DROP TABLE IF EXISTS `v_etudiant`;
DROP TABLE IF EXISTS `v_enseignant`;
DROP TABLE IF EXISTS `ReponseEtu`;
DROP TABLE IF EXISTS `Reponse`;
DROP TABLE IF EXISTS `Question`;
DROP TABLE IF EXISTS `Sondage`;
DROP TABLE IF EXISTS `Classe`;
DROP TABLE IF EXISTS `Niveau`;
DROP TABLE IF EXISTS `Etudiant`;
DROP TABLE IF EXISTS `Enseignant`;
DROP TABLE IF EXISTS `Personne`;

-- --------------------------------------------------------

--
-- Structure de la table `Classe`
--

DROP TABLE IF EXISTS `Classe`;
CREATE TABLE `Classe` (
  `cla_id` int(11) NOT NULL,
  `niv_id` int(11) NOT NULL,
  `cla_nom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Classe`
--

INSERT INTO `Classe` (`cla_id`, `niv_id`, `cla_nom`) VALUES
(1, 1, 'MIAW');

-- --------------------------------------------------------

--
-- Structure de la table `Enseignant`
--

DROP TABLE IF EXISTS `Enseignant`;
CREATE TABLE `Enseignant` (
  `ens_id` int(11) NOT NULL,
  `per_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Enseignant`
--

INSERT INTO `Enseignant` (`ens_id`, `per_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Structure de la table `Etudiant`
--

DROP TABLE IF EXISTS `Etudiant`;
CREATE TABLE `Etudiant` (
  `etu_id` int(11) NOT NULL,
  `per_id` int(11) NOT NULL,
  `cla_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Etudiant`
--

INSERT INTO `Etudiant` (`etu_id`, `per_id`, `cla_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Niveau`
--

DROP TABLE IF EXISTS `Niveau`;
CREATE TABLE `Niveau` (
  `niv_id` int(11) NOT NULL,
  `niv_libelle` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Niveau`
--

INSERT INTO `Niveau` (`niv_id`, `niv_libelle`) VALUES
(1, 'LP');

-- --------------------------------------------------------

--
-- Structure de la table `Personne`
--

DROP TABLE IF EXISTS `Personne`;
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
(1, 'Sagnes', 'Joey', 'joey.sagnes@truc.com', '6607a999607711cd339dce1de6d64425a0985cfd'),
(2, 'prof', 'prenom', 'prof@prof.fr', '6607a999607711cd339dce1de6d64425a0985cfd');

-- --------------------------------------------------------

--
-- Structure de la table `Question`
--

DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question` (
  `que_id` int(11) NOT NULL,
  `son_id` int(11) NOT NULL,
  `que_question` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Question`
--

INSERT INTO `Question` (`que_id`, `son_id`, `que_question`) VALUES
(1, 1, 'ON MANGE QUOI ?');

-- --------------------------------------------------------

--
-- Structure de la table `Reponse`
--

DROP TABLE IF EXISTS `Reponse`;
CREATE TABLE `Reponse` (
  `rep_id` int(11) NOT NULL,
  `rep_vrai` tinyint(1) NOT NULL,
  `que_id` int(11) NOT NULL,
  `rep_label` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Reponse`
--

INSERT INTO `Reponse` (`rep_id`, `rep_vrai`, `que_id`, `rep_label`) VALUES
(1, 1, 1, 'Tacos'),
(2, 0, 1, 'Pizza');

-- --------------------------------------------------------

--
-- Structure de la table `ReponseEtu`
--

DROP TABLE IF EXISTS `ReponseEtu`;
CREATE TABLE `ReponseEtu` (
  `rpe_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  `etu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `ReponseEtu`
--

INSERT INTO `ReponseEtu` (`rpe_id`, `rep_id`, `etu_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `Sondage`
--

DROP TABLE IF EXISTS `Sondage`;
CREATE TABLE `Sondage` (
  `son_id` int(11) NOT NULL,
  `son_refe` varchar(10) NOT NULL,
  `ens_id` int(11) NOT NULL,
  `cla_id` int(11) NOT NULL,
  `cla_flag` varchar(1) NOT NULL DEFAULT 'O'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `Sondage`
--

INSERT INTO `Sondage` (`son_id`, `son_refe`, `ens_id`, `cla_id`, `cla_flag`) VALUES
(1, 'SWAG', 1, 1, 'O');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_enseignant`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_enseignant`;
CREATE TABLE `v_enseignant` (
`per_id` int(11)
,`per_nom` varchar(20)
,`per_prenom` varchar(20)
,`per_mail` varchar(40)
,`per_mdp` varchar(100)
,`ens_id` int(11)
);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `v_etudiant`
-- (Voir ci-dessous la vue réelle)
--
DROP VIEW IF EXISTS `v_etudiant`;
CREATE TABLE `v_etudiant` (
`per_id` int(11)
,`per_nom` varchar(20)
,`per_prenom` varchar(20)
,`per_mail` varchar(40)
,`per_mdp` varchar(100)
,`etu_id` int(11)
);

-- --------------------------------------------------------

--
-- Structure de la vue `v_enseignant`
--
DROP TABLE IF EXISTS `v_enseignant`;

CREATE ALGORITHM=UNDEFINED DEFINER=`chawarma`@`localhost` SQL SECURITY DEFINER VIEW `v_enseignant`  AS  select `Personne`.`per_id` AS `per_id`,`Personne`.`per_nom` AS `per_nom`,`Personne`.`per_prenom` AS `per_prenom`,`Personne`.`per_mail` AS `per_mail`,`Personne`.`per_mdp` AS `per_mdp`,`Enseignant`.`ens_id` AS `ens_id` from (`Personne` join `Enseignant`) where (`Personne`.`per_id` = `Enseignant`.`per_id`) ;

-- --------------------------------------------------------

--
-- Structure de la vue `v_etudiant`
--
DROP TABLE IF EXISTS `v_etudiant`;

CREATE ALGORITHM=UNDEFINED DEFINER=`chawarma`@`localhost` SQL SECURITY DEFINER VIEW `v_etudiant`  AS  select `Personne`.`per_id` AS `per_id`,`Personne`.`per_nom` AS `per_nom`,`Personne`.`per_prenom` AS `per_prenom`,`Personne`.`per_mail` AS `per_mail`,`Personne`.`per_mdp` AS `per_mdp`,`Etudiant`.`etu_id` AS `etu_id` from (`Personne` join `Etudiant`) where (`Personne`.`per_id` = `Etudiant`.`per_id`) ;

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
  ADD KEY `per_id` (`per_id`),
  ADD KEY `cla_id` (`cla_id`);

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
  MODIFY `cla_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Enseignant`
--
ALTER TABLE `Enseignant`
  MODIFY `ens_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Etudiant`
--
ALTER TABLE `Etudiant`
  MODIFY `etu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Niveau`
--
ALTER TABLE `Niveau`
  MODIFY `niv_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Personne`
--
ALTER TABLE `Personne`
  MODIFY `per_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `Question`
--
ALTER TABLE `Question`
  MODIFY `que_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Reponse`
--
ALTER TABLE `Reponse`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `ReponseEtu`
--
ALTER TABLE `ReponseEtu`
  MODIFY `rpe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `Sondage`
--
ALTER TABLE `Sondage`
  MODIFY `son_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
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
  ADD CONSTRAINT `fk_cla_id_etu` FOREIGN KEY (`cla_id`) REFERENCES `Classe` (`cla_id`),
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
  ADD CONSTRAINT `fk_rpe_etu_id` FOREIGN KEY (`etu_id`) REFERENCES `Etudiant` (`etu_id`);

--
-- Contraintes pour la table `Sondage`
--
ALTER TABLE `Sondage`
  ADD CONSTRAINT `fk_cla_id` FOREIGN KEY (`cla_id`) REFERENCES `Classe` (`cla_id`),
  ADD CONSTRAINT `fk_ens_id` FOREIGN KEY (`ens_id`) REFERENCES `Enseignant` (`ens_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
