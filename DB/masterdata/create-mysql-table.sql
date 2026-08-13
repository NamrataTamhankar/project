/* Create following table in MySQL ‘ANLB’ database.*/

CREATE TABLE `ANLB`.`ANLB_ARCHIEF_COLLECTIEFBEHEERPLANNEN` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Plannaam` varchar(200) DEFAULT NULL,
  `Provincie` varchar(200) DEFAULT NULL,
  `Subsidiejaar` varchar(200) DEFAULT NULL,
  `Versie` varchar(200) DEFAULT NULL,
  `Locatie` varchar(200) DEFAULT NULL,
  `Status` varchar(20) DEFAULT NULL,
  `USERNAME` varchar(200) DEFAULT NULL,
  `EMAIL` varchar(200) DEFAULT NULL,
  `isDeleted` tinyint(1) NOT NULL DEFAULT '0',
  `Role` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
);