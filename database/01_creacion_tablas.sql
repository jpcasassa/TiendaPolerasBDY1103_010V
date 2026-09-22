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