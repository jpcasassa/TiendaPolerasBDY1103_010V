# =============================================
# CONEXION A ORACLE
# TiendaPolerasBDY1103_010V
# =============================================

import oracledb


# Datos de conexión a Oracle
DB_USER = "TIENDA_POLERAS"
DB_PASSWORD = "Tienda123"
DB_DSN = "localhost:1521/XEPDB1"


def conectar():
    # Crea una conexión con Oracle
    conexion = oracledb.connect(
        user=DB_USER,
        password=DB_PASSWORD,
        dsn=DB_DSN
    )

    return conexion