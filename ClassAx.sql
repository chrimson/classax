-- MySQL dump 10.13  Distrib 5.5.58, for linux-glibc2.12 (x86_64)
--
-- Host: localhost    Database: ClassAx
-- ------------------------------------------------------
-- Server version	5.5.58

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cars`
--

DROP TABLE IF EXISTS `Cars`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cars` (
  `SCCA` varchar(20) DEFAULT NULL,
  `NCC` varchar(20) DEFAULT NULL,
  `CDC` varchar(20) DEFAULT NULL,
  `Year` smallint(6) DEFAULT NULL,
  `Make` varchar(40) DEFAULT NULL,
  `Model` varchar(40) DEFAULT NULL,
  `Trim` varchar(20) DEFAULT NULL,
  `HP` smallint(6) DEFAULT NULL,
  `Weight` smallint(6) DEFAULT NULL,
  `Brand` varchar(40) DEFAULT NULL,
  `Product` varchar(40) DEFAULT NULL,
  `Width` smallint(6) DEFAULT NULL,
  `Sidewall` tinyint(4) DEFAULT NULL,
  `Diameter` tinyint(4) DEFAULT NULL,
  `UTQG` smallint(6) DEFAULT NULL,
  `Other` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cars`
--

LOCK TABLES `Cars` WRITE;
/*!40000 ALTER TABLE `Cars` DISABLE KEYS */;
INSERT INTO `Cars` VALUES ('HS','','',2017,'Ford','Fiesta','ST',197,2700,'Bridgestone','Potenza RE050A',205,40,17,140,''),('CS','','',2004,'Mazda','MX5','Mazdaspeed',97,700,'','',105,40,17,200,'Too many to list'),('HS','S2',NULL,2013,'MINI','Cooper','Roadster S',181,2700,'Dunlop','Direzza ZII',205,45,17,200,'one-touch window up'),('BS','','',2000,'','S2000','',300,2500,'','',200,40,17,200,''),('BS',NULL,NULL,2016,'Mazda','MX5',NULL,NULL,2400,NULL,NULL,NULL,NULL,NULL,200,NULL),('DS',NULL,NULL,2015,'MINI','Cooper','S',181,2600,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `Cars` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Username` varchar(40) DEFAULT NULL,
  `Password` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES ('chrimson','auF65dWGOtmc2'),('kemosabe','auMGiwMcj0Zus');
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-08 17:14:24
