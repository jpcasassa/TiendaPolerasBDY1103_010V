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