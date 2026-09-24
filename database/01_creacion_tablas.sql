-- =============================================
-- CREACION DE TABLAS
-- TiendaPolerasBDY1103_010V
-- =============================================

-- Tabla de modelos para poleras
CREATE TABLE MODELO (
    id_modelo NUMBER PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

-- Tabla de colores
CREATE TABLE COLOR (
    id_color NUMBER PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL
);

-- Tabla de tallas
CREATE TABLE TALLA (
    id_talla NUMBER PRIMARY KEY,
    nombre VARCHAR2(10) NOT NULL
);

-- Tabla de productos
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

-- Tabla de compradores
-- Almacena a quienes compran en la tienda
CREATE TABLE COMPRADOR (
    id_comprador NUMBER PRIMARY KEY,
    rut VARCHAR2(12) NOT NULL UNIQUE,
    nombre VARCHAR2(100) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    telefono VARCHAR2(20),
    direccion VARCHAR2(200),
    fecha_registro DATE DEFAULT SYSDATE NOT NULL
);

-- Tabla de ventas
-- Una venta pertenece a un comprador
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

-- Tabla de detalle de venta
-- Une una venta con los productos comprados
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