-- ============================================================
-- 00_usuario_permisos.sql
-- Ejecutar esta parte como SYS
-- ============================================================

ALTER SESSION SET CONTAINER = XEPDB1;

-- Eliminar usuario anterior si existe
BEGIN
    EXECUTE IMMEDIATE 'DROP USER TIENDA_POLERAS CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Crear usuario del proyecto
CREATE USER TIENDA_POLERAS IDENTIFIED BY Tienda123;

-- Entregar permisos
GRANT CREATE SESSION TO TIENDA_POLERAS;
GRANT CREATE TABLE TO TIENDA_POLERAS;
GRANT CREATE PROCEDURE TO TIENDA_POLERAS;
GRANT CREATE TRIGGER TO TIENDA_POLERAS;
GRANT CREATE SEQUENCE TO TIENDA_POLERAS;

-- Dar espacio en el tablespace
ALTER USER TIENDA_POLERAS QUOTA UNLIMITED ON USERS;


-- ============================================================
-- 01_creacion_tablas.sql
-- Ejecutar como TIENDA_POLERAS
-- ============================================================

-- Conectarse al usuario del proyecto
CONNECT TIENDA_POLERAS/Tienda123@localhost:1521/XEPDB1;

SET SERVEROUTPUT ON;
SET DEFINE OFF;

