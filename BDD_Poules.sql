-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour poules_emmanuel
CREATE DATABASE IF NOT EXISTS `poules_emmanuel` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `poules_emmanuel`;

-- Listage de la structure de table poules_emmanuel. objective
CREATE TABLE IF NOT EXISTS `objective` (
  `id_objective` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text,
  `goal` int DEFAULT NULL,
  `unit` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `perNbChicken` int DEFAULT NULL,
  PRIMARY KEY (`id_objective`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.objective : ~7 rows (environ)
INSERT INTO `objective` (`id_objective`, `name`, `description`, `goal`, `unit`, `perNbChicken`) VALUES
	(1, 'area', 'Total area in square meters needed per chicken', 15, 'm²', 1),
	(2, 'perch', 'Perch length in centimeters needed per chicken', 20, 'cm', 1),
	(3, 'shelter', 'Shelter area in square meters needed for 10 chickens', 3, 'm²', 10),
	(4, 'shrubs', 'Number of edible shrubs needed for 10 chickens', 3, 'shrubs', 10),
	(5, 'insectary', 'Number of insect-hosting structures needed for 5 chickens', 1, 'structure', 5),
	(6, 'dustbath', 'Dust bath area in square meters needed for 10 chickens', 3, 'm²', 10),
	(7, 'waterer', 'Number of water points needed for 5 chickens', 1, 'water point', 5);

-- Listage de la structure de table poules_emmanuel. plan
CREATE TABLE IF NOT EXISTS `plan` (
  `id_plan` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `nbChickens` int DEFAULT NULL,
  `dateCreation` datetime NOT NULL,
  `isCompleted` tinyint(1) DEFAULT '0',
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_plan`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.plan : ~1 rows (environ)
INSERT INTO `plan` (`id_plan`, `name`, `nbChickens`, `dateCreation`, `isCompleted`, `id_user`) VALUES
	(1, 'Chicken Run 101', 12, '2025-01-29 14:44:19', 0, 1);

-- Listage de la structure de table poules_emmanuel. plan_element
CREATE TABLE IF NOT EXISTS `plan_element` (
  `id_element` int NOT NULL,
  `type` varchar(50) NOT NULL,
  `positionX` decimal(15,2) DEFAULT NULL,
  `positionY` decimal(15,2) DEFAULT NULL,
  `dimensions` text,
  `description` text,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_element`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `plan_element_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.plan_element : ~1 rows (environ)
INSERT INTO `plan_element` (`id_element`, `type`, `positionX`, `positionY`, `dimensions`, `description`, `id_plan`) VALUES
	(1, 'Tree', NULL, NULL, NULL, NULL, 1);

-- Listage de la structure de table poules_emmanuel. plan_objectives
CREATE TABLE IF NOT EXISTS `plan_objectives` (
  `id_plan` int NOT NULL,
  `id_objective` int NOT NULL,
  `status` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_plan`,`id_objective`),
  KEY `id_objective` (`id_objective`),
  CONSTRAINT `plan_objectives_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`),
  CONSTRAINT `plan_objectives_ibfk_2` FOREIGN KEY (`id_objective`) REFERENCES `objective` (`id_objective`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.plan_objectives : ~7 rows (environ)
INSERT INTO `plan_objectives` (`id_plan`, `id_objective`, `status`) VALUES
	(1, 1, 0),
	(1, 2, 0),
	(1, 3, 0),
	(1, 4, 0),
	(1, 5, 0),
	(1, 6, 0),
	(1, 7, 0);

-- Listage de la structure de table poules_emmanuel. save
CREATE TABLE IF NOT EXISTS `save` (
  `id_history` int NOT NULL,
  `version_name` varchar(50) NOT NULL,
  `dateSave` datetime NOT NULL,
  `id_user` int DEFAULT NULL,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_history`),
  KEY `id_user` (`id_user`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `save_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
  CONSTRAINT `save_ibfk_2` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.save : ~0 rows (environ)

-- Listage de la structure de table poules_emmanuel. user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules_emmanuel.user : ~0 rows (environ)
INSERT INTO `user` (`id_user`, `email`, `username`, `password`) VALUES
	(1, 'test@exemple.com', 'test', '1234');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
