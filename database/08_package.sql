-- =============================================
-- PACKAGE DE PRODUCTOS
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- ESPECIFICACION DEL PACKAGE
-- =============================================

CREATE OR REPLACE PACKAGE pkg_productos IS

    -- Inserta un nuevo producto
    PROCEDURE insertar_producto(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_id_modelo  PRODUCTO.ID_MODELO%TYPE,
        p_id_color   PRODUCTO.ID_COLOR%TYPE,
        p_id_talla   PRODUCTO.ID_TALLA%TYPE,
        p_precio     PRODUCTO.PRECIO%TYPE,
        p_stock      PRODUCTO.STOCK%TYPE
    );

    -- Actualiza el stock de un producto
    PROCEDURE actualizar_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_nuevo_stock PRODUCTO.STOCK%TYPE
    );

    -- Calcula el valor total del stock
    FUNCTION calcular_valor_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
    )
    RETURN NUMBER;

END pkg_productos;
/


-- =============================================
-- CUERPO DEL PACKAGE
-- =============================================

CREATE OR REPLACE PACKAGE BODY pkg_productos IS


    -- =============================================
    -- PROCEDIMIENTO PARA INSERTAR
    -- =============================================

    PROCEDURE insertar_producto(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_id_modelo  PRODUCTO.ID_MODELO%TYPE,
        p_id_color   PRODUCTO.ID_COLOR%TYPE,
        p_id_talla   PRODUCTO.ID_TALLA%TYPE,
        p_precio     PRODUCTO.PRECIO%TYPE,
        p_stock      PRODUCTO.STOCK%TYPE
    )
    IS
    BEGIN

        -- Inserta el producto recibido
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


    -- =============================================
    -- PROCEDIMIENTO PARA ACTUALIZAR STOCK
    -- =============================================

    PROCEDURE actualizar_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE,
        p_nuevo_stock PRODUCTO.STOCK%TYPE
    )
    IS
    BEGIN

        -- Actualiza el stock del producto
        UPDATE PRODUCTO
        SET stock = p_nuevo_stock
        WHERE id_producto = p_id_producto;

        COMMIT;

    END actualizar_stock;


    -- =============================================
    -- FUNCION PARA CALCULAR EL VALOR DEL STOCK
    -- =============================================

    FUNCTION calcular_valor_stock(
        p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
    )
    RETURN NUMBER
    IS

        -- Guarda el precio del producto
        v_precio PRODUCTO.PRECIO%TYPE;

        -- Guarda el stock del producto
        v_stock PRODUCTO.STOCK%TYPE;

    BEGIN

        -- Obtiene precio y stock del producto
        SELECT precio, stock
        INTO v_precio, v_stock
        FROM PRODUCTO
        WHERE id_producto = p_id_producto;

        -- Devuelve precio multiplicado por stock
        RETURN v_precio * v_stock;

    END calcular_valor_stock;

END pkg_productos;
/