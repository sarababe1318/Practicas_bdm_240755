USE db_test;

/*1.  VERIFICAR EL TOTAL DE LA TABLA EN MI BASE DE DATOS*/
SHOW TABLES;

/* 2, VERIFICAR EL TOTAL DE TRIGGERS EN MI BASE DE DATOS*/
SHOW TRIGGERS FROM db_test;

/* 3, Cuantos registros existen en la tabla users*/
-- Total de Usuarios
SELECT COUNT(*) AS total_registros FROM tb_users;

-- Vizualizacion de los usuarios
SELECT*FROM tb_users;

-- Consulta para verificar que usuario de la base de datos 
-- inserto a que usuario de la plataforma ecommerce, agregando el rol del SGBD
SELECT
    u.nickname,
    u.email,
    b.db_users AS inserted_by,
    COALESCE(
        GROUP_CONCAT(
            DISTINCT re.FROM_USER
            ORDER BY re.FROM_USER
            SEPARATOR ', '
        ),
        'Sin rol'
    ) AS roles,
    b.description AS operation_description,
    b.operation_date
FROM tb_users u
JOIN tb_logs b
    ON b.description LIKE CONCAT('%', u.nickname, '%')
    AND b.description LIKE CONCAT('%', u.email, '%')
LEFT JOIN mysql.role_edges re
    ON re.TO_USER = SUBSTRING_INDEX(b.db_users, '@', 1)
WHERE b.operation = 'Create'
    AND b.table_name = 'tb_users'
GROUP BY
    u.nickname,
    u.email,
    b.db_users,
    b.description,
    b.operation_date
ORDER BY b.operation_date ASC;


/* 4. Cuantos Registros esisten en la tabla bitacora?*/
SELECT COUNT(*) AS total_registros FROM tb_logs;

/* 5. Consultar todas las operaciones realizadas en la base de datos*/
SELECT * FROM tb_logs;

/* VERIFICA LOS USUARIOS REMOTOS CREADOS EN EL SERVIDOR*/
SELECT user, host FROM mysql.user WHERE host="%";

/*vERIFICAR LOS ROLES ASIGNADOS A LOS USUARIOS REMOTOS CREADOS ENEL SERVIDOR */
SELECT 
	FROM_USER AS Rol,
    FROM_HOST AS Host_Rol,
    TO_USER AS Usuario,
    TO_USER AS Host_Usuario
FROM mysql.role_edges
ORDER BY FROM_USER, TO_USER;

/* 6. Verificar que los usuarios remotos hayan sido creados */
SELECT User, Host
FROM mysql.user
WHERE Host = '%'
  AND account_locked = 'N';


/* 7. Verificar los roles que fueron creados */
SELECT User, Host
FROM mysql.user
WHERE Host = '%'
  AND account_locked = 'Y';


/* 8. Verificar que usuarios tienen que roles */
SELECT
    TO_USER AS usuario,
    TO_HOST AS host,
    FROM_USER AS rol,
    FROM_HOST AS rol_host
FROM mysql.role_edges
ORDER BY TO_USER, FROM_USER;

/* 9. Verificar el total de procedimientos almacenados que exsten en la base de datos db_test*/
SHOW PROCEDURE STATUS WHERE Db = 'db_test';

/* 10. Verificación de productos*/
SELECT * FROM tb_products;
/* 11. Contablizar losmproductos*/
SELECT COUNT(*) FROM tb_products;
/* 12. Vizualizar todos los productos*/
SELECT * FROM tb_products;
/* 13. Consuta para saber la trazabilidad de los productos*/
SELECT * FROM vw_trazabilidad_productos ORDER BY operation_date DESC LIMIT 10;
/* 14. Consulta la trazabilidad de los usuarios*/
SELECT * FROM vw_trazabilidad_usuarios ORDER BY operation_date ASC;
/* 15. Contabilizar cuantos productos por tabla hay por usuario*/
SELECT COUNT(*), vp.inserted_by
FROM vw_trazabilidad_productos vp 
GROUP BY vp.inserted_by;


/* Consulta para saber la trazabilidad de los productos */

SELECT
    p.ID AS id,
    p.name AS name,
    p.description AS description,
    b.db_users AS inserted_by,
    COALESCE(
        GROUP_CONCAT(
            DISTINCT re.FROM_USER
            ORDER BY re.FROM_USER
            SEPARATOR ', '
        ),
        'Sin rol'
    ) AS roles,
    b.description AS operation_description,
    b.operation_date AS operation_date
FROM tb_products p
JOIN tb_logs b
    ON CAST(
        SUBSTRING_INDEX(
            SUBSTRING_INDEX(b.description, 'ID=', -1),
            ',',
            1
        ) AS UNSIGNED
    ) = p.ID
LEFT JOIN mysql.role_edges re
    ON re.TO_USER = SUBSTRING_INDEX(b.db_users, '@', 1)
WHERE b.operation = 'Create'
  AND b.table_name = 'tb_products'
GROUP BY
    p.ID,
    p.name,
    p.description,
    b.db_users,
    b.description,
    b.operation_date;
 