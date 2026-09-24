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

-- =============================================
-- EXCEPCION PREDEFINIDA: COMPRADOR DUPLICADO
-- =============================================

DECLARE

    -- Variables con datos de un comprador ya existente
    v_id_comprador COMPRADOR.ID_COMPRADOR%TYPE := 99;
    v_rut COMPRADOR.RUT%TYPE := '12345678-9';
    v_nombre COMPRADOR.NOMBRE%TYPE := 'Duplicado';

BEGIN

    -- Intenta insertar un RUT que ya existe
    INSERT INTO COMPRADOR (id_comprador, rut, nombre)
    VALUES (v_id_comprador, v_rut, v_nombre);

    ROLLBACK;

EXCEPTION

    -- Controla el error cuando el RUT o email ya existe
    WHEN DUP_VAL_ON_INDEX THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El RUT o email del comprador ya está registrado.'
        );

END;
/


-- =============================================
-- EXCEPCIONES DE USUARIO: VENTA A COMPRADOR
-- =============================================

DECLARE

    -- Comprador a evaluar
    v_id_comprador COMPRADOR.ID_COMPRADOR%TYPE := 3;

    -- Total acumulado y cantidad de ventas
    v_total NUMBER := 0;
    v_cantidad_ventas NUMBER := 0;

    -- Excepción cuando el RUT no tiene formato válido
    e_rut_invalido EXCEPTION;

    -- Excepción cuando el comprador no tiene ventas
    e_comprador_sin_ventas EXCEPTION;

    -- RUT a validar (debe contener guion)
    v_rut COMPRADOR.RUT%TYPE;

BEGIN

    -- Obtiene el RUT del comprador
    SELECT rut
    INTO v_rut
    FROM COMPRADOR
    WHERE id_comprador = v_id_comprador;

    -- Verifica formato mínimo del RUT con dígito verificador
    IF INSTR(v_rut, '-') = 0 THEN

        RAISE e_rut_invalido;

    END IF;

    -- Suma las ventas del comprador
    SELECT COUNT(*), NVL(SUM(total), 0)
    INTO v_cantidad_ventas, v_total
    FROM VENTA
    WHERE id_comprador = v_id_comprador;

    -- Verifica si el comprador tiene movimientos
    IF v_cantidad_ventas = 0 THEN

        RAISE e_comprador_sin_ventas;

    END IF;

    DBMS_OUTPUT.PUT_LINE(
        'Comprador ' || v_id_comprador ||
        ' total: $' || v_total
    );

EXCEPTION

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: No se encontró el comprador solicitado.'
        );

    WHEN e_rut_invalido THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El RUT del comprador no tiene formato válido.'
        );

    WHEN e_comprador_sin_ventas THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El comprador no registra ventas.'
        );

END;
/