-- Crear tabla de modelos
CREATE TABLE MODELO (
    id_modelo NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

-- Crear tabla de colores
CREATE TABLE COLOR (
    id_color NUMBER PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL
);

-- Crear tabla de tallas
CREATE TABLE TALLA (
    id_talla NUMBER PRIMARY KEY,
    nombre VARCHAR2(10) NOT NULL
);

-- Crear tabla de productos
CREATE TABLE PRODUCTO (
    id_producto NUMBER PRIMARY KEY,
    id_modelo NUMBER NOT NULL,
    id_color NUMBER NOT NULL,
    id_talla NUMBER NOT NULL,
    precio NUMBER(10,2) NOT NULL,
    stock NUMBER NOT NULL,

    CONSTRAINT fk_producto_modelo
        FOREIGN KEY (id_modelo)
        REFERENCES MODELO(id_modelo),

    CONSTRAINT fk_producto_color
        FOREIGN KEY (id_color)
        REFERENCES COLOR(id_color),

    CONSTRAINT fk_producto_talla
        FOREIGN KEY (id_talla)
        REFERENCES TALLA(id_talla)
);

-- Crear tabla de compradores
CREATE TABLE COMPRADOR (
    id_comprador NUMBER PRIMARY KEY,
    rut VARCHAR2(12) NOT NULL UNIQUE,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    telefono VARCHAR2(20),
    direccion VARCHAR2(200),
    fecha_registro DATE DEFAULT SYSDATE NOT NULL
);

-- Crear tabla de ventas
CREATE TABLE VENTA (
    id_venta NUMBER PRIMARY KEY,
    id_comprador NUMBER NOT NULL,
    fecha_venta DATE DEFAULT SYSDATE NOT NULL,
    total NUMBER(10,2) DEFAULT 0 NOT NULL,

    CONSTRAINT fk_venta_comprador
        FOREIGN KEY (id_comprador)
        REFERENCES COMPRADOR(id_comprador),

    CONSTRAINT ck_venta_total
        CHECK (total >= 0)
);

-- Crear detalle de las ventas
CREATE TABLE DETALLE_VENTA (
    id_detalle NUMBER PRIMARY KEY,
    id_venta NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    precio_unitario NUMBER(10,2) NOT NULL,

    CONSTRAINT fk_detalle_venta
        FOREIGN KEY (id_venta)
        REFERENCES VENTA(id_venta),

    CONSTRAINT fk_detalle_producto
        FOREIGN KEY (id_producto)
        REFERENCES PRODUCTO(id_producto),

    CONSTRAINT ck_detalle_cantidad
        CHECK (cantidad > 0),

    CONSTRAINT ck_detalle_precio
        CHECK (precio_unitario >= 0),

    CONSTRAINT uq_detalle_venta_producto
        UNIQUE (id_venta, id_producto)
);


-- ============================================================
-- 02_datos_prueba.sql
-- Datos iniciales para probar el proyecto
-- ============================================================

-- Insertar modelos
INSERT INTO MODELO (id_modelo, nombre)
VALUES (1, 'Basica');

INSERT INTO MODELO (id_modelo, nombre)
VALUES (2, 'Oversize');

INSERT INTO MODELO (id_modelo, nombre)
VALUES (3, 'Deportiva');

-- Insertar colores
INSERT INTO COLOR (id_color, nombre)
VALUES (1, 'Negro');

INSERT INTO COLOR (id_color, nombre)
VALUES (2, 'Blanco');

INSERT INTO COLOR (id_color, nombre)
VALUES (3, 'Azul');

INSERT INTO COLOR (id_color, nombre)
VALUES (4, 'Rojo');

-- Insertar tallas
INSERT INTO TALLA (id_talla, nombre)
VALUES (1, 'S');

INSERT INTO TALLA (id_talla, nombre)
VALUES (2, 'M');

INSERT INTO TALLA (id_talla, nombre)
VALUES (3, 'L');

INSERT INTO TALLA (id_talla, nombre)
VALUES (4, 'XL');

-- Insertar productos
INSERT INTO PRODUCTO (
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
)
VALUES (1, 1, 1, 2, 19990, 15);

INSERT INTO PRODUCTO (
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
)
VALUES (2, 1, 2, 3, 19990, 10);

INSERT INTO PRODUCTO (
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
)
VALUES (3, 2, 1, 4, 24990, 8);

INSERT INTO PRODUCTO (
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
)
VALUES (4, 2, 3, 2, 24990, 12);

INSERT INTO PRODUCTO (
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
)
VALUES (5, 3, 4, 1, 22990, 20);

-- Insertar compradores
INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (
    1,
    '12345678-9',
    'Juan Perez',
    'juan.perez@mail.cl',
    '912345678',
    'Alameda 123, Santiago'
);

INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (
    2,
    '87654321-4',
    'Maria Soto',
    'maria.soto@mail.cl',
    '987654321',
    'Providencia 456, Santiago'
);

INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (
    3,
    '11222333-4',
    'Diego Fuentes',
    'diego.fuentes@mail.cl',
    '955544433',
    'Maipu 789, Santiago'
);

-- Insertar ventas
INSERT INTO VENTA (
    id_venta,
    id_comprador,
    fecha_venta,
    total
)
VALUES (101, 1, SYSDATE, 64970);

INSERT INTO VENTA (
    id_venta,
    id_comprador,
    fecha_venta,
    total
)
VALUES (102, 2, SYSDATE, 22990);

-- Insertar detalles
INSERT INTO DETALLE_VENTA (
    id_detalle,
    id_venta,
    id_producto,
    cantidad,
    precio_unitario
)
VALUES (1001, 101, 1, 2, 19990);

INSERT INTO DETALLE_VENTA (
    id_detalle,
    id_venta,
    id_producto,
    cantidad,
    precio_unitario
)
VALUES (1002, 101, 3, 1, 24990);

INSERT INTO DETALLE_VENTA (
    id_detalle,
    id_venta,
    id_producto,
    cantidad,
    precio_unitario
)
VALUES (1003, 102, 5, 1, 22990);

COMMIT;


-- ============================================================
-- 03_record_varray.sql
-- Ejemplos de RECORD y VARRAY
-- ============================================================

-- RECORD para almacenar los datos de un producto
DECLARE
    TYPE t_producto IS RECORD (
        id_producto NUMBER,
        modelo VARCHAR2(50),
        color VARCHAR2(30),
        talla VARCHAR2(10),
        precio NUMBER(10,2),
        stock NUMBER
    );

    v_producto t_producto;
BEGIN
    SELECT
        p.id_producto,
        m.nombre,
        c.nombre,
        t.nombre,
        p.precio,
        p.stock
    INTO
        v_producto.id_producto,
        v_producto.modelo,
        v_producto.color,
        v_producto.talla,
        v_producto.precio,
        v_producto.stock
    FROM PRODUCTO p
    JOIN MODELO m ON p.id_modelo = m.id_modelo
    JOIN COLOR c ON p.id_color = c.id_color
    JOIN TALLA t ON p.id_talla = t.id_talla
    WHERE p.id_producto = 1;

    DBMS_OUTPUT.PUT_LINE('ID: ' || v_producto.id_producto);
    DBMS_OUTPUT.PUT_LINE('Modelo: ' || v_producto.modelo);
    DBMS_OUTPUT.PUT_LINE('Color: ' || v_producto.color);
    DBMS_OUTPUT.PUT_LINE('Talla: ' || v_producto.talla);
    DBMS_OUTPUT.PUT_LINE('Precio: ' || v_producto.precio);
    DBMS_OUTPUT.PUT_LINE('Stock: ' || v_producto.stock);
END;
/

-- VARRAY para almacenar las tallas
DECLARE
    TYPE t_tallas IS VARRAY(4) OF TALLA.NOMBRE%TYPE;

    v_tallas t_tallas := t_tallas(
        'S',
        'M',
        'L',
        'XL'
    );
BEGIN
    FOR i IN 1 .. v_tallas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Talla ' || i || ': ' || v_tallas(i)
        );
    END LOOP;
