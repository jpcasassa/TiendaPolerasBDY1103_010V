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

-- =============================================
-- FUNCION PARA CALCULAR EL TOTAL COMPRADO
-- Suma todas las ventas de un comprador
-- =============================================

CREATE OR REPLACE FUNCTION calcular_total_comprado(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
)
RETURN NUMBER
IS

    -- Acumula el total de las ventas
    v_total NUMBER := 0;

BEGIN

    -- Suma el total de ventas del comprador
    SELECT NVL(SUM(total), 0)
    INTO v_total
    FROM VENTA
    WHERE id_comprador = p_id_comprador;

    -- Devuelve lo acumulado
    RETURN v_total;

END;
/

-- =============================================
-- FUNCION PARA OBTENER EL TICKET PROMEDIO
-- Promedio por venta, cero si no tiene ventas
-- =============================================

CREATE OR REPLACE FUNCTION obtener_ticket_promedio(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
)
RETURN NUMBER
IS

    -- Guarda cantidad de ventas y suma total
    v_cantidad NUMBER := 0;
    v_suma NUMBER := 0;

BEGIN

    -- Cuenta ventas y suma sus totales
    SELECT COUNT(*), NVL(SUM(total), 0)
    INTO v_cantidad, v_suma
    FROM VENTA
    WHERE id_comprador = p_id_comprador;

    -- Evita división por cero
    IF v_cantidad = 0 THEN

        RETURN 0;

    END IF;

    -- Devuelve el promedio por venta
    RETURN v_suma / v_cantidad;

END;
/