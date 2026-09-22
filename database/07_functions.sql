-- =============================================
-- FUNCIONES
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- FUNCION PARA CALCULAR EL VALOR DEL STOCK
-- =============================================

CREATE OR REPLACE FUNCTION calcular_valor_stock(
    p_id_producto PRODUCTO.ID_PRODUCTO%TYPE
)
RETURN NUMBER
IS

    -- Variables para almacenar el precio y el stock
    v_precio PRODUCTO.PRECIO%TYPE;
    v_stock  PRODUCTO.STOCK%TYPE;

BEGIN

    -- Obtiene el precio y el stock del producto
    SELECT precio, stock
    INTO v_precio, v_stock
    FROM PRODUCTO
    WHERE id_producto = p_id_producto;

    -- Devuelve el valor total del stock
    RETURN v_precio * v_stock;

END;
/