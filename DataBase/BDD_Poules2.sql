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


-- Listage de la structure de la base pour poules2_emmanuel
CREATE DATABASE IF NOT EXISTS `poules2_emmanuel` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `poules2_emmanuel`;

-- Listage de la structure de table poules2_emmanuel. element_vertices
CREATE TABLE IF NOT EXISTS `element_vertices` (
  `id_element` int NOT NULL,
  `id_vertex` int NOT NULL,
  `vertexOrder` int NOT NULL,
  PRIMARY KEY (`id_element`,`id_vertex`),
  KEY `id_vertex` (`id_vertex`),
  CONSTRAINT `element_vertices_ibfk_1` FOREIGN KEY (`id_element`) REFERENCES `plan_element` (`id_element`),
  CONSTRAINT `element_vertices_ibfk_2` FOREIGN KEY (`id_vertex`) REFERENCES `vertex` (`id_vertex`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.element_vertices : ~0 rows (environ)

-- Listage de la structure de table poules2_emmanuel. history
CREATE TABLE IF NOT EXISTS `history` (
  `id_history` int NOT NULL AUTO_INCREMENT,
  `version_name` varchar(50) NOT NULL,
  `dateSave` datetime DEFAULT CURRENT_TIMESTAMP,
  `id_user` int DEFAULT NULL,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_history`),
  KEY `id_user` (`id_user`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `history_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_` (`id_user`),
  CONSTRAINT `history_ibfk_2` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.history : ~6 rows (environ)
INSERT INTO `history` (`id_history`, `version_name`, `dateSave`, `id_user`, `id_plan`) VALUES
	(1, 'Initial Layout', '2024-02-06 10:00:00', 1, 1),
	(2, 'Added Shelter', '2024-02-06 10:30:00', 1, 1),
	(3, 'Completed Design', '2024-02-06 11:00:00', 1, 1),
	(4, 'First Draft', '2024-02-06 11:30:00', 2, 2),
	(5, 'Shelter Added', '2024-02-06 12:00:00', 2, 2),
	(6, 'Initial Setup', '2024-02-06 14:15:00', 3, 3);

-- Listage de la structure de table poules2_emmanuel. objective
CREATE TABLE IF NOT EXISTS `objective` (
  `id_objective` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` text,
  `goal` int NOT NULL,
  `unit` varchar(20) NOT NULL,
  `perNbChicken` int NOT NULL,
  PRIMARY KEY (`id_objective`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.objective : ~7 rows (environ)
INSERT INTO `objective` (`id_objective`, `name`, `description`, `goal`, `unit`, `perNbChicken`) VALUES
	(1, 'area', 'Total area needed per chicken', 15, 'm²', 1),
	(2, 'perch', 'Perch length needed per chicken', 20, 'cm', 1),
	(3, 'shelter', 'Shelter area needed for 10 chickens', 3, 'm²', 10),
	(4, 'shrubs', 'Edible shrubs needed for 10 chickens', 3, 'shrubs', 10),
	(5, 'insectary', 'Insect-hosting structures needed for 5 chickens', 1, 'structure', 5),
	(6, 'dustbath', 'Dust bath area needed for 10 chickens', 3, 'm²', 10),
	(7, 'waterer', 'Water points needed for 5 chickens', 1, 'water point', 5);

-- Listage de la structure de table poules2_emmanuel. plan
CREATE TABLE IF NOT EXISTS `plan` (
  `id_plan` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `nbChickens` int NOT NULL,
  `dateCreation` datetime DEFAULT CURRENT_TIMESTAMP,
  `isCompleted` tinyint(1) DEFAULT '0',
  `id_user` int DEFAULT NULL,
  PRIMARY KEY (`id_plan`),
  KEY `id_user` (`id_user`),
  CONSTRAINT `plan_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `user_` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.plan : ~3 rows (environ)
INSERT INTO `plan` (`id_plan`, `name`, `nbChickens`, `dateCreation`, `isCompleted`, `id_user`) VALUES
	(1, 'Small Backyard Coop', 5, '2024-02-06 10:00:00', 1, 1),
	(2, 'Medium Family Farm', 15, '2024-02-06 11:30:00', 0, 2),
	(3, 'Large Community Coop', 25, '2024-02-06 14:15:00', 0, 3);

-- Listage de la structure de table poules2_emmanuel. plan_element
CREATE TABLE IF NOT EXISTS `plan_element` (
  `id_element` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `objectiveValue` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_element`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `plan_element_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.plan_element : ~17 rows (environ)
INSERT INTO `plan_element` (`id_element`, `type`, `objectiveValue`, `description`, `id_plan`) VALUES
	(1, 'waterer', 1, 'Main water station', 1),
	(2, 'perch', 100, 'Night roosting perch', 1),
	(3, 'shelter', 4, 'Main coop structure', 1),
	(4, 'dustbath', 1, NULL, 1),
	(5, 'shrubs', 2, 'Elderberry bushes', 1),
	(6, 'waterer', 2, 'Dual water stations', 2),
	(7, 'perch', 300, 'Extended roosting area', 2),
	(8, 'shelter', 6, 'Large shelter structure', 2),
	(9, 'dustbath', 2, 'Double dust bath area', 2),
	(10, 'shrubs', 5, 'Mixed edible hedge', 2),
	(11, 'insectary', 3, 'Bug hotels', 2),
	(12, 'waterer', 5, 'Multiple water stations', 3),
	(13, 'perch', 500, 'Full-length roosting bars', 3),
	(14, 'shelter', 9, 'Large community shelter', 3),
	(15, 'dustbath', 3, 'Multiple dust bath areas', 3),
	(16, 'shrubs', 8, 'Extensive edible hedging', 3),
	(17, 'insectary', 5, 'Distributed bug hotels', 3);

-- Listage de la structure de table poules2_emmanuel. plan_fence
CREATE TABLE IF NOT EXISTS `plan_fence` (
  `id_fence` int NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `description` text,
  `id_vertexStart` int DEFAULT NULL,
  `id_vertexEnd` int DEFAULT NULL,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_fence`),
  KEY `id_vertexStart` (`id_vertexStart`),
  KEY `id_vertexEnd` (`id_vertexEnd`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `plan_fence_ibfk_1` FOREIGN KEY (`id_vertexStart`) REFERENCES `vertex` (`id_vertex`),
  CONSTRAINT `plan_fence_ibfk_2` FOREIGN KEY (`id_vertexEnd`) REFERENCES `vertex` (`id_vertex`),
  CONSTRAINT `plan_fence_ibfk_3` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.plan_fence : ~4 rows (environ)
INSERT INTO `plan_fence` (`id_fence`, `type`, `description`, `id_vertexStart`, `id_vertexEnd`, `id_plan`) VALUES
	(1, 'wooden', 'Main enclosure wall', 1, 2, 1),
	(2, 'wooden', 'Main enclosure wall', 2, 3, 1),
	(3, 'wooden', 'Main enclosure wall', 3, 4, 1),
	(4, 'wooden', 'Main enclosure wall', 4, 1, 1),
	(5, 'wooden', 'Main enclosure wall', 15, 16, 2),
	(6, 'wooden', 'Main enclosure wall', 16, 17, 2),
	(7, 'wooden', 'Main enclosure wall', 17, 18, 2),
	(8, 'wooden', 'Main enclosure wall', 18, 15, 2),
	(9, 'wooden', 'Main enclosure wall', 27, 28, 3),
	(10, 'wooden', 'Main enclosure wall', 28, 29, 3),
	(11, 'wooden', 'Main enclosure wall', 29, 30, 3),
	(12, 'wooden', 'Main enclosure wall', 30, 27, 3);

-- Listage de la structure de table poules2_emmanuel. plan_objectives
CREATE TABLE IF NOT EXISTS `plan_objectives` (
  `id_plan` int NOT NULL,
  `id_objective` int NOT NULL,
  `completionPercentage` int DEFAULT '0',
  PRIMARY KEY (`id_plan`,`id_objective`),
  KEY `id_objective` (`id_objective`),
  CONSTRAINT `plan_objectives_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`),
  CONSTRAINT `plan_objectives_ibfk_2` FOREIGN KEY (`id_objective`) REFERENCES `objective` (`id_objective`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.plan_objectives : ~0 rows (environ)
INSERT INTO `plan_objectives` (`id_plan`, `id_objective`, `completionPercentage`) VALUES
	(1, 1, 100),
	(1, 2, 100),
	(1, 3, 100),
	(1, 4, 100),
	(1, 5, 100),
	(1, 6, 100),
	(1, 7, 100),
	(2, 1, 95),
	(2, 2, 60),
	(2, 3, 72),
	(2, 4, 87),
	(2, 5, 66),
	(2, 6, 97),
	(2, 7, 81),
	(3, 1, 44),
	(3, 2, 48),
	(3, 3, 28),
	(3, 4, 41),
	(3, 5, 27),
	(3, 6, 22),
	(3, 7, 34);

-- Listage de la structure de table poules2_emmanuel. user_
CREATE TABLE IF NOT EXISTS `user_` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.user_ : ~3 rows (environ)
INSERT INTO `user_` (`id_user`, `email`, `username`, `password`) VALUES
	(1, 'john.doe@example.com', 'JohnDoe', 'hashed_password_1'),
	(2, 'jane.smith@example.com', 'JaneSmith', 'hashed_password_2'),
	(3, 'bob.wilson@example.com', 'BobWilson', 'hashed_password_3');

-- Listage de la structure de table poules2_emmanuel. vertex
CREATE TABLE IF NOT EXISTS `vertex` (
  `id_vertex` int NOT NULL AUTO_INCREMENT,
  `positionX` decimal(15,2) NOT NULL,
  `positionY` decimal(15,2) NOT NULL,
  `id_plan` int DEFAULT NULL,
  PRIMARY KEY (`id_vertex`),
  KEY `id_plan` (`id_plan`),
  CONSTRAINT `vertex_ibfk_1` FOREIGN KEY (`id_plan`) REFERENCES `plan` (`id_plan`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

-- Listage des données de la table poules2_emmanuel.vertex : ~10 rows (environ)
INSERT INTO `vertex` (`id_vertex`, `positionX`, `positionY`, `id_plan`) VALUES
	(1, 0.00, 0.00, 1),
	(2, 10.00, 0.00, 1),
	(3, 10.00, 8.00, 1),
	(4, 0.00, 8.00, 1),
	(5, 2.00, 2.00, 1),
	(6, 3.00, 2.00, 1),
	(7, 5.00, 3.00, 1),
	(8, 7.00, 3.00, 1),
	(9, 1.00, 6.00, 1),
	(10, 4.00, 6.00, 1),
	(11, 0.00, 0.00, 2),
	(12, 15.00, 0.00, 2),
	(13, 15.00, 12.00, 2),
	(14, 0.00, 12.00, 2),
	(15, 3.00, 3.00, 2),
	(16, 4.00, 3.00, 2),
	(17, 10.00, 3.00, 2),
	(18, 11.00, 3.00, 2),
	(19, 2.00, 6.00, 2),
	(20, 8.00, 6.00, 2),
	(21, 2.00, 9.00, 2),
	(22, 7.00, 9.00, 2),
	(23, 0.00, 0.00, 3),
	(24, 20.00, 0.00, 3),
	(25, 20.00, 20.00, 3),
	(26, 0.00, 20.00, 3),
	(27, 4.00, 4.00, 3),
	(28, 5.00, 4.00, 3),
	(29, 12.00, 4.00, 3),
	(30, 13.00, 4.00, 3),
	(31, 16.00, 4.00, 3),
	(32, 17.00, 4.00, 3),
	(33, 3.00, 8.00, 3),
	(34, 15.00, 8.00, 3),
	(35, 4.00, 15.00, 3),
	(36, 12.00, 15.00, 3);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
