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