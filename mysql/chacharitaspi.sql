CREATE DATABASE IF NOT EXISTS `chacharitaspi`;
USE `chacharitaspi`;

-- Table structure for table `addresses`
DROP TABLE IF EXISTS `addresses`;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `street` varchar(50) DEFAULT NULL,
  `neighborhood` varchar(75) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `addresses` VALUES (1,'5 de Febrero','Cimatario','76000','Querétaro','México');

-- Table structure for table `brands`
DROP TABLE IF EXISTS `brands`;
CREATE TABLE `brands` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_brand` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `brands` VALUES (1,'Carter\'s'), (2,'No etiquetada');

-- Table structure for table `categories`
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type_category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `categories` VALUES (1,'Ropa'),(2,'Calzado'),(3,'Accesorios');

-- Table structure for table `clients`
DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `password` varchar(25) DEFAULT NULL,
  `id_gender` int DEFAULT NULL,
  `id_address` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_clients_gender` FOREIGN KEY (`id_gender`) REFERENCES `genders` (`id`),
  CONSTRAINT `fk_clients_address` FOREIGN KEY (`id_address`) REFERENCES `addresses` (`id`)
);

-- Table structure for table `colors`
DROP TABLE IF EXISTS `colors`;
CREATE TABLE `colors` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `colors` VALUES (1,'Rojo'),(2,'Azul'),(3,'Amarillo');

-- Table structure for table `genders`
DROP TABLE IF EXISTS `genders`;
CREATE TABLE `genders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `genders` VALUES (1,'Hombre'),(2,'Mujer');

-- Table structure for table `materials`
DROP TABLE IF EXISTS `materials`;
CREATE TABLE `materials` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_material` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

-- Table structure for table `orders`
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `total_price` int DEFAULT NULL,
  `payment` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `orders` VALUES (1,'2024-03-19 00:00:00',100,'Tarjeta de crédito');

-- Table structure for table `products`
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(75) DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `price` int DEFAULT NULL,
  `id_color` int DEFAULT NULL,
  `id_category` int DEFAULT NULL,
  `id_size` int DEFAULT NULL,
  `id_material` int DEFAULT NULL,
  `id_brand` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_products_color` FOREIGN KEY (`id_color`) REFERENCES `colors` (`id`),
  CONSTRAINT `fk_products_category` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id`),
  CONSTRAINT `fk_products_material` FOREIGN KEY (`id_material`) REFERENCES `materials` (`id`),
  CONSTRAINT `fk_products_brand` FOREIGN KEY (`id_brand`) REFERENCES `brands` (`id`)
);

INSERT INTO `products` VALUES (1,'Mameluco',1,100,1,1,1,1,1);

-- Table structure for table `sizes`
DROP TABLE IF EXISTS `sizes`;
CREATE TABLE `sizes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `size_cloth` varchar(20) DEFAULT NULL,
  `size_shoe` varchar(20) DEFAULT NULL,
  `dimensions` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `sizes` VALUES (1,'Recien Nacido','No aplica','No aplica');

-- Table structure for table `subscriptions`
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `renovation_date` date DEFAULT NULL,
  `initial_date` date DEFAULT NULL,
  `id_client` int DEFAULT NULL,
  `id_type_subscription` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_subscriptions_client` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_subscriptions_type` FOREIGN KEY (`id_type_subscription`) REFERENCES `type_subscriptions` (`id`)
);

INSERT INTO `subscriptions` VALUES (1,'2024-04-17','2024-03-17',1,1),(2,'2024-04-18','2024-03-18',2,3);

-- Table structure for table `type_subscriptions`
DROP TABLE IF EXISTS `type_subscriptions`;
CREATE TABLE `type_subscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `price` int DEFAULT NULL,
  PRIMARY KEY (`id`)
);

INSERT INTO `type_subscriptions` (`name`, `price`) VALUES ('Free', 0), ('Lil Baby', 60), ('Spoiled Baby', 180);

select * from clients;