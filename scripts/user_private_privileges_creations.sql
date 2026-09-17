/* Creacion de usuarios remotos */
CREATE USER 'sara.melende'@'%' IDENTIFIED BY '240755';
CREATE USER 'nombre.apellido'@'%' IDENTIFIED BY 'sumatricula';
CREATE USER 'harold.ramirez'@'%' IDENTIFIED BY '240497';

/* Asignar los privilegios de super usuarios IMPORTANTE: SOLO NOSOTROSJAJA */
GRAND ALL PRIVILEGES ON *.* TO 'sara.melendez'@'%';

/* Asignar privilegios de seleccion, insercion, acutalizacion y eleminacion al usuario*/
GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO 'harold.ramirez'@'%';

/* Creacion de roles para el sistema de ECOMMERCE */
CREATE ROLE 'admin';
CREATE ROLE 'seller';
CREATE ROLE 'buyer';
CREATE ROLE 'support';
CREATE ROLE 'common';
CREATE ROLE 'user_not_registered';

/* Asignacion de privilegios a los roles */
GRANT ALL PRIVILEGES ON *.* TO 'admin';
GRANT SELECT, INSERT, UPDATE ON *.* TO 'support';

/* Asignacion de roles a los usuarios */
GRANT 'admin' TO 'sara.melende'@'%';
GRANT 'support' TO 'harold.ramirez'@'%';