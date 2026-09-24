# =============================================
# CRUD DE VENTAS
# TiendaPolerasBDY1103_010V
# =============================================

from conexion import conectar


# =============================================
# REGISTRAR VENTA
# Solo cabecera, el total parte en cero
# =============================================

def registrar_venta(id_venta, id_comprador):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama al procedimiento del package
        cursor.callproc(
            "pkg_ventas.registrar_venta",
            [
                id_venta,
                id_comprador
            ]
        )

        conexion.commit()

        print("Venta registrada correctamente.")

    finally:

        cursor.close()
        conexion.close()


# =============================================
# AGREGAR DETALLE A UNA VENTA
# Valida stock y recalcula total en la BD
# =============================================

def agregar_detalle_venta(
    id_detalle,
    id_venta,
    id_producto,
    cantidad
):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama al procedimiento del package
        cursor.callproc(
            "pkg_ventas.agregar_detalle_venta",
            [
                id_detalle,
                id_venta,
                id_producto,
                cantidad
            ]
        )

        conexion.commit()

        print("Detalle agregado correctamente.")

    finally:

        cursor.close()
        conexion.close()


# =============================================
# LISTAR VENTAS CON DETALLE
# =============================================

def listar_ventas():

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Consulta ventas con comprador y detalle
        cursor.execute(
            """
            SELECT
                v.id_venta,
                c.nombre AS comprador,
                v.fecha_venta,
                v.total,
                d.id_producto,
                d.cantidad,
                d.precio_unitario
            FROM VENTA v
            JOIN COMPRADOR c
                ON v.id_comprador = c.id_comprador
            LEFT JOIN DETALLE_VENTA d
                ON d.id_venta = v.id_venta
            ORDER BY v.id_venta, d.id_detalle
            """
        )

        return cursor.fetchall()

    finally:

        cursor.close()
        conexion.close()