END;
/

-- RECORD para almacenar información del comprador
DECLARE
    TYPE t_comprador IS RECORD (
        id_comprador NUMBER,
        rut VARCHAR2(12),
        nombre VARCHAR2(100),
        email VARCHAR2(100),
        total_compras NUMBER
    );

    v_comprador t_comprador;
BEGIN
    SELECT
        c.id_comprador,
        c.rut,
        c.nombre,
        c.email,
        NVL(SUM(v.total), 0)
    INTO
        v_comprador.id_comprador,
        v_comprador.rut,
        v_comprador.nombre,
        v_comprador.email,
        v_comprador.total_compras
    FROM COMPRADOR c
    LEFT JOIN VENTA v
        ON v.id_comprador = c.id_comprador
    WHERE c.id_comprador = 1
    GROUP BY c.id_comprador, c.rut, c.nombre, c.email;

    DBMS_OUTPUT.PUT_LINE('ID: ' || v_comprador.id_comprador);
    DBMS_OUTPUT.PUT_LINE('RUT: ' || v_comprador.rut);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_comprador.nombre);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_comprador.email);
    DBMS_OUTPUT.PUT_LINE('Total compras: $' || v_comprador.total_compras);
END;
/

-- VARRAY para almacenar productos comprados
DECLARE
    TYPE t_productos_comprados IS VARRAY(10) OF VARCHAR2(50);

    v_productos t_productos_comprados := t_productos_comprados();

    v_id_venta VENTA.ID_VENTA%TYPE := 101;
BEGIN
    SELECT m.nombre
    BULK COLLECT INTO v_productos
    FROM DETALLE_VENTA d
    JOIN PRODUCTO p ON d.id_producto = p.id_producto
    JOIN MODELO m ON p.id_modelo = m.id_modelo
    WHERE d.id_venta = v_id_venta
    AND ROWNUM <= 10;

    FOR i IN 1 .. v_productos.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Producto ' || i || ': ' || v_productos(i)
        );
    END LOOP;
END;
/


-- ============================================================
-- 04_cursores.sql
-- Cursores con y sin parametros y loops anidados
-- ============================================================

DECLARE
    CURSOR c_modelos IS
        SELECT id_modelo, nombre
        FROM MODELO
        ORDER BY id_modelo;

    CURSOR c_productos(
        p_id_modelo MODELO.ID_MODELO%TYPE
    ) IS
        SELECT
            p.id_producto,
            c.nombre AS color,
            t.nombre AS talla,
            p.precio,
            p.stock
        FROM PRODUCTO p
        JOIN COLOR c ON p.id_color = c.id_color
        JOIN TALLA t ON p.id_talla = t.id_talla
        WHERE p.id_modelo = p_id_modelo
        ORDER BY p.id_producto;
