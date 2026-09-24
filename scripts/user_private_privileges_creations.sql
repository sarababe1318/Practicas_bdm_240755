/* =========================================================
   CREACIÓN DE USUARIOS
   ========================================================= */

CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'quwerty123';
CREATE USER IF NOT EXISTS 'sara.melendez'@'%' IDENTIFIED BY '240755';
CREATE USER IF NOT EXISTS 'harold.ramirez'@'%' IDENTIFIED BY '111111';
CREATE USER IF NOT EXISTS 'luis.gonzalez'@'%' IDENTIFIED BY '111111';
 CREATE USER IF NOT EXISTS 'user.good'@'%' IDENTIFIED BY '240272';


/* =========================================================
   CREACIÓN DE ROLES
   ========================================================= */
CREATE ROLE IF NOT EXISTS 'superadmin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'common';
CREATE ROLE IF NOT EXISTS 'guest';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* =========================================================
   PRIVILEGIOS DE ADMIN 
   ========================================================= */

GRANT ALL PRIVILEGES
ON db_test_7B.*
TO 'admin';


/* =========================================================
   PRIVILEGIOS DE SELLER (maneja productos)
   ========================================================= */

GRANT SELECT, INSERT, UPDATE, DELETE
ON db_test_7b.tb_products
TO 'seller';


/* =========================================================
   PRIVILEGIOS DE SUPPORT (atiende usuarios y productos)
   ========================================================= */

GRANT SELECT, UPDATE, INSERT
ON db_test_7B.tb_users
TO 'support';

GRANT SELECT, UPDATE, INSERT
ON db_test_7B.tb_products
TO 'support';


/* =========================================================
   PRIVILEGIOS DE BUYER (solo consulta productos)
   ========================================================= */

GRANT SELECT
ON db_test_7B.tb_products
TO 'buyer';


/* =========================================================
   PRIVILEGIOS DE COMMON (solo lectura general)
   ========================================================= */

GRANT SELECT
ON db_test_7B.tb_products
TO 'common';


/* =========================================================
   PRIVILEGIOS TEMPORALES OTORGADOS DIRECTO (se quitan abajo)
   ========================================================= */

GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7B`.* TO 'marco.ramirez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7B`.* TO 'harold.ramirez'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON `db_test_7B`.* TO 'luis.gonzalez'@'%';


/* =========================================================
   QUITAR PRIVILEGIOS DIRECTOS (el control queda solo en el rol)
   ========================================================= */

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'marco.ramirez'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'harold.ramirez'@'%';

REVOKE ALL PRIVILEGES, GRANT OPTION
FROM 'luis.gonzalez'@'%';


/* =========================================================
   ASIGNACIÓN DE ROLES
   ========================================================= */

/* JOSU = ADMIN */
GRANT 'admin' TO 'sara.melendez'@'%';

/* MARCO (docente) = ADMIN */
GRANT 'admin' TO 'marco.ramirez'@'%';

/* OLIVER = SUPPORT */
GRANT 'support' TO 'harold.ramirez'@'%';

/* JONATHAN = SELLER */
GRANT 'seller' TO 'luis.gonzalez'@'%';


/* =========================================================
   ROLES POR DEFECTO
   ========================================================= */

SET DEFAULT ROLE 'admin' TO 'sara.melendez'@'%';
SET DEFAULT ROLE 'admin' TO 'marco.ramirez'@'%';
SET DEFAULT ROLE 'support' TO 'harold.ramirez'@'%';
SET DEFAULT ROLE 'seller' TO 'luis.gonzalez'@'%';


/* =========================================================
   ACTUALIZAR PRIVILEGIOS
   ========================================================= */

FLUSH PRIVILEGES;


/* =========================================================
   COMPROBAR PRIVILEGIOS
   ========================================================= */

SHOW GRANTS FOR 'sara.melendez'@'%';
SHOW GRANTS FOR 'marco.ramirez'@'%';
SHOW GRANTS FOR 'harold.ramirez'@'%';
SHOW GRANTS FOR 'luis.gonzalez'@'%';