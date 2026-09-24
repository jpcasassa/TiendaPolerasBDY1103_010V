-- =============================================
-- RECORD Y VARRAY
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- RECORD
-- =============================================
-- Se usan tipos simples dentro del RECORD para evitar dependencias
-- de %TYPE en la declaracion local del bloque anonimo.

DECLARE

    -- Guarda los datos de un producto en una sola estructura
    TYPE t_producto IS RECORD (
        id_producto     NUMBER,
        modelo          VARCHAR2(50),
        color           VARCHAR2(30),
        talla           VARCHAR2(10),
        precio          NUMBER(10,2),
        stock           NUMBER
    );

    v_producto t_producto;

BEGIN

    -- Busca un producto y almacena sus datos en el RECORD
    SELECT
        p.id_producto,
        m.nombre,
        c.nombre,
        t.nombre,
        p.precio,
        p.stock
    INTO
        v_producto.id_producto,
        v_producto.modelo,
        v_producto.color,
        v_producto.talla,
        v_producto.precio,
        v_producto.stock
    FROM PRODUCTO p
    JOIN MODELO m
        ON p.id_modelo = m.id_modelo
    JOIN COLOR c
        ON p.id_color = c.id_color
    JOIN TALLA t
        ON p.id_talla = t.id_talla
    WHERE p.id_producto = 1;

    DBMS_OUTPUT.PUT_LINE('--- PRODUCTO ---');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_producto.id_producto);
    DBMS_OUTPUT.PUT_LINE('Modelo: ' || v_producto.modelo);
    DBMS_OUTPUT.PUT_LINE('Color: ' || v_producto.color);
    DBMS_OUTPUT.PUT_LINE('Talla: ' || v_producto.talla);
    DBMS_OUTPUT.PUT_LINE('Precio: ' || v_producto.precio);
    DBMS_OUTPUT.PUT_LINE('Stock: ' || v_producto.stock);

END;
/


-- =============================================
-- VARRAY
-- =============================================

DECLARE

    -- Almacena hasta cuatro tallas disponibles
    TYPE t_tallas IS VARRAY(4) OF TALLA.NOMBRE%TYPE;

    v_tallas t_tallas := t_tallas(
        'S',
        'M',
        'L',
        'XL'
    );

BEGIN

    DBMS_OUTPUT.PUT_LINE('--- TALLAS DISPONIBLES ---');

    -- Recorre las posiciones del VARRAY
    FOR i IN 1 .. v_tallas.COUNT LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Talla ' || i || ': ' || v_tallas(i)
        );

    END LOOP;

END;
/

-- =============================================
-- RECORD DE COMPRADOR
-- =============================================

DECLARE

    -- Guarda la ficha de un comprador con su total comprado
    TYPE t_comprador IS RECORD (
        id_comprador  NUMBER,
        rut           VARCHAR2(12),
        nombre        VARCHAR2(100),
        email         VARCHAR2(100),
        total_compras NUMBER
    );

    v_comprador t_comprador;

BEGIN

    -- Busca el comprador y suma sus ventas en una sola estructura
    SELECT
        c.id_comprador,
        c.rut,
        c.nombre,
        c.email,
        NVL(SUM(v.total), 0)
    INTO
        v_comprador.id_comprador,
        v_comprador.rut,
        v_comprador.nombre,
        v_comprador.email,
        v_comprador.total_compras
    FROM COMPRADOR c
    LEFT JOIN VENTA v
        ON v.id_comprador = c.id_comprador
    WHERE c.id_comprador = 1
    GROUP BY c.id_comprador, c.rut, c.nombre, c.email;

    DBMS_OUTPUT.PUT_LINE('--- COMPRADOR ---');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_comprador.id_comprador);
    DBMS_OUTPUT.PUT_LINE('RUT: ' || v_comprador.rut);
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_comprador.nombre);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_comprador.email);
    DBMS_OUTPUT.PUT_LINE('Total compras: $' || v_comprador.total_compras);

END;
/


-- =============================================
-- VARRAY DE PRODUCTOS COMPRADOS
-- =============================================

DECLARE

    -- Almacena hasta diez productos comprados en una venta
    TYPE t_productos_comprados IS VARRAY(10) OF VARCHAR2(50);

    v_productos t_productos_comprados := t_productos_comprados();

    -- Guarda el id de la venta a listar
    v_id_venta VENTA.ID_VENTA%TYPE := 101;

BEGIN

    -- Carga los modelos comprados en la venta indicada
    SELECT m.nombre
    BULK COLLECT INTO v_productos
    FROM DETALLE_VENTA d
    JOIN PRODUCTO p
        ON d.id_producto = p.id_producto
    JOIN MODELO m
        ON p.id_modelo = m.id_modelo
    WHERE d.id_venta = v_id_venta
    AND ROWNUM <= 10;

    DBMS_OUTPUT.PUT_LINE('--- PRODUCTOS VENTA ' || v_id_venta || ' ---');

    -- Recorre las posiciones del VARRAY
    FOR i IN 1 .. v_productos.COUNT LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Producto ' || i || ': ' || v_productos(i)
        );

    END LOOP;

END;
/