BEGIN
    -- Loop externo
    FOR r_modelo IN c_modelos LOOP

        DBMS_OUTPUT.PUT_LINE(
            '--- Modelo: ' || r_modelo.nombre || ' ---'
        );

        -- Loop interno
        FOR r_producto IN c_productos(r_modelo.id_modelo) LOOP

            DBMS_OUTPUT.PUT_LINE(
                'Producto: ' || r_producto.id_producto ||
                ' | Color: ' || r_producto.color ||
                ' | Talla: ' || r_producto.talla ||
                ' | Precio: $' || r_producto.precio ||
                ' | Stock: ' || r_producto.stock
            );

        END LOOP;
    END LOOP;
END;
/

DECLARE
    CURSOR c_compradores IS
        SELECT id_comprador, rut, nombre
        FROM COMPRADOR
        ORDER BY id_comprador;

    CURSOR c_ventas(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    ) IS
        SELECT
            v.id_venta,
            v.fecha_venta,
            v.total,
            d.id_producto,
            m.nombre AS modelo,
            d.cantidad,
            d.precio_unitario,
            (d.cantidad * d.precio_unitario) AS subtotal
        FROM VENTA v
        JOIN DETALLE_VENTA d ON d.id_venta = v.id_venta
        JOIN PRODUCTO p ON d.id_producto = p.id_producto
        JOIN MODELO m ON p.id_modelo = m.id_modelo
        WHERE v.id_comprador = p_id_comprador
        ORDER BY v.id_venta, d.id_detalle;
BEGIN
    FOR r_comprador IN c_compradores LOOP

        DBMS_OUTPUT.PUT_LINE(
            '--- Comprador: ' || r_comprador.nombre ||
            ' (' || r_comprador.rut || ') ---'
        );

        FOR r_venta IN c_ventas(r_comprador.id_comprador) LOOP

            DBMS_OUTPUT.PUT_LINE(
                'Venta: ' || r_venta.id_venta ||
                ' | Modelo: ' || r_venta.modelo ||
                ' | Cant: ' || r_venta.cantidad ||
                ' | Subtotal: $' || r_venta.subtotal ||
                ' | Total venta: $' || r_venta.total
            );

        END LOOP;
    END LOOP;
END;
/


-- ============================================================
-- 05_excepciones.sql
-- Excepciones predefinidas y definidas por el usuario
-- ============================================================

-- NO_DATA_FOUND
DECLARE
    v_nombre MODELO.NOMBRE%TYPE;
BEGIN
    SELECT nombre
    INTO v_nombre
    FROM MODELO
    WHERE id_modelo = 999;

    DBMS_OUTPUT.PUT_LINE(
        'Modelo encontrado: ' || v_nombre
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: No se encontró el modelo solicitado.'
        );
END;
/

-- Excepcion definida por el usuario para controlar stock
DECLARE
    v_stock PRODUCTO.STOCK%TYPE;
    v_cantidad_solicitada NUMBER := 20;

    e_stock_insuficiente EXCEPTION;
BEGIN
    SELECT stock
    INTO v_stock
    FROM PRODUCTO
    WHERE id_producto = 1;

    IF v_cantidad_solicitada > v_stock THEN
        RAISE e_stock_insuficiente;
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Venta permitida. Stock disponible: ' || v_stock
        );
    END IF;
EXCEPTION
    WHEN e_stock_insuficiente THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Stock insuficiente para realizar la venta.'
        );
END;
/

-- DUP_VAL_ON_INDEX
DECLARE
    v_id_comprador COMPRADOR.ID_COMPRADOR%TYPE := 99;
    v_rut COMPRADOR.RUT%TYPE := '12345678-9';
    v_nombre COMPRADOR.NOMBRE%TYPE := 'Duplicado';
BEGIN
    INSERT INTO COMPRADOR (
        id_comprador,
        rut,
        nombre
    )
    VALUES (
        v_id_comprador,
        v_rut,
        v_nombre
    );

    ROLLBACK;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El RUT o email del comprador ya está registrado.'
        );
END;
/

