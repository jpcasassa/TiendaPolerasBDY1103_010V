-- =============================================
-- EXCEPCIONES
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- EXCEPCION PREDEFINIDA
-- =============================================

DECLARE

    -- Variable para almacenar el nombre del modelo
    v_nombre MODELO.NOMBRE%TYPE;

BEGIN

    -- Busca un modelo que no existe
    SELECT nombre
    INTO v_nombre
    FROM MODELO
    WHERE id_modelo = 999;

    DBMS_OUTPUT.PUT_LINE(
        'Modelo encontrado: ' || v_nombre
    );

EXCEPTION

    -- Controla el error cuando no se encuentra ningún modelo
    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: No se encontró el modelo solicitado.'
        );

END;
/


-- =============================================
-- EXCEPCION DEFINIDA POR EL USUARIO
-- =============================================

DECLARE

    -- Variable para almacenar el stock actual
    v_stock PRODUCTO.STOCK%TYPE;

    -- Cantidad de productos que se intenta vender
    v_cantidad_solicitada NUMBER := 20;

    -- Excepción para controlar una venta
    -- superior al stock disponible
    e_stock_insuficiente EXCEPTION;

BEGIN

    -- Obtiene el stock del producto
    SELECT stock
    INTO v_stock
    FROM PRODUCTO
    WHERE id_producto = 1;

    -- Verifica si la cantidad solicitada supera el stock
    IF v_cantidad_solicitada > v_stock THEN

        RAISE e_stock_insuficiente;

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'Venta permitida. Stock disponible: ' || v_stock
        );

    END IF;

EXCEPTION

    -- Controla la excepción cuando no existe
    -- suficiente stock para la venta
    WHEN e_stock_insuficiente THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Stock insuficiente para realizar la venta.'
        );

END;
/