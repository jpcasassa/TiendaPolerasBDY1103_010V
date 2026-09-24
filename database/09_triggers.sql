-- =============================================
-- TRIGGERS
-- TiendaPolerasBDY1103_010V
-- =============================================


-- =============================================
-- TRIGGER PARA CONTROLAR EL STOCK
-- =============================================

CREATE OR REPLACE TRIGGER trg_controlar_stock
BEFORE INSERT OR UPDATE OF stock
ON PRODUCTO
FOR EACH ROW
BEGIN

    -- Verifica que el nuevo stock no sea negativo
    IF :NEW.stock < 0 THEN

        RAISE_APPLICATION_ERROR(
            -20001,
            'El stock no puede ser negativo.'
        );

    END IF;

END;
/

-- =============================================
-- TRIGGER PARA VALIDAR LA VENTA
-- Segunda barrera: el comprador debe existir
-- =============================================

CREATE OR REPLACE TRIGGER trg_validar_venta
BEFORE INSERT ON VENTA
FOR EACH ROW
DECLARE

    v_existe NUMBER;

BEGIN

    SELECT COUNT(*)
    INTO v_existe
    FROM COMPRADOR
    WHERE id_comprador = :NEW.id_comprador;

    IF v_existe = 0 THEN

        RAISE_APPLICATION_ERROR(
            -20002,
            'El comprador no existe.'
        );

    END IF;

    -- El total siempre parte recalculado, no manual negativo
    IF :NEW.total < 0 THEN

        RAISE_APPLICATION_ERROR(
            -20003,
            'El total de la venta no puede ser negativo.'
        );

    END IF;

END;
/

-- =============================================
-- TOTAL DE VENTA: lo recalcula agregar_detalle_venta
-- No existe trigger row-level sobre DETALLE_VENTA
-- porque consultarla ahí genera ORA-04091
-- (tabla mutante). Todo detalle debe pasar por
-- pkg_ventas.agregar_detalle_venta.
-- =============================================