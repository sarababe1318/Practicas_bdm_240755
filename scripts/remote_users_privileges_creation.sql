/* ==============================================================================
   CREACIÓN DE USUARIOS REMOTOS
   ============================================================================== */

CREATE USER IF NOT EXISTS 'sara.melendez'@'%' IDENTIFIED BY '240755';
CREATE USER IF NOT EXISTS 'marco.ramirez'@'%' IDENTIFIED BY 'qwerty123';
CREATE USER IF NOT EXISTS 'harold.ramirez'@'%' IDENTIFIED BY '240497';
CREATE USER IF NOT EXISTS 'vane.vergara'@'%' IDENTIFIED BY '240270';
CREATE USER IF NOT EXISTS 'samuel.ramirez'@'%' IDENTIFIED BY '240483';
CREATE USER IF NOT EXISTS 'may.gutierrez'@'%' IDENTIFIED BY '240726';
CREATE USER IF NOT EXISTS 'blanca.torres'@'%' IDENTIFIED BY '240508';


/* ==============================================================================
   ASIGNACIÓN DE PRIVILEGIOS DIRECTOS
   ============================================================================== */

GRANT ALL PRIVILEGES ON *.* 
TO 'sara.melendez'@'%';

GRANT SELECT, INSERT, UPDATE, DELETE 
ON db_test.* 
TO 'harold.ramirez'@'%';


/* ==============================================================================
   CREACIÓN DE ROLES
   ============================================================================== */

CREATE ROLE IF NOT EXISTS 'superadmin';
CREATE ROLE IF NOT EXISTS 'admin';
CREATE ROLE IF NOT EXISTS 'seller';
CREATE ROLE IF NOT EXISTS 'buyer';
CREATE ROLE IF NOT EXISTS 'common_user';
CREATE ROLE IF NOT EXISTS 'support';
CREATE ROLE IF NOT EXISTS 'user_not_registered';


/* ==============================================================================
   ASIGNACIÓN DE PRIVILEGIOS A LOS ROLES
   ============================================================================== */

/* SUPERADMIN */
GRANT ALL PRIVILEGES ON *.* TO 'superadmin';

/* ADMIN */
GRANT ALL PRIVILEGES ON db_test.* TO 'admin';

/* SUPPORT */
GRANT SELECT, INSERT, UPDATE 
ON db_test.tb_users 
TO 'support';


/* SELLER */
GRANT SELECT, INSERT, UPDATE 
ON db_test.tb_products 
TO 'seller';


/* ==============================================================================
   ASIGNACIÓN DE ROLES A USUARIOS
   ============================================================================== */

/* Sara */
GRANT 'superadmin' TO 'sara.melendez'@'%';

/* Marco */
GRANT 'admin' TO 'marco.ramirez'@'%';


GRANT 'support' TO 'vane.vergara'@'%';


GRANT 'seller' TO 'harold.ramirez'@'%';

/* Olaf */
GRANT 'seller' TO 'samuel.ramirez'@'%';


/* ==============================================================================
   ACTIVACIÓN DE ROLES POR DEFECTO
   ============================================================================== */

SET DEFAULT ROLE 'superadmin' 
TO 'sara.melendez'@'%';

SET DEFAULT ROLE 'admin' 
TO 'marco.ramirez'@'%';

SET DEFAULT ROLE 'support' 
TO 'vane.vergara'@'%';

SET DEFAULT ROLE 'seller' 
TO 'harold.ramirez'@'%';

SET DEFAULT ROLE 'seller' 
TO 'samuel.ramirez'@'%';


SELECT 'Los usuarios y privilegios han sido creados correctamente' AS mensaje;
