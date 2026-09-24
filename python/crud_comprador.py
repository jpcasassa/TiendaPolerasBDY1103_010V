# =============================================
# CRUD DE COMPRADORES
# TiendaPolerasBDY1103_010V
# =============================================

from conexion import conectar


# =============================================
# INSERTAR COMPRADOR
# =============================================

def insertar_comprador(
    id_comprador,
    rut,
    nombre,
    email,
    telefono,
    direccion
):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama al procedimiento del package
        cursor.callproc(
            "pkg_ventas.insertar_comprador",
            [
                id_comprador,
                rut,
                nombre,
                email,
                telefono,
                direccion
            ]
        )

        conexion.commit()

        print("Comprador insertado correctamente.")

    finally:

        cursor.close()
        conexion.close()


# =============================================
# LISTAR COMPRADORES
# =============================================

def listar_compradores():

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Consulta los compradores registrados
        cursor.execute(
            """
            SELECT
                id_comprador,
                rut,
                nombre,
                email,
                telefono,
                direccion
            FROM COMPRADOR
            ORDER BY id_comprador
            """
        )

        return cursor.fetchall()

    finally:

        cursor.close()
        conexion.close()


# =============================================
# TOTAL COMPRADO POR COMPRADOR
# =============================================

def calcular_total_comprado(id_comprador):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama a la función del package
        valor = cursor.callfunc(
            "pkg_ventas.calcular_total_comprado",
            float,
            [id_comprador]
        )

        return valor

    finally:

        cursor.close()
        conexion.close()


# =============================================
# TICKET PROMEDIO POR COMPRADOR
# =============================================

def obtener_ticket_promedio(id_comprador):

    conexion = conectar()
    cursor = conexion.cursor()

    try:

        # Llama a la función del package
        valor = cursor.callfunc(
            "pkg_ventas.obtener_ticket_promedio",
            float,
            [id_comprador]
        )

        return valor

    finally:

        cursor.close()
        conexion.close()
