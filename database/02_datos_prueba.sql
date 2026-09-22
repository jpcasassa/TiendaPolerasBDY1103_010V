-- =============================================
-- DATOS DE PRUEBA
-- TiendaPolerasBDY1103_010V
-- =============================================

-- =============================================
-- DATOS DE MODELO
-- =============================================

INSERT INTO MODELO (id_modelo, nombre)
VALUES (1, 'Basica');

INSERT INTO MODELO (id_modelo, nombre)
VALUES (2, 'Oversize');

INSERT INTO MODELO (id_modelo, nombre)
VALUES (3, 'Deportiva');


-- =============================================
-- DATOS DE COLOR
-- =============================================

INSERT INTO COLOR (id_color, nombre)
VALUES (1, 'Negro');

INSERT INTO COLOR (id_color, nombre)
VALUES (2, 'Blanco');

INSERT INTO COLOR (id_color, nombre)
VALUES (3, 'Azul');

INSERT INTO COLOR (id_color, nombre)
VALUES (4, 'Rojo');


-- =============================================
-- DATOS DE TALLA
-- =============================================

INSERT INTO TALLA (id_talla, nombre)
VALUES (1, 'S');

INSERT INTO TALLA (id_talla, nombre)
VALUES (2, 'M');

INSERT INTO TALLA (id_talla, nombre)
VALUES (3, 'L');

INSERT INTO TALLA (id_talla, nombre)
VALUES (4, 'XL');


-- =============================================
-- DATOS DE PRODUCTO
-- =============================================

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

COMMIT;