-- Excepciones definidas por el usuario
DECLARE
    v_id_comprador COMPRADOR.ID_COMPRADOR%TYPE := 3;
    v_total NUMBER := 0;
    v_cantidad_ventas NUMBER := 0;

    e_rut_invalido EXCEPTION;
    e_comprador_sin_ventas EXCEPTION;

    v_rut COMPRADOR.RUT%TYPE;
BEGIN
    SELECT rut
    INTO v_rut
    FROM COMPRADOR
    WHERE id_comprador = v_id_comprador;

    IF INSTR(v_rut, '-') = 0 THEN
        RAISE e_rut_invalido;
    END IF;

    SELECT COUNT(*), NVL(SUM(total), 0)
    INTO v_cantidad_ventas, v_total
    FROM VENTA
    WHERE id_comprador = v_id_comprador;

    IF v_cantidad_ventas = 0 THEN
        RAISE e_comprador_sin_ventas;
    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Comprador ' || v_id_comprador ||
        ' total: $' || v_total
    );
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: No se encontró el comprador solicitado.'
        );

    WHEN e_rut_invalido THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El RUT del comprador no tiene formato válido.'
        );

    WHEN e_comprador_sin_ventas THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El comprador no registra ventas.'
        );
END;
/


-- ============================================================
-- 06_procedures.sql
-- Procedimientos almacenados
-- ============================================================

-- Insertar producto
CREATE OR REPLACE PROCEDURE insertar_producto(
    p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
    p_id_modelo PRODUCTO.ID_MODELO%TYPE,
    p_id_color PRODUCTO.ID_COLOR%TYPE,
    p_id_talla PRODUCTO.ID_TALLA%TYPE,
    p_precio PRODUCTO.PRECIO%TYPE,
    p_stock PRODUCTO.STOCK%TYPE
)
IS
BEGIN
    INSERT INTO PRODUCTO (
        id_producto,
        id_modelo,
        id_color,
        id_talla,
        precio,
        stock
    )
    VALUES (
        p_id_producto,
        p_id_modelo,
        p_id_color,
        p_id_talla,
        p_precio,
        p_stock
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Producto insertado correctamente.'
    );
END;
/

-- Actualizar stock
CREATE OR REPLACE PROCEDURE actualizar_stock(
    p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
    p_nuevo_stock PRODUCTO.STOCK%TYPE
)
IS
BEGIN
    UPDATE PRODUCTO
    SET stock = p_nuevo_stock
    WHERE id_producto = p_id_producto;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Stock actualizado correctamente.'
    );
END;
/

-- Insertar comprador
CREATE OR REPLACE PROCEDURE insertar_comprador(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
    p_rut COMPRADOR.RUT%TYPE,
    p_nombre COMPRADOR.NOMBRE%TYPE,
    p_email COMPRADOR.EMAIL%TYPE,
    p_telefono COMPRADOR.TELEFONO%TYPE,
    p_direccion COMPRADOR.DIRECCION%TYPE
)
IS
    e_rut_invalido EXCEPTION;
BEGIN
    IF INSTR(p_rut, '-') = 0 THEN
        RAISE e_rut_invalido;
    END IF;

    INSERT INTO COMPRADOR (
        id_comprador,
        rut,
        nombre,
        email,
        telefono,
        direccion
    )
    VALUES (
        p_id_comprador,
        p_rut,
        p_nombre,
        p_email,
        p_telefono,
        p_direccion
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Comprador insertado correctamente.'
    );
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: RUT o email duplicado.'
        );

        RAISE;

    WHEN e_rut_invalido THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: RUT sin formato válido.'
        );

        RAISE;
END;
/

-- Registrar una venta
CREATE OR REPLACE PROCEDURE registrar_venta(
    p_id_venta VENTA.ID_VENTA%TYPE,
    p_id_comprador VENTA.ID_COMPRADOR%TYPE
)
IS
    v_existe NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_existe
    FROM COMPRADOR
    WHERE id_comprador = p_id_comprador;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'El comprador no existe.'
        );
    END IF;

    INSERT INTO VENTA (
        id_venta,
        id_comprador,
        fecha_venta,
        total
    )
    VALUES (
        p_id_venta,
        p_id_comprador,
        SYSDATE,
        0
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Venta registrada correctamente.'
    );
