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


-- =============================================
-- DATOS DE COMPRADOR
-- =============================================

INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (1, '12345678-9', 'Juan Perez', 'juan.perez@mail.cl', '912345678', 'Alameda 123, Santiago');

INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (2, '87654321-4', 'Maria Soto', 'maria.soto@mail.cl', '987654321', 'Providencia 456, Santiago');

INSERT INTO COMPRADOR (
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
)
VALUES (3, '11222333-4', 'Diego Fuentes', 'diego.fuentes@mail.cl', '955544433', 'Maipu 789, Santiago');


-- =============================================
-- DATOS DE VENTA
-- Total calculado desde el detalle:
-- Venta 101: 2x19990 + 1x24990 = 64970
-- Venta 102: 1x22990 = 22990
-- =============================================

INSERT INTO VENTA (id_venta, id_comprador, fecha_venta, total)
VALUES (101, 1, SYSDATE, 64970);

INSERT INTO VENTA (id_venta, id_comprador, fecha_venta, total)
VALUES (102, 2, SYSDATE, 22990);


-- =============================================
-- DATOS DE DETALLE_VENTA
-- Precio unitario = precio vigente de PRODUCTO
-- =============================================

INSERT INTO DETALLE_VENTA (
    id_detalle, id_venta, id_producto, cantidad, precio_unitario
)
VALUES (1001, 101, 1, 2, 19990);

INSERT INTO DETALLE_VENTA (
    id_detalle, id_venta, id_producto, cantidad, precio_unitario
)
VALUES (1002, 101, 3, 1, 24990);

INSERT INTO DETALLE_VENTA (
    id_detalle, id_venta, id_producto, cantidad, precio_unitario
)
VALUES (1003, 102, 5, 1, 22990);

COMMIT;