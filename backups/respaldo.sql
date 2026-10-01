

CREATE DATABASE IF NOT EXISTS `db_test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_test`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;





-- Estructura de tabla para `tb_logs`



DROP TABLE IF EXISTS `tb_logs`;
CREATE TABLE `tb_logs` (
`ID` INT NOT NULL AUTO_INCREMENT,
`table_name` VARCHAR(100) NOT NULL,
`operation` ENUM('Create','Read','Update','Delete') NOT NULL,
`db_users` VARCHAR(80) NOT NULL,
`description` TEXT NOT NULL,
`operation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`operation_status` BIT(1) DEFAULT b'1',
PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Estructura de tabla para `tb_products`



DROP TABLE IF EXISTS `tb_products`;
CREATE TABLE `tb_products` (
`ID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
`SKU` VARCHAR(50) NOT NULL,
`name` VARCHAR(250) NOT NULL,
`description` TEXT,
`current_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
`current_stock` INT UNSIGNED NOT NULL DEFAULT '0',
`status` TINYINT(1) NOT NULL DEFAULT '1',
`creation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`last_update` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (`ID`),
UNIQUE KEY `SKU` (`SKU`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Estructura de tabla para `tb_users`



DROP TABLE IF EXISTS `tb_users`;
CREATE TABLE `tb_users` (
`ID` INT NOT NULL AUTO_INCREMENT,
`email` VARCHAR(80) NOT NULL,
`nickname` VARCHAR(100) NOT NULL,
`password` VARCHAR(255) NOT NULL,
`creation_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
`last_update` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
`last_login` DATETIME DEFAULT NULL,
PRIMARY KEY (`ID`),
UNIQUE KEY `email` (`email`),
UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- Triggers para `tb_products`



DELIMITER ;;
CREATE TRIGGER `trg_after_insert_tb_products` AFTER INSERT ON `tb_products` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_products', 'Create', USER(),
CONCAT('Producto creado. ID=', NEW.ID, ', SKU=', NEW.SKU, ', name=', NEW.name, ', precio=', NEW.current_price, ', stock=', NEW.current_stock));
END ;;

CREATE TRIGGER `trg_after_update_tb_products` AFTER UPDATE ON `tb_products` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_products', 'Update', USER(),
CONCAT('Producto actualizado. ID=', NEW.ID, ', SKU=', NEW.SKU, ', name=', NEW.name, ', precio=', NEW.current_price, ', stock=', NEW.current_stock));
END ;;

CREATE TRIGGER `trg_after_delete_tb_products` AFTER DELETE ON `tb_products` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_products', 'Delete', USER(),
CONCAT('Producto eliminado. ID=', OLD.ID, ', SKU=', OLD.SKU, ', name=', OLD.name, ', precio=', OLD.current_price, ', stock=', OLD.current_stock));
END ;;
DELIMITER ;



-- Triggers para `tb_users`



DELIMITER ;;
CREATE TRIGGER `trg_after_insert_tb_users` AFTER INSERT ON `tb_users` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_users', 'Create', USER(),
CONCAT('Usuario creado. ID=', NEW.ID, ', email=', NEW.email, ', nickname=', NEW.nickname));
END ;;

CREATE TRIGGER `trg_after_update_tb_users` AFTER UPDATE ON `tb_users` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_users', 'Update', USER(),
CONCAT('Usuario actualizado. ID=', NEW.ID, ', email=', NEW.email, ', nickname=', NEW.nickname));
END ;;

CREATE TRIGGER `trg_after_delete_tb_users` AFTER DELETE ON `tb_users` FOR EACH ROW BEGIN
INSERT INTO tb_logs (table_name, operation, db_users, description)
VALUES ('tb_users', 'Delete', USER(),
CONCAT('Usuario eliminado. ID=', OLD.ID, ', email=', OLD.email, ', nickname=', OLD.nickname));
END ;;
DELIMITER ;



-- Volcado de datos para `tb_users` y `tb_products`



INSERT INTO `tb_users` (`ID`, `email`, `nickname`, `password`, `creation_date`, `last_update`, `last_login`) VALUES
(1, 'saramelendez@gmail.com', 'admin', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(2, 'marco.ramirez@gmail.com', 'marco.ramirez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(3, 'harold.ramirez@gmail.com', 'harold.ramirez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(4, 'vane.vergara@gmail.com', 'vane.vergara', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(5, 'samuel.ramirez@gmail.com', 'samuel.ramirez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(6, 'may.gutierrez@gmail.com', 'may.gutierrez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(7, 'blanca.torres@gmail.com', 'blanca.torres', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(8, 'dulce.ramirez@gmail.com', 'dulce.ramirez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(9, 'jaz.ramirez@test.com', 'jaz.ramirez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL),
(10, 'zury.gutierrez@gmail.com', 'zury.gutierrez', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', NOW(), NOW(), NULL);

INSERT INTO `tb_products` (`ID`, `SKU`, `name`, `description`, `current_price`, `current_stock`, `status`, `creation_date`, `last_update`) VALUES
(1, 'P001', 'Teclado', 'Teclado USB', 350.00, 10, 1, '2026-09-21 22:24:51', '2026-09-21 22:24:51'),
(2, 'P003', 'Audífonos Bluetooth', 'Audífonos inalámbricos con conexión Bluetooth', 599.00, 15, 1, '2026-09-22 10:42:47', '2026-09-22 10:42:47'),
(3, 'MOU-LOG-01', 'Mouse Inalámbrico Logitech M170', 'Mouse óptico con conectividad USB de 2.4 GHz y diseño ambidextro', 249.00, 25, 1, '2026-09-22 10:52:49', '2026-09-22 10:52:49'),
(4, 'MON-SAM-24', 'Monitor Samsung 24 pulgadas FHD', 'Monitor LED plano con resolución Full HD y frecuencia de actualización de 75Hz', 2899.00, 8, 1, '2026-09-22 10:52:49', '2026-09-22 10:52:49'),
(5, 'SSD-KIN-500', 'Disco Estado Sólido Kingston NV2 500GB', 'NVMe PCIe 4.0 M.2 Internal SSD para alto rendimiento en lectura y escritura', 799.50, 40, 1, '2026-09-22 10:52:49', '2026-09-22 10:52:49'),
(6, 'LAP-LEN-14', 'Laptop Lenovo IdeaPad 3', 'Pantalla de 14 pulgadas, procesador AMD Ryzen 5, 8GB RAM y 256GB SSD', 8499.00, 5, 1, '2026-09-22 10:52:49', '2026-09-22 10:52:49'),
(7, 'AUD-SON-WH', 'Audífonos Sony WH-CH520', 'Audífonos inalámbricos de diadema con Bluetooth, manos libres y gran autonomía', 999.00, 18, 1, '2026-09-22 10:52:49', '2026-09-22 10:52:49');



-- Procedimientos almacenados



DELIMITER ;;
CREATE PROCEDURE `sp_restore_product`(IN p_product_id INT UNSIGNED)
BEGIN
IF NOT EXISTS (SELECT 1 FROM tb_products WHERE ID = p_product_id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto especificado no existe';
END IF;
IF EXISTS (SELECT 1 FROM tb_products WHERE ID = p_product_id AND status = 1) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto ya se encuentra activo';
END IF;
UPDATE tb_products SET status = 1 WHERE ID = p_product_id;
END ;;

CREATE PROCEDURE `sp_soft_delete_product`(IN p_product_id INT UNSIGNED)
BEGIN
IF NOT EXISTS (SELECT 1 FROM tb_products WHERE ID = p_product_id) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto especificado no existe';
END IF;
IF EXISTS (SELECT 1 FROM tb_products WHERE ID = p_product_id AND status = 0) THEN
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El producto ya se encuentra eliminado';
END IF;
UPDATE tb_products SET status = 0 WHERE ID = p_product_id;
END ;;
DELIMITER ;



-- Vistas



DROP VIEW IF EXISTS `vw_trazabilidad_productos`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_trazabilidad_productos` AS
SELECT
`p`.`ID` AS `id`,
`p`.`name` AS `name`,
`p`.`description` AS `description`,
`b`.`db_users` AS `inserted_by`,
COALESCE(GROUP_CONCAT(DISTINCT `re`.`FROM_USER` ORDER BY `re`.`FROM_USER` ASC SEPARATOR ', '), 'Sin rol') AS `roles`,
`b`.`description` AS `operation_description`,
`b`.`operation_date` AS `operation_date`
FROM `tb_products` `p`
JOIN `tb_logs` `b` ON CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(`b`.`description`, 'ID=', -1), ',', 1) AS UNSIGNED) = `p`.`ID`
LEFT JOIN `mysql`.`role_edges` `re` ON `re`.`TO_USER` = SUBSTRING_INDEX(`b`.`db_users`, '@', 1)
WHERE `b`.`operation` = 'Create' AND `b`.`table_name` = 'tb_products'
GROUP BY `p`.`ID`, `p`.`name`, `p`.`description`, `b`.`db_users`, `b`.`description`, `b`.`operation_date`;

DROP VIEW IF EXISTS `vw_trazabilidad_usuarios`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_trazabilidad_usuarios` AS
SELECT
`u`.`nickname` AS `nickname`,
`u`.`email` AS `email`,
`b`.`db_users` AS `inserted_by`,
COALESCE(GROUP_CONCAT(DISTINCT `re`.`FROM_USER` ORDER BY `re`.`FROM_USER` ASC SEPARATOR ', '), 'Sin rol') AS `roles`,
`b`.`description` AS `operation_description`,
`b`.`operation_date` AS `operation_date`
FROM `tb_users` `u`
JOIN `tb_logs` `b` ON `b`.`description` LIKE CONCAT('%ID=', `u`.`ID`, ',%')
LEFT JOIN `mysql`.`role_edges` `re` ON `re`.`TO_USER` = SUBSTRING_INDEX(`b`.`db_users`, '@', 1)
WHERE `b`.`operation` = 'Create' AND `b`.`table_name` = 'tb_users'
GROUP BY `u`.`nickname`, `u`.`email`, `b`.`db_users`, `b`.`description`, `b`.`operation_date`
ORDER BY `b`.`operation_date`;

INSERT INTO tb_logs (ID, table_name, operation, db_users, description, operation_date, operation_status) VALUES
(1, 'tb_users', 'Create', 'root@localhost', 'Usuario creado. ID=1, email=sara@gmail.com, nickname=sara', '2026-09-10 11:05:11', _binary ''),
(2, 'tb_users', 'Create', 'root@localhost', 'Usuario creado. ID=2, email=harold@gmail.com, nickname=Harold', '2026-09-10 11:09:37', _binary ''),
(3, 'tb_users', 'Create', 'root@localhost', 'Usuario creado. ID=3, email=vane@gmail.com, nickname=vane', '2026-09-10 11:09:37', _binary '');


