# =============================================
# PROGRAMA PRINCIPAL
# TiendaPolerasBDY1103_010V
# =============================================

from crud_producto import (
    insertar_producto,
    listar_productos,
    actualizar_stock,
    calcular_valor_stock,
    eliminar_producto
)

from crud_comprador import (
    insertar_comprador,
    listar_compradores,
    calcular_total_comprado,
    obtener_ticket_promedio
)

from crud_venta import (
    registrar_venta,
    agregar_detalle_venta,
    listar_ventas
)


# =============================================
# MOSTRAR PRODUCTOS
# =============================================

def mostrar_productos():

    productos = listar_productos()

    print("\n===== PRODUCTOS =====")

    if not productos:

        print("No existen productos.")

        return

    for producto in productos:

        print(
            "ID:", producto[0],
            "| Modelo:", producto[1],
            "| Color:", producto[2],
            "| Talla:", producto[3],
            "| Precio:", producto[4],
            "| Stock:", producto[5]
        )


# =============================================
# MOSTRAR COMPRADORES
# =============================================

def mostrar_compradores():

    compradores = listar_compradores()

    print("\n===== COMPRADORES =====")

    if not compradores:

        print("No existen compradores.")

        return

    for comprador in compradores:

        print(
            "ID:", comprador[0],
            "| RUT:", comprador[1],
            "| Nombre:", comprador[2],
            "| Email:", comprador[3]
        )


# =============================================
# MOSTRAR VENTAS
# =============================================

def mostrar_ventas():

    ventas = listar_ventas()

    print("\n===== VENTAS =====")

    if not ventas:

        print("No existen ventas.")

        return

    for venta in ventas:

        print(
            "Venta:", venta[0],
            "| Comprador:", venta[1],
            "| Total:", venta[3],
            "| Producto:", venta[4],
            "| Cant:", venta[5]
        )


# =============================================
# MENU PRINCIPAL
# =============================================

def menu():

    while True:

        print("\n===== TIENDA DE POLERAS =====")
        print("1. Listar productos")
        print("2. Insertar producto")
        print("3. Actualizar stock")
        print("4. Calcular valor del stock")
        print("5. Eliminar producto")
        print("6. Listar compradores")
        print("7. Insertar comprador")
        print("8. Registrar venta con detalle")
        print("9. Listar ventas")
        print("10. Total comprado por comprador")
        print("11. Salir")

        opcion = input(
            "Seleccione una opción: "
        )


        # =====================================
        # LISTAR
        # =====================================

        if opcion == "1":

            mostrar_productos()


        # =====================================
        # INSERTAR
        # =====================================

        elif opcion == "2":

            id_producto = int(
                input("ID del producto: ")
            )

            id_modelo = int(
                input("ID del modelo: ")
            )

            id_color = int(
                input("ID del color: ")
            )

            id_talla = int(
                input("ID de la talla: ")
            )

            precio = float(
                input("Precio: ")
            )

            stock = int(
                input("Stock: ")
            )

            insertar_producto(
                id_producto,
                id_modelo,
                id_color,
                id_talla,
                precio,
                stock
            )


        # =====================================
        # ACTUALIZAR STOCK
        # =====================================

        elif opcion == "3":

            id_producto = int(
                input("ID del producto: ")
            )

            nuevo_stock = int(
                input("Nuevo stock: ")
            )

            actualizar_stock(
                id_producto,
                nuevo_stock
            )


        # =====================================
        # CALCULAR VALOR DEL STOCK
        # =====================================

        elif opcion == "4":

            id_producto = int(
                input("ID del producto: ")
            )

            valor = calcular_valor_stock(
                id_producto
            )

            print(
                "Valor total del stock: $",
                valor
            )


        # =====================================
        # ELIMINAR
        # =====================================

        elif opcion == "5":

            id_producto = int(
                input("ID del producto: ")
            )

            eliminar_producto(
                id_producto
            )


        # =====================================
        # LISTAR COMPRADORES
        # =====================================

        elif opcion == "6":

            mostrar_compradores()


        # =====================================
        # INSERTAR COMPRADOR
        # =====================================

        elif opcion == "7":

            id_comprador = int(
                input("ID del comprador: ")
            )

            rut = input("RUT (formato 12345678-9): ")

            nombre = input("Nombre: ")

            email = input("Email: ")

            telefono = input("Teléfono: ")

            direccion = input("Dirección: ")

            insertar_comprador(
                id_comprador,
                rut,
                nombre,
                email,
                telefono,
                direccion
            )


        # =====================================
        # REGISTRAR VENTA CON DETALLE
        # =====================================

        elif opcion == "8":

            id_venta = int(
                input("ID de la venta: ")
            )

            id_comprador = int(
                input("ID del comprador: ")
            )

            registrar_venta(
                id_venta,
                id_comprador
            )

            id_detalle = int(
                input("ID del detalle: ")
            )

            id_producto = int(
                input("ID del producto: ")
            )

            cantidad = int(
                input("Cantidad: ")
            )

            agregar_detalle_venta(
                id_detalle,
                id_venta,
                id_producto,
                cantidad
            )


        # =====================================
        # LISTAR VENTAS
        # =====================================

        elif opcion == "9":

            mostrar_ventas()


        # =====================================
        # TOTAL COMPRADO
        # =====================================

        elif opcion == "10":

            id_comprador = int(
                input("ID del comprador: ")
            )

            total = calcular_total_comprado(
                id_comprador
            )

            promedio = obtener_ticket_promedio(
                id_comprador
            )

            print(
                "Total comprado: $",
                total
            )

            print(
                "Ticket promedio: $",
                promedio
            )


        # =====================================
        # SALIR
        # =====================================

        elif opcion == "11":

            print("Programa finalizado.")

            break


        # =====================================
        # OPCION INCORRECTA
        # =====================================

        else:

            print("Opción no válida.")


# =============================================
# INICIO DEL PROGRAMA
# =============================================

menu()