USE db_test_7b;

/* 1. ¿Cuántas tablas existen en la base de datos db_test_7b? */
SHOW TABLES;

/* 2. ¿Cuántos triggers existen en la base de datos db_test_7b? */
SHOW TRIGGERS FROM db_test_7B;

/* 3. ¿Cuántos registros existen en la tabla users? */
SELECT COUNT(*) AS total_registros FROM tb_users;

/* 4. ¿Cuántos registros existen en la tabla bitácora? */
SELECT COUNT(*) AS total_registros FROM tb_logs;

/* 5. Consultar todas las operaciones realizadas en la base de datos */
    SELECT * FROM tb_logs;

/* 6. Verificar que los usuarios remotos hayan sido creados */
SELECT User, Host FROM mysql.user WHERE Host = '%' AND account_locked = 'N';

/* 7. Verificar los roles que fueron creados */
SELECT User, Host FROM mysql.user WHERE Host = '%' AND account_locked = 'Y';

/* 8. Verificar qué usuario tiene qué rol */
SELECT TO_USER AS usuario, TO_HOST AS host, FROM_USER AS rol, FROM_HOST AS rol_host
FROM mysql.role_edges ORDER BY TO_USER, FROM_USER;

/* 9. Verificar el total de procedimientos almacenados que existen en la base de datos */
SHOW PROCEDURE STATUS WHERE Db = 'db_test_7B';

/* 10. Verificación de Productos*/
/* Contabilizar los productos */
SELECT COUNT(*) FROM tb_products;

/* 11. Visualizar todos los productos */
SELECT * FROM tb_products;

/* 12. Consulta para saber la trazabilidad de los productos */
SELECT * FROM vw_trazabilidad_productos LIMIT 10;