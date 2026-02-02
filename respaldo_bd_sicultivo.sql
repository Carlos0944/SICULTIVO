-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: bd_sicultivo
-- ------------------------------------------------------
-- Server version	8.4.5

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cosechas`
--

DROP TABLE IF EXISTS `cosechas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cosechas` (
  `ID_COSECHA` int NOT NULL AUTO_INCREMENT,
  `ID_CULTIVO` int DEFAULT NULL,
  `COSFECHACOSECHA` date DEFAULT NULL,
  `COSCANTIDAD` decimal(10,2) DEFAULT NULL,
  `COSCALIDAD` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `COSOBSERVACIONES` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_COSECHA`),
  KEY `FK_PRODUCE` (`ID_CULTIVO`),
  CONSTRAINT `FK_PRODUCE` FOREIGN KEY (`ID_CULTIVO`) REFERENCES `cultivos` (`ID_CULTIVO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cosechas`
--

LOCK TABLES `cosechas` WRITE;
/*!40000 ALTER TABLE `cosechas` DISABLE KEYS */;
INSERT INTO `cosechas` VALUES (1,5,'2025-01-16',180.50,'ALTA','Primera cosecha de coliflor'),(2,6,'2025-01-05',200.00,'MEDIA','Lechuga iceberg, tamaño uniforme'),(3,1,'2025-01-20',150.00,'ALTA','Primer corte de lechuga romana'),(4,3,'2025-02-01',300.75,'ALTA','Zanahoria de buen calibre'),(5,4,'2025-01-25',120.00,'MEDIA','Brócoli con ligero daño por helada'),(6,4,'2025-02-05',95.00,'ALTA','Tomate rojo firme'),(7,7,'2025-02-07',80.00,'ALTA','Pimiento de buena consistencia'),(8,9,'2025-02-10',210.00,'MEDIA','Cebolla con algo de variación en tamaño'),(9,2,'2025-02-15',130.00,'ALTA','Segundo corte de lechuga mantecosa'),(10,4,'2025-02-18',110.00,'MEDIA','Lechuga rizada en invernadero con problemas de plaga'),(11,9,'2025-12-15',750.00,'Media','Cebolla en estado perfecto'),(13,15,'2025-12-17',500.00,'ALTA','Zanahoria con buen tono de color y excelente tamaño'),(15,12,'2025-12-17',460.00,'ALTA','Excelente tamaño'),(16,11,'2025-12-18',780.00,'MEDIA','Tamaño correcto');
/*!40000 ALTER TABLE `cosechas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cultivos`
--

DROP TABLE IF EXISTS `cultivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cultivos` (
  `ID_CULTIVO` int NOT NULL AUTO_INCREMENT,
  `ID_PARCELA` int DEFAULT NULL,
  `CULNOMBRE` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CULVARIEDAD` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CULFECHASIEMBRA` date DEFAULT NULL,
  `CULCANTIDADSEMBRADA` int DEFAULT NULL,
  `CULESTADO` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CULOBSERVACIONES` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_CULTIVO`),
  KEY `FK_CONTIENE` (`ID_PARCELA`),
  CONSTRAINT `FK_CONTIENE` FOREIGN KEY (`ID_PARCELA`) REFERENCES `parcelas` (`ID_PARCELA`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cultivos`
--

LOCK TABLES `cultivos` WRITE;
/*!40000 ALTER TABLE `cultivos` DISABLE KEYS */;
INSERT INTO `cultivos` VALUES (1,12,'Lechuga Repollo','Romana','2025-01-02',500,'FINALIZADO','Siembra uniforme, buen prendimiento'),(2,1,'Lechuga Hoja Morada','Mantecosa','2025-01-10',400,'GERMINANDO','Lote reciente, requiere seguimiento'),(3,2,'Zanahoria','Nantesa','2025-01-05',800,'EN CRECIMIENTO','Buena emergencia'),(4,3,'Brócoli','Calabrese','2025-01-03',300,'EN CRECIMIENTO','Zona con ligera helada'),(5,4,'Coliflor','Snowball','2025-01-01',250,'LISTO COSECHA','Listo para primer corte'),(6,5,'Lechuga Hoja Verde','Iceberg','2024-12-20',350,'FINALIZADO','Cosecha completada'),(7,6,'Tomate','Santa Clara','2024-12-15',200,'EN CRECIMIENTO','Requiere tutorado adicional'),(8,7,'Pimiento','California','2024-12-18',180,'EN CRECIMIENTO','Buen desarrollo vegetativo'),(9,8,'Cebolla Perla','Amarilla Dulce','2024-12-22',600,'GERMINANDO','Necesita control de malezas'),(10,9,'Acelga','Rizada','2025-01-12',300,'FINALIZADO','Cultivo con problemas de plaga'),(11,9,'col','Milan','2025-12-14',100,'EN CRECIMIENTO','Cultivo en Desarrollo'),(12,6,'Romanesco','veronica','2025-12-14',70,'EN CRECIMIENTO','Cultivo en campo abierto'),(15,7,'Zanahoria','Salchicha','2025-12-03',550,'EN CRECIMIENTO','Requiere  de bastante humedad');
/*!40000 ALTER TABLE `cultivos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `historialacciones`
--

DROP TABLE IF EXISTS `historialacciones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `historialacciones` (
  `ID_HISTORIAL` int NOT NULL AUTO_INCREMENT,
  `ID_USUARIO` int DEFAULT NULL,
  `HISTTABLAAFECTADA` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HISTACCION` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HISTDESCRIPCION` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `HISTFECHAHORA` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_HISTORIAL`),
  KEY `FK_GENERA` (`ID_USUARIO`),
  CONSTRAINT `FK_GENERA` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=212 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historialacciones`
--

LOCK TABLES `historialacciones` WRITE;
/*!40000 ALTER TABLE `historialacciones` DISABLE KEYS */;
INSERT INTO `historialacciones` VALUES (1,1,'USUARIOS','INSERT','Creación del usuario administrador','2025-01-10 13:35:00'),(2,1,'PARCELAS','INSERT','Registro inicial de parcelas de La Esperanza','2025-01-10 14:00:00'),(3,2,'CULTIVOS','INSERT','Registro de cultivo de lechuga romana','2025-01-10 14:10:00'),(4,3,'TAREAS','INSERT','Programación de riego para cultivo 1','2025-01-11 12:50:00'),(5,3,'TAREAS','UPDATE','Marcar tarea de riego como ejecutada','2025-01-11 13:30:00'),(6,5,'COSECHAS','INSERT','Registro de cosecha de coliflor','2025-01-16 22:10:00'),(7,2,'CULTIVOS','UPDATE','Actualización de estado a LISTO COSECHA','2025-01-15 21:00:00'),(8,4,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-01-18 12:30:00'),(9,1,'HISTORIALACCIONES','INSERT','Prueba de registro en historial','2025-01-19 15:00:00'),(10,2,'PARCELAS','UPDATE','Cambio de estado de Parcela E a INACTIVO','2025-01-20 16:45:00'),(11,5,'cultivos','INSERT','Se registró un nuevo cultivo: Romanesco','2025-12-15 14:20:00'),(12,5,'tareas','INSERT','Nueva tarea: Riego / Cultivo 11','2025-12-15 14:27:54'),(13,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 14:38:57'),(14,2,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 14:40:30'),(15,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 14:40:38'),(16,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:16:05'),(17,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:26:28'),(18,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:36:05'),(19,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:43:46'),(20,5,'usuarios','INSERT','Se registró un nuevo usuario: Carlos@sicultivo.com','2025-12-15 15:45:29'),(21,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:45:59'),(22,13,'usuarios','INSERT','Se registró un nuevo usuario: maria@sicultivo.com','2025-12-15 15:52:31'),(23,14,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:52:47'),(24,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 15:59:14'),(25,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 16:08:14'),(26,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 16:10:08'),(27,13,'usuarios','INSERT','Se registró un nuevo usuario: Diego@sicultivo.com','2025-12-15 16:10:43'),(28,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 16:13:24'),(29,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 16:19:11'),(30,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 20:37:41'),(31,5,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 21:25:59'),(32,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-15 23:42:10'),(33,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 00:17:15'),(34,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 01:09:26'),(35,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 14:44:44'),(36,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 14:54:54'),(37,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 14:58:08'),(38,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 15:19:41'),(39,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 15:28:03'),(40,13,'parcelas','INSERT','Se registró una nueva parcela: Parcela Tabacundo','2025-12-16 15:29:33'),(41,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:08:16'),(42,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:29:59'),(43,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:31:19'),(44,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:34:42'),(45,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:41:28'),(46,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 16:55:00'),(47,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 17:14:22'),(48,15,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 17:16:25'),(49,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 17:43:13'),(50,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 17:58:03'),(51,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 18:26:45'),(52,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 18:29:55'),(53,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 18:54:32'),(54,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 18:57:32'),(55,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 18:59:29'),(56,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:08:12'),(57,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:09:37'),(58,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:12:19'),(59,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:15:32'),(60,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:16:43'),(61,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:18:55'),(62,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:36:21'),(63,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:37:56'),(64,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 19:41:25'),(65,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 21:25:53'),(66,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 23:35:43'),(67,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 23:42:40'),(68,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-16 23:44:15'),(69,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 00:20:33'),(70,15,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 00:38:19'),(71,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 01:06:26'),(72,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 01:35:03'),(73,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 01:51:45'),(74,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 02:17:11'),(75,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 02:23:50'),(76,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 15:05:44'),(77,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 15:14:56'),(78,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 15:21:14'),(79,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 15:40:02'),(80,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 15:50:02'),(81,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 16:09:22'),(82,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 16:13:02'),(83,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 16:22:38'),(84,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 16:37:09'),(85,13,'cultivos','INSERT','Se registró un nuevo cultivo: Cebolla paiteÃ±a','2025-12-17 16:37:58'),(86,13,'cultivos','INSERT','Se registró un nuevo cultivo: Pimiento','2025-12-17 16:41:20'),(87,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 16:56:37'),(88,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:00:36'),(89,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:01:32'),(90,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:04:01'),(91,13,'tareas','INSERT','Nueva tarea: null / Cultivo 14','2025-12-17 17:05:16'),(92,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:14:14'),(93,13,'tareas','INSERT','Nueva tarea: DESHIERBE / Cultivo 13','2025-12-17 17:15:41'),(94,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:35:31'),(95,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 14)','2025-12-17 17:38:26'),(96,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:40:19'),(97,13,'parcelas','INSERT','Se registró una nueva parcela: Parcela La Esperanza','2025-12-17 17:40:59'),(98,13,'cultivos','INSERT','Se registró un nuevo cultivo: Zanahoria','2025-12-17 17:42:52'),(99,13,'tareas','INSERT','Nueva tarea: RIEGO / Cultivo 15','2025-12-17 17:43:53'),(100,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 15)','2025-12-17 17:45:03'),(101,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:54:22'),(102,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 13)','2025-12-17 17:55:02'),(103,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 17:59:19'),(104,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 12)','2025-12-17 17:59:56'),(105,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 18:01:59'),(106,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 11)','2025-12-17 18:02:28'),(107,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 18:19:59'),(108,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 18:28:02'),(109,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 18:29:23'),(110,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 18:42:33'),(111,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 19:45:21'),(112,13,'cosechas','INSERT','Nueva cosecha registrada (Cultivo ID: 8)','2025-12-17 19:46:34'),(113,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-17 20:06:07'),(114,13,'tareas','INSERT','Nueva tarea: FERTILIZACION / Cultivo 15','2025-12-17 20:07:28'),(115,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-18 20:53:07'),(116,15,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-18 20:53:20'),(117,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-19 02:55:43'),(118,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-19 21:37:06'),(119,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-29 18:58:35'),(120,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-29 20:12:33'),(121,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-30 00:17:19'),(122,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2025-12-30 00:20:17'),(123,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:08:19'),(124,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:21:58'),(125,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:24:45'),(127,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:55:09'),(128,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:57:09'),(129,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 19:58:07'),(130,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 20:07:20'),(131,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 20:39:52'),(132,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 20:40:08'),(133,13,'COSECHAS','LOGIN','Inicio de sesion exitoso','2026-01-04 05:53:37'),(134,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:11:34'),(136,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:17:39'),(137,1,'USUARIOS','LOGIN','Inicio de sesion exitoso','2026-01-04 21:23:40'),(138,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:38:39'),(139,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:45:58'),(140,15,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:52:16'),(141,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 21:52:53'),(142,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 22:07:04'),(143,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 22:14:18'),(144,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 22:33:56'),(145,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 22:53:47'),(146,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 23:00:02'),(147,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-04 18:12:37'),(148,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-06 00:43:10'),(149,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-06 01:04:46'),(150,1,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-08 23:11:51'),(151,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-08 23:56:30'),(152,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 00:12:23'),(153,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 00:15:36'),(154,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 00:28:38'),(155,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 01:14:39'),(156,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 15:51:56'),(157,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 15:55:27'),(158,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 15:56:46'),(159,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 16:01:31'),(160,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 16:07:18'),(161,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 16:27:54'),(162,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 17:01:05'),(163,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 17:22:38'),(164,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 17:36:48'),(165,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 17:47:35'),(166,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 18:02:32'),(167,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-09 18:05:48'),(168,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-11 20:33:57'),(174,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 01:30:21'),(175,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 14:00:35'),(177,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 15:30:49'),(178,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 16:33:44'),(179,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 18:52:10'),(181,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 18:55:06'),(183,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 18:56:24'),(185,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:04:58'),(186,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:07:12'),(188,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:09:42'),(190,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:11:26'),(192,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:28:26'),(194,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 19:38:11'),(196,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-12 23:43:00'),(197,13,'TAREAS','UPDATE','Se actualizó una tarea ','2026-01-13 00:02:46'),(198,13,'COSECHAS','UPDATE','Se actualizó una cosecha  ','2026-01-13 00:03:45'),(199,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 00:42:11'),(200,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 00:55:14'),(201,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 00:58:55'),(202,13,'COSECHAS','INSERT','Nueva cosecha registrada ','2026-01-13 00:59:51'),(203,13,'COSECHAS','UPDATE','Se actualizó una cosecha  ','2026-01-13 01:00:20'),(204,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 15:54:01'),(205,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:03:17'),(206,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:04:02'),(207,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:08:31'),(208,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:18:02'),(209,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:49:15'),(210,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 17:56:51'),(211,13,'USUARIOS','LOGIN','Inicio de sesión exitoso','2026-01-13 18:01:52');
/*!40000 ALTER TABLE `historialacciones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parcelas`
--

DROP TABLE IF EXISTS `parcelas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `parcelas` (
  `ID_PARCELA` int NOT NULL AUTO_INCREMENT,
  `ID_USUARIO` int DEFAULT NULL,
  `PARNOMBRE` varchar(80) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PARUBICACION` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PARAREA` decimal(10,2) DEFAULT NULL,
  `PARTIPOSUELO` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PARESTADO` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `PARFECHACREADO` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_PARCELA`),
  KEY `FK_GESTIONA` (`ID_USUARIO`),
  CONSTRAINT `FK_GESTIONA` FOREIGN KEY (`ID_USUARIO`) REFERENCES `usuarios` (`ID_USUARIO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parcelas`
--

LOCK TABLES `parcelas` WRITE;
/*!40000 ALTER TABLE `parcelas` DISABLE KEYS */;
INSERT INTO `parcelas` VALUES (1,1,'Parcela A','La Esperanza',1550.00,'Franco Arenoso','ACTIVO','2025-01-12 22:00:00'),(2,1,'Parcela B','La Esperanza',1200.50,'Franco Arcilloso','ACTIVO','2025-01-06 08:00:00'),(3,2,'Parcela C','La Esperanza',800.75,'Arenoso','ACTIVO','2025-01-07 08:00:00'),(4,2,'Parcela D','La Esperanza',950.20,'Franco','ACTIVO','2025-01-08 08:00:00'),(5,3,'Parcela E','La Esperanza',600.00,'Arcilloso','INACTIVO','2025-01-09 08:00:00'),(6,3,'Parcela F','La Esperanza',2000.00,'Franco Arenoso','ACTIVO','2025-01-10 08:00:00'),(7,4,'Parcela G','La Esperanza',1750.00,'Franco','ACTIVO','2025-01-11 08:00:00'),(8,4,'Parcela H','La Esperanza',900.00,'Franco Arcilloso','ACTIVO','2025-01-12 08:00:00'),(9,9,'Parcela I','La Esperanza - Invernadero 1',500.00,'Sustrato Mezcla','ACTIVO','2025-01-13 08:00:00'),(10,9,'Parcela J','La Esperanza - Invernadero 2',450.00,'Sustrato Mezcla','ACTIVO','2025-01-14 08:00:00'),(11,5,'Parcela K','La Esperanza',800.00,'Arcilloso','ACTIVO','2025-01-14 08:00:00'),(12,5,'Parcela L','La esperanza',950.23,'Franco limoso','ACTIVO','2025-12-14 18:35:21');
/*!40000 ALTER TABLE `parcelas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `ID_ROL` int NOT NULL AUTO_INCREMENT,
  `ROLNOMBRE` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_ROL`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMINISTRADOR'),(2,'OPERARIO'),(3,'ADMINISTRADOR'),(4,'OPERARIO'),(5,'ADMINISTRADOR'),(6,'OPERARIO'),(7,'ADMINISTRADOR'),(8,'OPERARIO'),(9,'ADMINISTRADOR'),(10,'ADMINISTRADOR');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tareas`
--

DROP TABLE IF EXISTS `tareas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tareas` (
  `ID_TAREA` int NOT NULL AUTO_INCREMENT,
  `ID_CULTIVO` int DEFAULT NULL,
  `TARETIPO` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TAREFECHAPROGRAMADA` date DEFAULT NULL,
  `TARERESPONSABLE` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TAREESTADO` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `TAREFECHAEJECUCION` date DEFAULT NULL,
  `TAREOBSERVACIONES` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID_TAREA`),
  KEY `FK_REQUIERE` (`ID_CULTIVO`),
  CONSTRAINT `FK_REQUIERE` FOREIGN KEY (`ID_CULTIVO`) REFERENCES `cultivos` (`ID_CULTIVO`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tareas`
--

LOCK TABLES `tareas` WRITE;
/*!40000 ALTER TABLE `tareas` DISABLE KEYS */;
INSERT INTO `tareas` VALUES (1,1,'RIEGO','2025-01-03','Juan Pérez','EJECUTADA','2025-01-03','Riego por aspersión 30 minutos'),(2,1,'FERTILIZACION','2025-01-07','Carlos Rivera','EJECUTADA','2025-01-07','Aplicación NPK 15-15-15'),(3,2,'RIEGO','2025-01-11','Ana Torres','PENDIENTE','2025-01-07','Programar riego temprano'),(4,3,'DESHIERBE','2025-01-10','Lucía Martínez','EJECUTADA','2025-01-10','Control manual de malezas'),(5,4,'RIEGO','2025-01-06','Juan Pérez','EJECUTADA','2025-01-06','Riego por goteo'),(6,5,'COSECHA','2025-01-15','María López','PENDIENTE','2025-01-07','Preparar personal para corte'),(7,7,'TUTORADO','2025-01-08','Pedro Gómez','EJECUTADA','2025-01-08','Instalación de tutores'),(8,5,'FUMIGACION','2025-01-08','Carlos Rivera','EJECUTADA','2025-01-08','Control preventivo de plagas'),(9,9,'DESHIERBE','2025-01-13','Ana Torres','PENDIENTE','2025-01-07','Maleza en borde de surcos'),(10,10,'RIEGO','2025-01-14','Gustavo Chorlango','PENDIENTE','2025-01-07','Riego por microaspersión'),(11,11,'DESHIERBE','2025-12-14','Maria Criollo','PENDIENTE','2025-12-15','Riego por aspersion'),(14,15,'RIEGO','2025-12-16','Maria Criollo','PENDIENTE','2025-12-17','Riego por aspersion');
/*!40000 ALTER TABLE `tareas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `ID_USUARIO` int NOT NULL AUTO_INCREMENT,
  `ID_ROL` int DEFAULT NULL,
  `USUNOMBRE` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `USUCORREO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `USUCLAVE_HASH` char(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `USUESTADO` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `USUFECHACREADO` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_USUARIO`),
  KEY `FK_PERTENECE` (`ID_ROL`),
  CONSTRAINT `FK_PERTENECE` FOREIGN KEY (`ID_ROL`) REFERENCES `roles` (`ID_ROL`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,1,'Gustavo Chorlango Perez','gustavo@cultivos.com','3452634','ACTIVO','2026-01-05 00:00:00'),(2,2,'María López','maria@cultivos.com','265463','ACTIVO','2025-01-11 09:00:00'),(3,3,'Juan Pérez','juan@cultivos.com','234563','ACTIVO','2025-01-12 07:45:00'),(4,3,'Ana Torres','ana@cultivos.com','78654','ACTIVO','2025-01-12 08:10:00'),(5,1,'Administrador General','admin@cultivos.com','8857','ACTIVO','2025-01-13 10:20:00'),(7,2,'Supervisor 1','supervisor1@cultivos.com','123456789','ACTIVO','2025-01-15 09:40:00'),(8,2,'Supervisor 2','supervisor2@cultivos.com','4536372','ACTIVO','2025-01-16 08:55:00'),(9,5,'Agrónomo Invitado','agronomo@cultivos.com','234567','INACTIVO','2025-01-17 07:30:00'),(10,6,'Tecnico Auxiliar','tecnico@cultivos.com','75645','ACTIVO','2025-01-18 12:00:00'),(11,1,'admin','admin@correo.com','12345','ACTIVO','2025-12-14 00:04:16'),(12,2,'admin','admin@sicultivo.com','12345','ACTIVO','2025-12-14 15:32:47'),(13,1,'Carlos Chorlango','carlos_chorlango@sicultivo.com','12345','ACTIVO','2026-01-05 00:00:00'),(14,2,'Maria Guachamin','maria@sicultivo.com','123','ACTIVO','2026-01-12 00:00:00'),(15,2,'Diego Chapi','Diego@sicultivo.com','123456789','ACTIVO','2026-01-11 00:00:00');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_cosechas_detalle`
--

DROP TABLE IF EXISTS `vw_cosechas_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_cosechas_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cosechas_detalle` AS SELECT 
 1 AS `ID_COSECHA`,
 1 AS `COSFECHACOSECHA`,
 1 AS `COSCANTIDAD`,
 1 AS `COSCALIDAD`,
 1 AS `COSOBSERVACIONES`,
 1 AS `ID_CULTIVO`,
 1 AS `NOMBRE_CULTIVO`,
 1 AS `VARIEDAD_CULTIVO`,
 1 AS `ID_PARCELA`,
 1 AS `NOMBRE_PARCELA`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_cultivos_detalle`
--

DROP TABLE IF EXISTS `vw_cultivos_detalle`;
/*!50001 DROP VIEW IF EXISTS `vw_cultivos_detalle`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_cultivos_detalle` AS SELECT 
 1 AS `ID_CULTIVO`,
 1 AS `CULNOMBRE`,
 1 AS `CULVARIEDAD`,
 1 AS `CULFECHASIEMBRA`,
 1 AS `CULCANTIDADSEMBRADA`,
 1 AS `CULESTADO`,
 1 AS `CULOBSERVACIONES`,
 1 AS `ID_PARCELA`,
 1 AS `NOMBRE_PARCELA`,
 1 AS `UBICACION_PARCELA`,
 1 AS `AREA_PARCELA`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_historial_acciones`
--

DROP TABLE IF EXISTS `vw_historial_acciones`;
/*!50001 DROP VIEW IF EXISTS `vw_historial_acciones`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_historial_acciones` AS SELECT 
 1 AS `ID_HISTORIAL`,
 1 AS `HISTTABLAAFECTADA`,
 1 AS `HISTACCION`,
 1 AS `HISTDESCRIPCION`,
 1 AS `HISTFECHAHORA`,
 1 AS `ID_USUARIO`,
 1 AS `USUARIO`,
 1 AS `CORREO_USUARIO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_parcelas_responsable`
--

DROP TABLE IF EXISTS `vw_parcelas_responsable`;
/*!50001 DROP VIEW IF EXISTS `vw_parcelas_responsable`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_parcelas_responsable` AS SELECT 
 1 AS `ID_PARCELA`,
 1 AS `PARNOMBRE`,
 1 AS `PARUBICACION`,
 1 AS `PARAREA`,
 1 AS `PARTIPOSUELO`,
 1 AS `PARESTADO`,
 1 AS `PARFECHACREADO`,
 1 AS `ID_RESPONSABLE`,
 1 AS `RESPONSABLE`,
 1 AS `CORREO_RESPONSABLE`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_tareas_agricolas`
--

DROP TABLE IF EXISTS `vw_tareas_agricolas`;
/*!50001 DROP VIEW IF EXISTS `vw_tareas_agricolas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_tareas_agricolas` AS SELECT 
 1 AS `ID_TAREA`,
 1 AS `TARETIPO`,
 1 AS `TAREFECHAPROGRAMADA`,
 1 AS `TARERESPONSABLE`,
 1 AS `TAREESTADO`,
 1 AS `TAREFECHAEJECUCION`,
 1 AS `TAREOBSERVACIONES`,
 1 AS `ID_CULTIVO`,
 1 AS `NOMBRE_CULTIVO`,
 1 AS `VARIEDAD_CULTIVO`,
 1 AS `ID_PARCELA`,
 1 AS `NOMBRE_PARCELA`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_usuarios_activos`
--

DROP TABLE IF EXISTS `vw_usuarios_activos`;
/*!50001 DROP VIEW IF EXISTS `vw_usuarios_activos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_usuarios_activos` AS SELECT 
 1 AS `ID_USUARIO`,
 1 AS `USUNOMBRE`,
 1 AS `USUCORREO`,
 1 AS `USUESTADO`,
 1 AS `USUFECHACREADO`,
 1 AS `ROL`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_cosechas_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_cosechas_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cosechas_detalle` AS select `co`.`ID_COSECHA` AS `ID_COSECHA`,`co`.`COSFECHACOSECHA` AS `COSFECHACOSECHA`,`co`.`COSCANTIDAD` AS `COSCANTIDAD`,`co`.`COSCALIDAD` AS `COSCALIDAD`,`co`.`COSOBSERVACIONES` AS `COSOBSERVACIONES`,`c`.`ID_CULTIVO` AS `ID_CULTIVO`,`c`.`CULNOMBRE` AS `NOMBRE_CULTIVO`,`c`.`CULVARIEDAD` AS `VARIEDAD_CULTIVO`,`p`.`ID_PARCELA` AS `ID_PARCELA`,`p`.`PARNOMBRE` AS `NOMBRE_PARCELA` from ((`cosechas` `co` join `cultivos` `c` on((`co`.`ID_CULTIVO` = `c`.`ID_CULTIVO`))) join `parcelas` `p` on((`c`.`ID_PARCELA` = `p`.`ID_PARCELA`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_cultivos_detalle`
--

/*!50001 DROP VIEW IF EXISTS `vw_cultivos_detalle`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_cultivos_detalle` AS select `c`.`ID_CULTIVO` AS `ID_CULTIVO`,`c`.`CULNOMBRE` AS `CULNOMBRE`,`c`.`CULVARIEDAD` AS `CULVARIEDAD`,`c`.`CULFECHASIEMBRA` AS `CULFECHASIEMBRA`,`c`.`CULCANTIDADSEMBRADA` AS `CULCANTIDADSEMBRADA`,`c`.`CULESTADO` AS `CULESTADO`,`c`.`CULOBSERVACIONES` AS `CULOBSERVACIONES`,`p`.`ID_PARCELA` AS `ID_PARCELA`,`p`.`PARNOMBRE` AS `NOMBRE_PARCELA`,`p`.`PARUBICACION` AS `UBICACION_PARCELA`,`p`.`PARAREA` AS `AREA_PARCELA` from (`cultivos` `c` join `parcelas` `p` on((`c`.`ID_PARCELA` = `p`.`ID_PARCELA`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_historial_acciones`
--

/*!50001 DROP VIEW IF EXISTS `vw_historial_acciones`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_historial_acciones` AS select `h`.`ID_HISTORIAL` AS `ID_HISTORIAL`,`h`.`HISTTABLAAFECTADA` AS `HISTTABLAAFECTADA`,`h`.`HISTACCION` AS `HISTACCION`,`h`.`HISTDESCRIPCION` AS `HISTDESCRIPCION`,`h`.`HISTFECHAHORA` AS `HISTFECHAHORA`,`u`.`ID_USUARIO` AS `ID_USUARIO`,`u`.`USUNOMBRE` AS `USUARIO`,`u`.`USUCORREO` AS `CORREO_USUARIO` from (`historialacciones` `h` join `usuarios` `u` on((`h`.`ID_USUARIO` = `u`.`ID_USUARIO`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_parcelas_responsable`
--

/*!50001 DROP VIEW IF EXISTS `vw_parcelas_responsable`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_parcelas_responsable` AS select `p`.`ID_PARCELA` AS `ID_PARCELA`,`p`.`PARNOMBRE` AS `PARNOMBRE`,`p`.`PARUBICACION` AS `PARUBICACION`,`p`.`PARAREA` AS `PARAREA`,`p`.`PARTIPOSUELO` AS `PARTIPOSUELO`,`p`.`PARESTADO` AS `PARESTADO`,`p`.`PARFECHACREADO` AS `PARFECHACREADO`,`u`.`ID_USUARIO` AS `ID_RESPONSABLE`,`u`.`USUNOMBRE` AS `RESPONSABLE`,`u`.`USUCORREO` AS `CORREO_RESPONSABLE` from (`parcelas` `p` join `usuarios` `u` on((`p`.`ID_USUARIO` = `u`.`ID_USUARIO`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_tareas_agricolas`
--

/*!50001 DROP VIEW IF EXISTS `vw_tareas_agricolas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_tareas_agricolas` AS select `t`.`ID_TAREA` AS `ID_TAREA`,`t`.`TARETIPO` AS `TARETIPO`,`t`.`TAREFECHAPROGRAMADA` AS `TAREFECHAPROGRAMADA`,`t`.`TARERESPONSABLE` AS `TARERESPONSABLE`,`t`.`TAREESTADO` AS `TAREESTADO`,`t`.`TAREFECHAEJECUCION` AS `TAREFECHAEJECUCION`,`t`.`TAREOBSERVACIONES` AS `TAREOBSERVACIONES`,`c`.`ID_CULTIVO` AS `ID_CULTIVO`,`c`.`CULNOMBRE` AS `NOMBRE_CULTIVO`,`c`.`CULVARIEDAD` AS `VARIEDAD_CULTIVO`,`p`.`ID_PARCELA` AS `ID_PARCELA`,`p`.`PARNOMBRE` AS `NOMBRE_PARCELA` from ((`tareas` `t` join `cultivos` `c` on((`t`.`ID_CULTIVO` = `c`.`ID_CULTIVO`))) join `parcelas` `p` on((`c`.`ID_PARCELA` = `p`.`ID_PARCELA`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_usuarios_activos`
--

/*!50001 DROP VIEW IF EXISTS `vw_usuarios_activos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_usuarios_activos` AS select `u`.`ID_USUARIO` AS `ID_USUARIO`,`u`.`USUNOMBRE` AS `USUNOMBRE`,`u`.`USUCORREO` AS `USUCORREO`,`u`.`USUESTADO` AS `USUESTADO`,`u`.`USUFECHACREADO` AS `USUFECHACREADO`,`r`.`ROLNOMBRE` AS `ROL` from (`usuarios` `u` join `roles` `r` on((`u`.`ID_ROL` = `r`.`ID_ROL`))) where (`u`.`USUESTADO` = 'ACTIVO') */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-16 19:20:39
