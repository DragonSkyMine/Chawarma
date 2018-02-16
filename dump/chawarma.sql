DROP VIEW IF EXISTS `v_etudiant`;
DROP VIEW IF EXISTS `v_enseignant`;
DROP TABLE IF EXISTS `ReponseEtu`;
DROP TABLE IF EXISTS `Reponse`;
DROP TABLE IF EXISTS `Question`;
DROP TABLE IF EXISTS `Sondage`;
DROP TABLE IF EXISTS `Classe`;
DROP TABLE IF EXISTS `Niveau`;
DROP TABLE IF EXISTS `Etudiant`;
DROP TABLE IF EXISTS `Enseignant`;
DROP TABLE IF EXISTS `Personne`;


CREATE TABLE `Classe` (
  `cla_id` int(11) NOT NULL,
  `niv_id` int(11) NOT NULL,
  `cla_nom` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Enseignant` (
  `ens_id` int(11) NOT NULL,
  `per_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Enseignant` (`ens_id`, `per_id`) VALUES
(1, 2);

CREATE TABLE `Etudiant` (
  `etu_id` int(10) NOT NULL,
  `per_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Etudiant` (`etu_id`, `per_id`) VALUES
(1, 1);

CREATE TABLE `Niveau` (
  `niv_id` int(11) NOT NULL,
  `niv_libelle` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Personne` (
  `per_id` int(11) NOT NULL,
  `per_nom` varchar(20) NOT NULL,
  `per_prenom` varchar(20) NOT NULL,
  `per_mail` varchar(40) NOT NULL,
  `per_mdp` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Personne` (`per_id`, `per_nom`, `per_prenom`, `per_mail`, `per_mdp`) VALUES
(1, 'Sagnes', 'Joey', 'joey.sagnes@truc.com', '6607a999607711cd339dce1de6d64425a0985cfd'),
(2, 'prof', 'prenom', 'prof@prof.fr', '6607a999607711cd339dce1de6d64425a0985cfd');

CREATE TABLE `Question` (
  `que_id` int(11) NOT NULL,
  `son_id` int(11) NOT NULL,
  `que_question` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Reponse` (
  `rep_id` int(11) NOT NULL,
  `rep_vrai` tinyint(1) NOT NULL,
  `que_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `ReponseEtu` (
  `rpe_id` int(11) NOT NULL,
  `rep_id` int(11) NOT NULL,
  `etu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Sondage` (
  `son_id` int(11) NOT NULL,
  `son_refe` varchar(10) NOT NULL,
  `ens_id` int(11) NOT NULL,
  `cla_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE VIEW `v_enseignant` AS
SELECT Personne.*, Enseignant.ens_id
FROM Personne, Enseignant
WHERE Personne.per_id = Enseignant.per_id;

CREATE VIEW `v_etudiant` AS
SELECT Personne.*, Etudiant.etu_id
FROM Personne, Etudiant
WHERE Personne.per_id = Etudiant.per_id;


ALTER TABLE `Classe`
  ADD PRIMARY KEY (`cla_id`),
  ADD KEY `cla_id` (`cla_id`),
  ADD KEY `niv_id` (`niv_id`);

ALTER TABLE `Enseignant`
  ADD PRIMARY KEY (`ens_id`),
  ADD KEY `ens_id` (`ens_id`),
  ADD KEY `etu_id` (`per_id`);

ALTER TABLE `Etudiant`
  ADD PRIMARY KEY (`etu_id`),
  ADD KEY `etu_id` (`etu_id`),
  ADD KEY `per_id` (`per_id`);

ALTER TABLE `Niveau`
  ADD PRIMARY KEY (`niv_id`),
  ADD KEY `niv_id` (`niv_id`);

ALTER TABLE `Personne`
  ADD PRIMARY KEY (`per_id`),
  ADD KEY `etu_id` (`per_id`);

ALTER TABLE `Question`
  ADD PRIMARY KEY (`que_id`),
  ADD KEY `que_id` (`que_id`),
  ADD KEY `son_id` (`son_id`);

ALTER TABLE `Reponse`
  ADD PRIMARY KEY (`rep_id`),
  ADD KEY `rep_id` (`rep_id`),
  ADD KEY `que_id` (`que_id`);

ALTER TABLE `ReponseEtu`
  ADD PRIMARY KEY (`rpe_id`),
  ADD KEY `rpe_id` (`rpe_id`),
  ADD KEY `rep_id` (`rep_id`),
  ADD KEY `etu_id` (`etu_id`);

ALTER TABLE `Sondage`
  ADD PRIMARY KEY (`son_id`),
  ADD UNIQUE KEY `son_refe` (`son_refe`),
  ADD KEY `son_id` (`son_id`,`ens_id`,`cla_id`),
  ADD KEY `fk_ens_id` (`ens_id`),
  ADD KEY `fk_cla_id` (`cla_id`);

ALTER TABLE `Classe`
  MODIFY `cla_id` int(11) NOT NULL AUTO_INCREMENT;
  
ALTER TABLE `Enseignant`
  MODIFY `ens_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `Etudiant`
  MODIFY `etu_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

ALTER TABLE `Niveau`
  MODIFY `niv_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Personne`
  MODIFY `per_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

ALTER TABLE `Question`
  MODIFY `que_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Reponse`
  MODIFY `rep_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `ReponseEtu`
  MODIFY `rpe_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Sondage`
  MODIFY `son_id` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `Classe`
  ADD CONSTRAINT `fk_niv_id` FOREIGN KEY (`niv_id`) REFERENCES `Niveau` (`niv_id`);

ALTER TABLE `Enseignant`
  ADD CONSTRAINT `fk_per_id_ens` FOREIGN KEY (`per_id`) REFERENCES `Personne` (`per_id`);

ALTER TABLE `Etudiant`
  ADD CONSTRAINT `fk_per_id_etu` FOREIGN KEY (`per_id`) REFERENCES `Personne` (`per_id`);

ALTER TABLE `Question`
  ADD CONSTRAINT `fk_son_id` FOREIGN KEY (`son_id`) REFERENCES `Sondage` (`son_id`);

ALTER TABLE `Reponse`
  ADD CONSTRAINT `fk_que_id` FOREIGN KEY (`que_id`) REFERENCES `Question` (`que_id`);

ALTER TABLE `ReponseEtu`
  ADD CONSTRAINT `fk_rep_id` FOREIGN KEY (`rep_id`) REFERENCES `Reponse` (`rep_id`),
  ADD CONSTRAINT `fk_rpe_etu_id` FOREIGN KEY (`etu_id`) REFERENCES `Personne` (`per_id`);

ALTER TABLE `Sondage`
  ADD CONSTRAINT `fk_cla_id` FOREIGN KEY (`cla_id`) REFERENCES `Classe` (`cla_id`),
  ADD CONSTRAINT `fk_ens_id` FOREIGN KEY (`ens_id`) REFERENCES `Enseignant` (`ens_id`);