END;
/

-- Agregar detalle y actualizar stock
CREATE OR REPLACE PROCEDURE agregar_detalle_venta(
    p_id_detalle DETALLE_VENTA.ID_DETALLE%TYPE,
    p_id_venta DETALLE_VENTA.ID_VENTA%TYPE,
    p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
    p_cantidad DETALLE_VENTA.CANTIDAD%TYPE
)
IS
    v_stock PRODUCTO.STOCK%TYPE;
    v_precio PRODUCTO.PRECIO%TYPE;

    e_stock_insuficiente EXCEPTION;
BEGIN
    SELECT stock, precio
    INTO v_stock, v_precio
    FROM PRODUCTO
    WHERE id_producto = p_id_producto
    FOR UPDATE;

    IF p_cantidad > v_stock THEN
        RAISE e_stock_insuficiente;
    END IF;

    INSERT INTO DETALLE_VENTA (
        id_detalle,
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    VALUES (
        p_id_detalle,
        p_id_venta,
        p_id_producto,
        p_cantidad,
        v_precio
    );

    UPDATE PRODUCTO
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;

    UPDATE VENTA
    SET total = (
        SELECT NVL(SUM(cantidad * precio_unitario), 0)
        FROM DETALLE_VENTA
        WHERE id_venta = p_id_venta
    )
    WHERE id_venta = p_id_venta;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Detalle agregado correctamente.'
    );
EXCEPTION
    WHEN e_stock_insuficiente THEN
        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Stock insuficiente para realizar la venta.'
        );

        RAISE;

    WHEN NO_DATA_FOUND THEN
        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Venta o producto inexistente.'
        );

        RAISE;

    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Producto ya ingresado en esta venta.'
        );

        RAISE;

    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


-- ============================================================
-- 07_functions.sql
-- Funciones almacenadas
-- ============================================================

-- Calcular valor del stock
CREATE OR REPLACE FUNCTION calcular_valor_stock(
    p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
)
RETURN NUMBER
IS
    v_precio PRODUCTO.PRECIO%TYPE;
    v_stock PRODUCTO.STOCK%TYPE;
BEGIN
    SELECT precio, stock
    INTO v_precio, v_stock
    FROM PRODUCTO
    WHERE id_producto = p_id_producto;

    RETURN v_precio * v_stock;
END;
/

-- Calcular total comprado
CREATE OR REPLACE FUNCTION calcular_total_comprado(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
)
RETURN NUMBER
IS
    v_total NUMBER := 0;
BEGIN
    SELECT NVL(SUM(total), 0)
    INTO v_total
    FROM VENTA
    WHERE id_comprador = p_id_comprador;

    RETURN v_total;
END;
/

-- Calcular ticket promedio
CREATE OR REPLACE FUNCTION obtener_ticket_promedio(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
)
RETURN NUMBER
IS
    v_cantidad NUMBER := 0;
    v_suma NUMBER := 0;
BEGIN
    SELECT COUNT(*), NVL(SUM(total), 0)
    INTO v_cantidad, v_suma
    FROM VENTA
    WHERE id_comprador = p_id_comprador;

    IF v_cantidad = 0 THEN
        RETURN 0;
    END IF;

    RETURN v_suma / v_cantidad;
END;
/


-- ============================================================
-- 08_package.sql
-- Packages para agrupar procedimientos y funciones
-- ============================================================

-- Package de productos
CREATE OR REPLACE PACKAGE pkg_productos IS

    PROCEDURE insertar_producto(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_id_modelo PRODUCTO.ID_MODELO%TYPE,
        p_id_color PRODUCTO.ID_COLOR%TYPE,
        p_id_talla PRODUCTO.ID_TALLA%TYPE,
        p_precio PRODUCTO.PRECIO%TYPE,
        p_stock PRODUCTO.STOCK%TYPE
    );

    PROCEDURE actualizar_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_nuevo_stock PRODUCTO.STOCK%TYPE
    );

    FUNCTION calcular_valor_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
    )
    RETURN NUMBER;

