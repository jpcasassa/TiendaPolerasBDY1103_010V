# =============================================
# CRUD DE PRODUCTOS
# TiendaPolerasBDY1103_010V
# =============================================

from conexion import conectar


# =============================================
# INSERTAR PRODUCTO
# =============================================

def insertar_producto(
    id_producto,
    id_modelo,
    id_color,
    id_talla,
    precio,
    stock
):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama al procedimiento del package
        cursor.callproc(
            "pkg_productos.insertar_producto",
            [
                id_producto,
                id_modelo,
                id_color,
                id_talla,
                precio,
                stock
            ]
        )

        conexion.commit()

        print("Producto insertado correctamente.")

    finally:

        cursor.close()
        conexion.close()


# =============================================
# LISTAR PRODUCTOS
# =============================================

def listar_productos():

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Consulta los productos junto con
        # su modelo, color y talla
        cursor.execute(
            """
            SELECT
                p.id_producto,
                m.nombre AS modelo,
                c.nombre AS color,
                t.nombre AS talla,
                p.precio,
                p.stock
            FROM PRODUCTO p
            JOIN MODELO m
                ON p.id_modelo = m.id_modelo
            JOIN COLOR c
                ON p.id_color = c.id_color
            JOIN TALLA t
                ON p.id_talla = t.id_talla
            ORDER BY p.id_producto
            """
        )

        return cursor.fetchall()

    finally:

        cursor.close()
        conexion.close()


# =============================================
# ACTUALIZAR STOCK
# =============================================

def actualizar_stock(id_producto, nuevo_stock):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama al procedimiento del package
        cursor.callproc(
            "pkg_productos.actualizar_stock",
            [
                id_producto,
                nuevo_stock
            ]
        )

        conexion.commit()

        print("Stock actualizado correctamente.")

    finally:

        cursor.close()
        conexion.close()


# =============================================
# CALCULAR VALOR DEL STOCK
# =============================================

def calcular_valor_stock(id_producto):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama a la función del package
        valor = cursor.callfunc(
            "pkg_productos.calcular_valor_stock",
            float,
            [id_producto]
        )

        return valor

    finally:

        cursor.close()
        conexion.close()


# =============================================
# ELIMINAR PRODUCTO
# =============================================

def eliminar_producto(id_producto):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Elimina el producto indicado
        cursor.execute(
            """
            DELETE FROM PRODUCTO
            WHERE id_producto = :id_producto
            """,
            {
                "id_producto": id_producto
            }
        )

        conexion.commit()

        print("Producto eliminado correctamente.")

    finally:

        cursor.close()
        conexion.close()