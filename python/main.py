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
        print("6. Salir")

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
        # SALIR
        # =====================================

        elif opcion == "6":

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