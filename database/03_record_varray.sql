-- =============================================
-- RECORD Y VARRAY
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- RECORD
-- =============================================

DECLARE

    -- Guarda los datos de un producto en una sola estructura
    TYPE t_producto IS RECORD (
        id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        modelo     MODELO.NOMBRE%TYPE,
        color      COLOR.NOMBRE%TYPE,
        talla      TALLA.NOMBRE%TYPE,
        precio     PRODUCTO.PRECIO%TYPE,
        stock      PRODUCTO.STOCK%TYPE
    );

    v_producto t_producto;

BEGIN

    -- Busca un producto y almacena sus datos en el RECORD
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
    JOIN MODELO m
        ON p.id_modelo = m.id_modelo
    JOIN COLOR c
        ON p.id_color = c.id_color
    JOIN TALLA t
        ON p.id_talla = t.id_talla
    WHERE p.id_producto = 1;

    DBMS_OUTPUT.PUT_LINE('--- PRODUCTO ---');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_producto.id_producto);
    DBMS_OUTPUT.PUT_LINE('Modelo: ' || v_producto.modelo);
    DBMS_OUTPUT.PUT_LINE('Color: ' || v_producto.color);
    DBMS_OUTPUT.PUT_LINE('Talla: ' || v_producto.talla);
    DBMS_OUTPUT.PUT_LINE('Precio: ' || v_producto.precio);
    DBMS_OUTPUT.PUT_LINE('Stock: ' || v_producto.stock);

END;
/


-- =============================================
-- VARRAY
-- =============================================

DECLARE

    -- Almacena hasta cuatro tallas disponibles
    TYPE t_tallas IS VARRAY(4) OF TALLA.NOMBRE%TYPE;

    v_tallas t_tallas := t_tallas(
        'S',
        'M',
        'L',
        'XL'
    );

BEGIN

    DBMS_OUTPUT.PUT_LINE('--- TALLAS DISPONIBLES ---');

    -- Recorre las posiciones del VARRAY
    FOR i IN 1 .. v_tallas.COUNT LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Talla ' || i || ': ' || v_tallas(i)
        );

    END LOOP;

END;
/