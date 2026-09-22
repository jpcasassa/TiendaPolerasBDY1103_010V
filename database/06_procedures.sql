-- =============================================
-- PROCEDIMIENTOS
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- PROCEDIMIENTO PARA INSERTAR UN PRODUCTO
-- =============================================

CREATE OR REPLACE PROCEDURE insertar_producto(
    p_id_producto   PRODUCTO.ID_PRODUCTO%TYPE,
    p_id_modelo     PRODUCTO.ID_MODELO%TYPE,
    p_id_color      PRODUCTO.ID_COLOR%TYPE,
    p_id_talla      PRODUCTO.ID_TALLA%TYPE,
    p_precio        PRODUCTO.PRECIO%TYPE,
    p_stock         PRODUCTO.STOCK%TYPE
)
IS
BEGIN

    -- Inserta un nuevo producto con los datos recibidos
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


-- =============================================
-- PROCEDIMIENTO PARA ACTUALIZAR EL STOCK
-- =============================================

CREATE OR REPLACE PROCEDURE actualizar_stock(
    p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
    p_nuevo_stock PRODUCTO.STOCK%TYPE
)
IS
BEGIN

    -- Actualiza el stock del producto indicado
    UPDATE PRODUCTO
    SET stock = p_nuevo_stock
    WHERE id_producto = p_id_producto;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Stock actualizado correctamente.'
    );

END;
/