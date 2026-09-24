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

-- =============================================
-- PACKAGE DE VENTAS
-- Agrupa la lógica de compradores y ventas
-- =============================================


-- =============================================
-- ESPECIFICACION DEL PACKAGE
-- =============================================

CREATE OR REPLACE PACKAGE pkg_ventas IS

    -- Inserta un nuevo comprador
    PROCEDURE insertar_comprador(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
        p_rut          COMPRADOR.RUT%TYPE,
        p_nombre       COMPRADOR.NOMBRE%TYPE,
        p_email        COMPRADOR.EMAIL%TYPE,
        p_telefono     COMPRADOR.TELEFONO%TYPE,
        p_direccion    COMPRADOR.DIRECCION%TYPE
    );

    -- Registra la cabecera de una venta
    PROCEDURE registrar_venta(
        p_id_venta     VENTA.ID_VENTA%TYPE,
        p_id_comprador VENTA.ID_COMPRADOR%TYPE
    );

    -- Agrega un producto a una venta con control de stock
    PROCEDURE agregar_detalle_venta(
        p_id_detalle  DETALLE_VENTA.ID_DETALLE%TYPE,
        p_id_venta    DETALLE_VENTA.ID_VENTA%TYPE,
        p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
        p_cantidad    DETALLE_VENTA.CANTIDAD%TYPE
    );

    -- Calcula el total comprado por un comprador
    FUNCTION calcular_total_comprado(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER;

    -- Obtiene el ticket promedio del comprador
    FUNCTION obtener_ticket_promedio(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER;

END pkg_ventas;
/


-- =============================================
-- CUERPO DEL PACKAGE
-- =============================================

CREATE OR REPLACE PACKAGE BODY pkg_ventas IS


    -- =============================================
    -- PROCEDIMIENTO PARA INSERTAR COMPRADOR
    -- =============================================

    PROCEDURE insertar_comprador(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE,
        p_rut          COMPRADOR.RUT%TYPE,
        p_nombre       COMPRADOR.NOMBRE%TYPE,
        p_email        COMPRADOR.EMAIL%TYPE,
        p_telefono     COMPRADOR.TELEFONO%TYPE,
        p_direccion    COMPRADOR.DIRECCION%TYPE
    )
    IS

        e_rut_invalido EXCEPTION;

    BEGIN

        -- Valida formato mínimo del RUT
        IF INSTR(p_rut, '-') = 0 THEN

            RAISE e_rut_invalido;

        END IF;

        INSERT INTO COMPRADOR (
            id_comprador, rut, nombre, email, telefono, direccion
        )
        VALUES (
            p_id_comprador, p_rut, p_nombre,
            p_email, p_telefono, p_direccion
        );

        COMMIT;

    EXCEPTION

        WHEN DUP_VAL_ON_INDEX THEN

            ROLLBACK;
            RAISE;

        WHEN e_rut_invalido THEN

            RAISE;

    END insertar_comprador;


    -- =============================================
    -- PROCEDIMIENTO PARA REGISTRAR VENTA
    -- =============================================

    PROCEDURE registrar_venta(
        p_id_venta     VENTA.ID_VENTA%TYPE,
        p_id_comprador VENTA.ID_COMPRADOR%TYPE
    )
    IS

        v_existe NUMBER;

    BEGIN

        SELECT COUNT(*)
        INTO v_existe
        FROM COMPRADOR
        WHERE id_comprador = p_id_comprador;

        IF v_existe = 0 THEN

            RAISE_APPLICATION_ERROR(
                -20002,
                'El comprador no existe.'
            );

        END IF;

        INSERT INTO VENTA (id_venta, id_comprador, fecha_venta, total)
        VALUES (p_id_venta, p_id_comprador, SYSDATE, 0);

        COMMIT;

    END registrar_venta;


    -- =============================================
    -- PROCEDIMIENTO PARA AGREGAR DETALLE
    -- =============================================

    PROCEDURE agregar_detalle_venta(
        p_id_detalle  DETALLE_VENTA.ID_DETALLE%TYPE,
        p_id_venta    DETALLE_VENTA.ID_VENTA%TYPE,
        p_id_producto DETALLE_VENTA.ID_PRODUCTO%TYPE,
        p_cantidad    DETALLE_VENTA.CANTIDAD%TYPE
    )
    IS

        v_stock  PRODUCTO.STOCK%TYPE;
        v_precio PRODUCTO.PRECIO%TYPE;

        e_stock_insuficiente EXCEPTION;

    BEGIN

        SELECT stock, precio
        INTO v_stock, v_precio
        FROM PRODUCTO
        WHERE id_producto = p_id_producto
        FOR UPDATE;

        IF p_cantidad > v_stock THEN

            RAISE e_stock_insuficiente;

        END IF;

        INSERT INTO DETALLE_VENTA (
            id_detalle, id_venta, id_producto,
            cantidad, precio_unitario
        )
        VALUES (
            p_id_detalle, p_id_venta, p_id_producto,
            p_cantidad, v_precio
        );

        UPDATE PRODUCTO
        SET stock = stock - p_cantidad
        WHERE id_producto = p_id_producto;

        UPDATE VENTA
        SET total = (
            SELECT NVL(SUM(cantidad * precio_unitario), 0)
            FROM DETALLE_VENTA
            WHERE id_venta = p_id_venta
        )
        WHERE id_venta = p_id_venta;

        COMMIT;

    EXCEPTION

        WHEN e_stock_insuficiente THEN

            ROLLBACK;
            RAISE;

        WHEN OTHERS THEN

            ROLLBACK;
            RAISE;

    END agregar_detalle_venta;


    -- =============================================
    -- FUNCION TOTAL COMPRADO
    -- =============================================

    FUNCTION calcular_total_comprado(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER
    IS

        v_total NUMBER := 0;

    BEGIN

        SELECT NVL(SUM(total), 0)
        INTO v_total
        FROM VENTA
        WHERE id_comprador = p_id_comprador;

        RETURN v_total;

    END calcular_total_comprado;


    -- =============================================
    -- FUNCION TICKET PROMEDIO
    -- =============================================

    FUNCTION obtener_ticket_promedio(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    )
    RETURN NUMBER
    IS

        v_cantidad NUMBER := 0;
        v_suma NUMBER := 0;

    BEGIN

        SELECT COUNT(*), NVL(SUM(total), 0)
        INTO v_cantidad, v_suma
        FROM VENTA
        WHERE id_comprador = p_id_comprador;

        IF v_cantidad = 0 THEN

            RETURN 0;

        END IF;

        RETURN v_suma / v_cantidad;

    END obtener_ticket_promedio;

END pkg_ventas;
/