END pkg_productos;
/

-- Cuerpo del package de productos
CREATE OR REPLACE PACKAGE BODY pkg_productos IS

    PROCEDURE insertar_producto(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_id_modelo PRODUCTO.ID_MODELO%TYPE,
        p_id_color PRODUCTO.ID_COLOR%TYPE,
        p_id_talla PRODUCTO.ID_TALLA%TYPE,
        p_precio PRODUCTO.PRECIO%TYPE,
        p_stock PRODUCTO.STOCK%TYPE
    )
    IS
    BEGIN
        INSERT INTO PRODUCTO (
            id_producto,
            id_modelo,
            id_color,
            id_talla,
            precio,
            stock
        )
        VALUES (
            p_id_producto,
            p_id_modelo,
            p_id_color,
            p_id_talla,
            p_precio,
            p_stock
        );

        COMMIT;
    END insertar_producto;

    PROCEDURE actualizar_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_nuevo_stock PRODUCTO.STOCK%TYPE
    )
    IS
    BEGIN
        UPDATE PRODUCTO
        SET stock = p_nuevo_stock
        WHERE id_producto = p_id_producto;

        COMMIT;
    END actualizar_stock;

    FUNCTION calcular_valor_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
    )
    RETURN NUMBER
    IS
        v_precio PRODUCTO.PRECIO%TYPE;
        v_stock PRODUCTO.STOCK%TYPE;
    BEGIN
        SELECT precio, stock
        INTO v_precio, v_stock
        FROM PRODUCTO
        WHERE id_producto = p_id_producto;

        RETURN v_precio * v_stock;
    END calcular_valor_stock;

END pkg_productos;
/

