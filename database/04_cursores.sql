-- =============================================
-- CURSORES
-- TiendaPolerasBDY1103_010V
-- =============================================

DECLARE

    -- Obtiene todos los modelos de la tienda
    CURSOR c_modelos IS
        SELECT id_modelo, nombre
        FROM MODELO
        ORDER BY id_modelo;


    -- Obtiene los productos de un modelo recibido
    -- como parámetro
    CURSOR c_productos(
        p_id_modelo MODELO.ID_MODELO%TYPE
    ) IS
        SELECT
            p.id_producto,
            c.nombre AS color,
            t.nombre AS talla,
            p.precio,
            p.stock
        FROM PRODUCTO p
        JOIN COLOR c
            ON p.id_color = c.id_color
        JOIN TALLA t
            ON p.id_talla = t.id_talla
        WHERE p.id_modelo = p_id_modelo
        ORDER BY p.id_producto;

BEGIN

    -- Recorre los modelos
    FOR r_modelo IN c_modelos LOOP

        DBMS_OUTPUT.PUT_LINE(
            '--- Modelo: ' || r_modelo.nombre || ' ---'
        );

        -- Recorre los productos del modelo actual
        FOR r_producto IN c_productos(r_modelo.id_modelo) LOOP

            DBMS_OUTPUT.PUT_LINE(
                'Producto: ' || r_producto.id_producto ||
                ' | Color: ' || r_producto.color ||
                ' | Talla: ' || r_producto.talla ||
                ' | Precio: $' || r_producto.precio ||
                ' | Stock: ' || r_producto.stock
            );

        END LOOP;

    END LOOP;

END;
/

-- =============================================
-- CURSORES DE COMPRADORES Y VENTAS
-- =============================================

DECLARE

    -- Obtiene todos los compradores registrados
    CURSOR c_compradores IS
        SELECT id_comprador, rut, nombre
        FROM COMPRADOR
        ORDER BY id_comprador;


    -- Obtiene las ventas de un comprador recibido
    -- como parámetro
    CURSOR c_ventas(
        p_id_comprador COMPRADOR.ID_COMPRADOR%TYPE
    ) IS
        SELECT
            v.id_venta,
            v.fecha_venta,
            v.total,
            d.id_producto,
            m.nombre AS modelo,
            d.cantidad,
            d.precio_unitario,
            (d.cantidad * d.precio_unitario) AS subtotal
        FROM VENTA v
        JOIN DETALLE_VENTA d
            ON d.id_venta = v.id_venta
        JOIN PRODUCTO p
            ON d.id_producto = p.id_producto
        JOIN MODELO m
            ON p.id_modelo = m.id_modelo
        WHERE v.id_comprador = p_id_comprador
        ORDER BY v.id_venta, d.id_detalle;

BEGIN

    -- Recorre los compradores
    FOR r_comprador IN c_compradores LOOP

        DBMS_OUTPUT.PUT_LINE(
            '--- Comprador: ' || r_comprador.nombre ||
            ' (' || r_comprador.rut || ') ---'
        );

        -- Recorre las ventas con su detalle del comprador actual
        FOR r_venta IN c_ventas(r_comprador.id_comprador) LOOP

            DBMS_OUTPUT.PUT_LINE(
                'Venta: ' || r_venta.id_venta ||
                ' | Modelo: ' || r_venta.modelo ||
                ' | Cant: ' || r_venta.cantidad ||
                ' | Subtotal: $' || r_venta.subtotal ||
                ' | Total venta: $' || r_venta.total
            );

        END LOOP;

    END LOOP;

END;
/