-- =============================================
-- CONFIGURACION DEL USUARIO
-- TiendaPolerasBDY1103_010V
-- =============================================

-- Este script debe ejecutarse como SYS
-- dentro de XEPDB1.

CREATE USER TIENDA_POLERAS IDENTIFIED BY Tienda123;

-- Permite al usuario conectarse a Oracle
GRANT CREATE SESSION TO TIENDA_POLERAS;

-- Permite crear tablas
GRANT CREATE TABLE TO TIENDA_POLERAS;

-- Permite crear procedimientos y funciones
GRANT CREATE PROCEDURE TO TIENDA_POLERAS;

-- Permite crear triggers
GRANT CREATE TRIGGER TO TIENDA_POLERAS;

-- Permite crear secuencias
GRANT CREATE SEQUENCE TO TIENDA_POLERAS;

-- Permite al usuario utilizar espacio de almacenamiento
-- en el tablespace USERS
ALTER USER TIENDA_POLERAS QUOTA UNLIMITED ON USERS;