-- Package de ventas
CREATE OR REPLACE PACKAGE pkg_ventas IS

    PROCEDURE insertar_comprador(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
        p_rut COMPRADOR.RUT%TYPE,
        p_nombre COMPRADOR.NOMBRE%TYPE,
        p_email COMPRADOR.EMAIL%TYPE,
        p_telefono COMPRADOR.TELEFONO%TYPE,
        p_direccion COMPRADOR.DIRECCION%TYPE
    );

    PROCEDURE registrar_venta(
        p_id_venta VENTA.ID_VENTA%TYPE,
        p_id_comprador VENTA.ID_COMPRADOR%TYPE
    );

    PROCEDURE agregar_detalle_venta(
        p_id_detalle DETALLE_VENTA.ID_DETALLE%TYPE,
        p_id_venta DETALLE_VENTA.ID_VENTA%TYPE,
        p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
        p_cantidad DETALLE_VENTA.CANTIDAD%TYPE
    );

    FUNCTION calcular_total_comprado(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER;

    FUNCTION obtener_ticket_promedio(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER;

END pkg_ventas;
/

-- Cuerpo del package de ventas
CREATE OR REPLACE PACKAGE BODY pkg_ventas IS

    PROCEDURE insertar_comprador(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
        p_rut COMPRADOR.RUT%TYPE,
        p_nombre COMPRADOR.NOMBRE%TYPE,
        p_email COMPRADOR.EMAIL%TYPE,
        p_telefono COMPRADOR.TELEFONO%TYPE,
        p_direccion COMPRADOR.DIRECCION%TYPE
    )
    IS
        e_rut_invalido EXCEPTION;
    BEGIN
        IF INSTR(p_rut, '-') = 0 THEN
            RAISE e_rut_invalido;
        END IF;

        INSERT INTO COMPRADOR (
            id_comprador,
            rut,
            nombre,
            email,
            telefono,
            direccion
        )
        VALUES (
            p_id_comprador,
            p_rut,
            p_nombre,
            p_email,
            p_telefono,
            p_direccion
        );

        COMMIT;
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            RAISE;

        WHEN e_rut_invalido THEN
            RAISE;
    END insertar_comprador;

    PROCEDURE registrar_venta(
        p_id_venta VENTA.ID_VENTA%TYPE,
        p_id_comprador VENTA.ID_COMPRADOR%TYPE
    )
    IS
        v_existe NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_existe
        FROM COMPRADOR
        WHERE id_comprador = p_id_comprador;

        IF v_existe = 0 THEN
            RAISE_APPLICATION_ERROR(
                -20002,
                'El comprador no existe.'
            );
        END IF;

        INSERT INTO VENTA (
            id_venta,
            id_comprador,
            fecha_venta,
            total
        )
        VALUES (
            p_id_venta,
            p_id_comprador,
            SYSDATE,
            0
        );

        COMMIT;
    END registrar_venta;

    PROCEDURE agregar_detalle_venta(
        p_id_detalle DETALLE_VENTA.ID_DETALLE%TYPE,
        p_id_venta DETALLE_VENTA.ID_VENTA%TYPE,
        p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
        p_cantidad DETALLE_VENTA.CANTIDAD%TYPE
    )
    IS
        v_stock PRODUCTO.STOCK%TYPE;
        v_precio PRODUCTO.PRECIO%TYPE;
        e_stock_insuficiente EXCEPTION;
    BEGIN
        SELECT stock, precio
        INTO v_stock, v_precio
        FROM PRODUCTO
        WHERE id_producto = p_id_producto
        FOR UPDATE;

        IF p_cantidad > v_stock THEN
            RAISE e_stock_insuficiente;
        END IF;

        INSERT INTO DETALLE_VENTA (
            id_detalle,
            id_venta,
            id_producto,
            cantidad,
            precio_unitario
        )
        VALUES (
            p_id_detalle,
            p_id_venta,
            p_id_producto,
            p_cantidad,
            v_precio
        );

        UPDATE PRODUCTO
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;

        UPDATE VENTA
        SET total = (
            SELECT NVL(SUM(cantidad * precio_unitario), 0)
            FROM DETALLE_VENTA
            WHERE id_venta = p_id_venta
        )
        WHERE id_venta = p_id_venta;

        COMMIT;
    EXCEPTION
        WHEN e_stock_insuficiente THEN
            ROLLBACK;
            RAISE;

        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END agregar_detalle_venta;

    FUNCTION calcular_total_comprado(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER
    IS
        v_total NUMBER := 0;
    BEGIN
        SELECT NVL(SUM(total), 0)
        INTO v_total
        FROM VENTA
        WHERE id_comprador = p_id_comprador;

        RETURN v_total;
    END calcular_total_comprado;

    FUNCTION obtener_ticket_promedio(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER
    IS
        v_cantidad NUMBER := 0;
        v_suma NUMBER := 0;
    BEGIN
        SELECT COUNT(*), NVL(SUM(total), 0)
        INTO v_cantidad, v_suma
        FROM VENTA
        WHERE id_comprador = p_id_comprador;

        IF v_cantidad = 0 THEN
            RETURN 0;
        END IF;

        RETURN v_suma / v_cantidad;
    END obtener_ticket_promedio;

END pkg_ventas;
/


-- ============================================================
-- 09_triggers.sql
-- Triggers para validar datos automáticamente
-- ============================================================

-- Controlar que el stock no sea negativo
CREATE OR REPLACE TRIGGER trg_controlar_stock
BEFORE INSERT OR UPDATE OF stock
ON PRODUCTO
FOR EACH ROW
BEGIN
    IF :NEW.stock < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20001,
            'El stock no puede ser negativo.'
        );
    END IF;
END;
/

-- Validar que el comprador exista y que el total sea válido
CREATE OR REPLACE TRIGGER trg_validar_venta
BEFORE INSERT ON VENTA
FOR EACH ROW
DECLARE
    v_existe NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_existe
    FROM COMPRADOR
    WHERE id_comprador = :NEW.id_comprador;

    IF v_existe = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20002,
            'El comprador no existe.'
        );
    END IF;

    IF :NEW.total < 0 THEN
        RAISE_APPLICATION_ERROR(
            -20003,
            'El total de la venta no puede ser negativo.'
        );
    END IF;
END;
/

COMMIT;