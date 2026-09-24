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

-- =============================================
-- PROCEDIMIENTO PARA INSERTAR UN COMPRADOR
-- =============================================

CREATE OR REPLACE PROCEDURE insertar_comprador(
    p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
    p_rut          COMPRADOR.RUT%TYPE,
    p_nombre       COMPRADOR.NOMBRE%TYPE,
    p_email        COMPRADOR.EMAIL%TYPE,
    p_telefono     COMPRADOR.TELEFONO%TYPE,
    p_direccion    COMPRADOR.DIRECCION%TYPE
)
IS

    -- Excepción cuando el RUT no trae guion verificador
    e_rut_invalido EXCEPTION;

BEGIN

    -- Valida formato mínimo del RUT
    IF INSTR(p_rut, '-') = 0 THEN

        RAISE e_rut_invalido;

    END IF;

    -- Inserta el comprador con los datos recibidos
    INSERT INTO COMPRADOR (
        id_comprador,
        rut,
        nombre,
        email,
        telefono,
        direccion
    )
    VALUES (
        p_id_comprador,
        p_rut,
        p_nombre,
        p_email,
        p_telefono,
        p_direccion
    );

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Comprador insertado correctamente.'
    );

EXCEPTION

    WHEN DUP_VAL_ON_INDEX THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: RUT o email duplicado.'
        );

        RAISE;

    WHEN e_rut_invalido THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: RUT sin formato válido.'
        );

        RAISE;

END;
/


-- =============================================
-- PROCEDIMIENTO PARA REGISTRAR UNA VENTA
-- Cabecera sin detalle, total parte en cero
-- =============================================

CREATE OR REPLACE PROCEDURE registrar_venta(
    p_id_venta     VENTA.ID_VENTA%TYPE,
    p_id_comprador VENTA.ID_COMPRADOR%TYPE
)
IS

    -- Contador para verificar el comprador
    v_existe NUMBER;

BEGIN

    -- Verifica que el comprador exista
    SELECT COUNT(*)
    INTO v_existe
    FROM COMPRADOR
    WHERE id_comprador = p_id_comprador;

    -- Si no existe se deja el error a la FK
    IF v_existe = 0 THEN

        RAISE_APPLICATION_ERROR(
            -20002,
            'El comprador no existe.'
        );

    END IF;

    -- Crea la venta con total cero
    INSERT INTO VENTA (id_venta, id_comprador, fecha_venta, total)
    VALUES (p_id_venta, p_id_comprador, SYSDATE, 0);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Venta registrada correctamente.'
    );

END;
/


-- =============================================
-- PROCEDIMIENTO PARA AGREGAR DETALLE A UNA VENTA
-- Mitigación riesgo stock: valida, descuenta y
-- recalcula total en una sola transacción
-- =============================================

CREATE OR REPLACE PROCEDURE agregar_detalle_venta(
    p_id_detalle  DETALLE_VENTA.ID_DETALLE%TYPE,
    p_id_venta    DETALLE_VENTA.ID_VENTA%TYPE,
    p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
    p_cantidad    DETALLE_VENTA.CANTIDAD%TYPE
)
IS

    -- Stock y precio vigentes del producto
    v_stock  PRODUCTO.STOCK%TYPE;
    v_precio PRODUCTO.PRECIO%TYPE;

    -- Excepción cuando no alcanza el stock
    e_stock_insuficiente EXCEPTION;

BEGIN

    -- Bloquea el producto para evitar doble venta
    SELECT stock, precio
    INTO v_stock, v_precio
    FROM PRODUCTO
    WHERE id_producto = p_id_producto
    FOR UPDATE;

    -- Primera barrera: no vender más de lo disponible
    IF p_cantidad > v_stock THEN

        RAISE e_stock_insuficiente;

    END IF;

    -- Inserta el detalle con precio vigente, no manual
    INSERT INTO DETALLE_VENTA (
        id_detalle,
        id_venta,
        id_producto,
        cantidad,
        precio_unitario
    )
    VALUES (
        p_id_detalle,
        p_id_venta,
        p_id_producto,
        p_cantidad,
        v_precio
    );

    -- Descuenta el stock del producto
    UPDATE PRODUCTO
    SET stock = stock - p_cantidad
    WHERE id_producto = p_id_producto;

    -- Recalcula el total desde el detalle, no desde parámetro
    UPDATE VENTA
    SET total = (
        SELECT NVL(SUM(cantidad * precio_unitario), 0)
        FROM DETALLE_VENTA
        WHERE id_venta = p_id_venta
    )
    WHERE id_venta = p_id_venta;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE(
        'Detalle agregado correctamente.'
    );

EXCEPTION

    WHEN e_stock_insuficiente THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Stock insuficiente para realizar la venta.'
        );

        RAISE;

    WHEN NO_DATA_FOUND THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Venta o producto inexistente.'
        );

        RAISE;

    WHEN DUP_VAL_ON_INDEX THEN

        ROLLBACK;

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Producto ya ingresado en esta venta.'
        );

        RAISE;

    WHEN OTHERS THEN

        ROLLBACK;

        RAISE;

END;
/