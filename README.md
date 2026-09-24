# TiendaPolerasBDY1103_010V

Proyecto de base de datos para la gestión de una tienda de poleras, desarrollado con **Oracle, PL/SQL y Python** para la asignatura **BDY1103 - Taller de Base de Datos**.

## 1. Descripción

El proyecto permite administrar los productos, compradores y ventas de una tienda de poleras.

Los productos contienen:

- Modelo
- Color
- Talla
- Precio
- Stock

Los compradores contienen:

- RUT
- Nombre
- Email
- Teléfono
- Dirección
- Fecha de registro

Las ventas se relacionan con un comprador y pueden contener uno o más productos mediante el detalle de venta.

El proyecto aplica los contenidos de SQL y PL/SQL trabajados durante el semestre.

## 2. Tecnologías

- Oracle Database
- Oracle SQL Developer
- SQL
- PL/SQL
- Python
- oracledb
- Visual Studio Code
- Git
- GitHub

## 3. Estructura del proyecto

```text
TiendaPolerasBDY1103_010V/
├── README.md
├── .gitignore
│
├── database/
│   ├── 00_usuario_permisos.sql
│   ├── 01_creacion_tablas.sql
│   ├── 02_datos_prueba.sql
│   ├── 03_record_varray.sql
│   ├── 04_cursores.sql
│   ├── 05_excepciones.sql
│   ├── 06_procedures.sql
│   ├── 07_functions.sql
│   ├── 08_package.sql
│   └── 09_triggers.sql
│
└── python/
    ├── conexion.py
    ├── crud_producto.py
    ├── crud_comprador.py
    ├── crud_venta.py
    └── main.py
```

## 4. Base de datos

La base de datos utiliza siete tablas principales:

- `MODELO`
- `COLOR`
- `TALLA`
- `PRODUCTO`
- `COMPRADOR`
- `VENTA`
- `DETALLE_VENTA`

### MODELO

Almacena los diferentes modelos de poleras.

Ejemplos:

- Básica
- Oversize
- Deportiva

### COLOR

Almacena los colores disponibles para los productos.

Ejemplos:

- Negro
- Blanco
- Azul
- Rojo

### TALLA

Almacena las tallas disponibles.

Ejemplos:

- S
- M
- L
- XL

### PRODUCTO

Representa una combinación de modelo, color y talla.

Además, almacena:

- Precio
- Stock

Ejemplo:

```text
Modelo: Básica
Color: Negro
Talla: M
Precio: $19.990
Stock: 15
```

### COMPRADOR

Almacena la información de los compradores.

Los datos registrados permiten identificar al comprador y mantener su información de contacto.

Entre los datos utilizados se encuentran:

- ID del comprador
- RUT
- Nombre
- Email
- Teléfono
- Dirección
- Fecha de registro

### VENTA

Representa una venta realizada por un comprador.

Contiene información como:

- ID de venta
- ID del comprador
- Fecha de venta
- Total

### DETALLE_VENTA

Relaciona una venta con los productos comprados.

Contiene:

- ID del detalle
- ID de venta
- ID de producto
- Cantidad
- Precio unitario

El detalle permite registrar qué productos forman parte de cada venta.

## 5. Relaciones

La estructura principal de la base de datos es:

```text
MODELO
   │
   └────────── PRODUCTO
                  │
             ┌────┴────┐
             │         │
           COLOR     TALLA
                  │
                  │
                  ↓
            DETALLE_VENTA
                  │
                  │
                  ↓
                VENTA
                  │
                  │
                  ↓
              COMPRADOR
```

Un modelo puede tener varios productos.

Un color puede estar asociado a varios productos.

Una talla puede estar asociada a varios productos.

Una venta pertenece a un comprador.

Una venta puede contener uno o más productos mediante `DETALLE_VENTA`.

Un producto puede aparecer en diferentes ventas.

## 6. Nomenclatura utilizada

El proyecto utiliza prefijos para identificar fácilmente el propósito de las variables, parámetros, cursores, tipos, excepciones y registros.

### Variables

Las variables locales utilizan el prefijo:

```text
v_
```

Ejemplos:

```text
v_producto
v_nombre
v_stock
v_precio
v_valor_total
```

La `v_` indica que se trata de una variable.

### Parámetros

Los parámetros de procedimientos y funciones utilizan:

```text
p_
```

Ejemplos:

```text
p_id_producto
p_id_modelo
p_id_color
p_id_talla
p_precio
p_stock
```

La `p_` indica que se trata de un parámetro recibido por un procedimiento o función.

### Cursores

Los cursores utilizan el prefijo:

```text
c_
```

Ejemplos:

```text
c_modelos
c_productos
c_compradores
c_ventas
```

La `c_` indica que se trata de un cursor.

### Excepciones

Las excepciones definidas por el usuario utilizan:

```text
e_
```

Ejemplos:

```text
e_stock_insuficiente
e_rut_invalido
```

La `e_` indica que se trata de una excepción.

### Tipos definidos

Los tipos utilizados para estructuras como `RECORD` y `VARRAY` utilizan:

```text
t_
```

Ejemplos:

```text
t_producto
t_tallas
t_comprador
t_productos_comprados
```

La `t_` indica que se trata de un tipo definido dentro del bloque PL/SQL.

### Registros de cursores

Los registros utilizados para recorrer los cursores utilizan:

```text
r_
```

Ejemplos:

```text
r_modelo
r_producto
r_comprador
r_venta
```

La `r_` indica que se trata de un registro asociado al resultado de un cursor.

### Resumen de nomenclatura

| Prefijo | Uso | Ejemplo |
|---|---|---|
| `v_` | Variable | `v_stock` |
| `p_` | Parámetro | `p_id_producto` |
| `c_` | Cursor | `c_productos` |
| `e_` | Excepción | `e_stock_insuficiente` |
| `t_` | Tipo definido | `t_producto` |
| `r_` | Registro de cursor | `r_producto` |

## 7. PL/SQL

El proyecto demuestra el uso de:

- `RECORD`
- `VARRAY`
- Cursores
- Cursores con parámetros
- Loops anidados
- Excepciones predefinidas
- Excepciones definidas por el usuario
- Procedimientos
- Funciones
- Packages
- Triggers

Los procedimientos y funciones permiten trabajar con la información de productos, compradores y ventas.

Los packages permiten agrupar procedimientos y funciones relacionados.

Los triggers permiten controlar determinadas reglas de la base de datos.

## 8. RECORD

Se utilizan estructuras `RECORD` para agrupar información relacionada.

Por ejemplo, un producto puede contener:

```text
ID
Modelo
Color
Talla
Precio
Stock
```

Estos datos se pueden almacenar dentro de un solo `RECORD`.

También se utilizan estructuras `RECORD` para trabajar con información relacionada con compradores.

## 9. VARRAY

Se utilizan `VARRAY` para almacenar conjuntos de elementos del mismo tipo con una cantidad máxima definida.

Por ejemplo, se utiliza un `VARRAY` para almacenar las tallas:

```text
S
M
L
XL
```

También se utiliza un `VARRAY` relacionado con los productos comprados.

## 10. Cursores

El proyecto utiliza cursores explícitos.

Se utilizan:

- Cursores sin parámetros
- Cursores con parámetros
- Loops anidados

Un ejemplo de recorrido es:

```text
Modelo
   ↓
Productos de ese modelo
```

También se utilizan cursores para recorrer información relacionada con compradores y ventas.

## 11. Excepciones

El proyecto demuestra excepciones predefinidas de Oracle y excepciones definidas por el usuario.

### Excepciones predefinidas

Se utilizan excepciones como:

```text
NO_DATA_FOUND
DUP_VAL_ON_INDEX
```

### Excepciones definidas por el usuario

Se utilizan excepciones como:

```text
e_stock_insuficiente
e_rut_invalido
```

Estas permiten controlar situaciones específicas del sistema.

## 12. Procedimientos

El proyecto utiliza procedimientos para realizar operaciones sobre los datos.

Entre ellos se encuentran operaciones relacionadas con:

```text
Productos
Compradores
Ventas
Detalle de ventas
```

Los procedimientos permiten centralizar operaciones que modifican la información de la base de datos.

## 13. Funciones

El proyecto utiliza funciones para obtener valores calculados.

Entre ellas se encuentran funciones relacionadas con:

```text
Valor del stock
Total comprado
Ticket promedio
```

### Calcular valor del stock

Calcula:

```text
Precio × Stock
```

### Total comprado

Permite obtener el total gastado por un comprador.

### Ticket promedio

Permite calcular el promedio de las ventas realizadas por un comprador.

## 14. Packages

El proyecto utiliza packages para agrupar procedimientos y funciones relacionados.

### pkg_productos

Agrupa operaciones relacionadas con los productos.

### pkg_ventas

Agrupa operaciones relacionadas con compradores y ventas.

El uso de packages permite mantener juntas operaciones que pertenecen al mismo contexto.

## 15. Triggers

El proyecto utiliza triggers para controlar determinadas reglas de la base de datos.

### Control de stock

El trigger de control de stock evita que un producto tenga un stock negativo.

Si se intenta insertar o actualizar un producto con:

```text
stock < 0
```

Oracle genera un error.

### Control de ventas

Los triggers relacionados con ventas permiten validar las operaciones realizadas sobre las ventas y sus datos.

## 16. Control de stock durante una venta

Cuando se agrega un producto a una venta, el sistema realiza las siguientes operaciones:

```text
1. Busca el producto.
        ↓
2. Obtiene su stock y precio.
        ↓
3. Verifica que exista stock suficiente.
        ↓
4. Inserta el detalle de venta.
        ↓
5. Descuenta la cantidad del stock.
        ↓
6. Calcula el total de la venta.
```

Si no existe stock suficiente, se utiliza una excepción definida por el usuario para informar el problema.

## 17. Orden de ejecución de la base de datos

Los archivos de la carpeta `database/` se ejecutan en el siguiente orden.


### 1. Crear usuario y permisos

```text
00_usuario_permisos.sql
```

Este archivo crea el usuario `TIENDA_POLERAS` y entrega los permisos necesarios.

Debe ejecutarse como `SYS` dentro de `XEPDB1`.

### 2. Crear las tablas

```text
01_creacion_tablas.sql
```

Este archivo crea las tablas:

```text
MODELO
COLOR
TALLA
PRODUCTO
COMPRADOR
VENTA
DETALLE_VENTA
```

Debe ejecutarse conectado como:

```text
TIENDA_POLERAS@localhost:1521/XEPDB1
```

### 3. Insertar datos de prueba

```text
02_datos_prueba.sql
```

Inserta datos de prueba para:

- Modelos
- Colores
- Tallas
- Productos
- Compradores
- Ventas
- Detalles de venta

### 4. Ejecutar RECORD y VARRAY

```text
03_record_varray.sql
```

Demuestra el uso de:

- `RECORD`
- `VARRAY`

### 5. Ejecutar cursores

```text
04_cursores.sql
```

Demuestra:

- Cursor sin parámetros
- Cursor con parámetros
- Loops anidados

### 6. Ejecutar excepciones

```text
05_excepciones.sql
```

Demuestra:

- Excepciones predefinidas de Oracle
- Excepciones definidas por el usuario

### 7. Crear procedimientos

```text
06_procedures.sql
```

Crea los procedimientos utilizados por el proyecto.

### 8. Crear funciones

```text
07_functions.sql
```

Crea las funciones utilizadas por el proyecto.

### 9. Crear packages

```text
08_package.sql
```

Crea los packages utilizados por el proyecto.

### 10. Crear triggers

```text
09_triggers.sql
```

Crea los triggers utilizados por el proyecto.

### Resumen del orden

```text
00_usuario_permisos.sql
          ↓
01_creacion_tablas.sql
          ↓
02_datos_prueba.sql
          ↓
03_record_varray.sql
          ↓
04_cursores.sql
          ↓
05_excepciones.sql
          ↓
06_procedures.sql
          ↓
07_functions.sql
          ↓
08_package.sql
          ↓
09_triggers.sql
```

## 18. Python

Python se conecta a Oracle mediante la librería:

```text
oracledb
```

Python funciona como la aplicación que permite al usuario interactuar con la base de datos.

La arquitectura utilizada es:

```text
Usuario
   ↓
Python
   ↓
oracledb
   ↓
Oracle Database
   ↓
Tablas / Procedures / Functions / Packages / Triggers
```

## 19. Archivos Python

### conexion.py

Contiene la configuración y conexión con Oracle.

```text
python/conexion.py
```

### crud_producto.py

Contiene las operaciones relacionadas con productos:

- Insertar producto
- Listar productos
- Actualizar stock
- Calcular valor del stock
- Eliminar producto

### crud_comprador.py

Contiene las operaciones relacionadas con compradores:

- Insertar comprador
- Listar compradores
- Consultar información relacionada con sus compras

### crud_venta.py

Contiene las operaciones relacionadas con ventas:

- Registrar venta
- Agregar detalle de venta
- Listar ventas

### main.py

Contiene el menú principal del sistema.

## 20. Instalación de Python

Antes de ejecutar el programa se debe instalar la librería `oracledb`.

Desde una terminal:

```bash
pip install oracledb
```

## 21. Ejecución del programa

Primero se debe tener Oracle Database funcionando y la base de datos configurada.

Luego se debe abrir una terminal en la carpeta:

```text
python/
```

Por ejemplo:

```bash
cd python
```

Después se ejecuta:

```bash
python main.py
```

## 22. Menú principal

Al ejecutar el programa aparece el menú principal:

```text
===== TIENDA DE POLERAS =====
1. Listar productos
2. Insertar producto
3. Actualizar stock
4. Calcular valor del stock
5. Eliminar producto
6. Listar compradores
7. Insertar comprador
8. Registrar venta con detalle
9. Listar ventas
10. Total comprado por comprador
11. Salir

Seleccione una opción:
```

## 23. Opciones del menú

### Opción 1 - Listar productos

Muestra los productos registrados en la base de datos.

La información mostrada incluye:

- ID del producto
- Modelo
- Color
- Talla
- Precio
- Stock

Ejemplo:

```text
ID: 1 | Modelo: Basica | Color: Negro | Talla: M | Precio: 19990 | Stock: 15
```

### Opción 2 - Insertar producto

Permite registrar un nuevo producto.

El programa solicita:

```text
ID del producto
ID del modelo
ID del color
ID de la talla
Precio
Stock
```

Los IDs de modelo, color y talla deben existir previamente.

### Opción 3 - Actualizar stock

Permite modificar el stock de un producto existente.

El programa solicita:

```text
ID del producto
Nuevo stock
```

El stock no puede ser negativo.

### Opción 4 - Calcular valor del stock

Permite calcular cuánto dinero representa actualmente el stock de un producto.

El cálculo realizado es:

```text
Precio × Stock
```

Por ejemplo:

```text
Precio: $19.990
Stock: 15

Valor del stock: $299.850
```

### Opción 5 - Eliminar producto

Permite eliminar un producto utilizando su ID.

La eliminación está sujeta a las restricciones de integridad referencial de la base de datos.

### Opción 6 - Listar compradores

Muestra los compradores registrados.

La información incluye:

- ID
- RUT
- Nombre
- Email

Ejemplo:

```text
ID: 1 | RUT: 12345678-9 | Nombre: Juan Perez | Email: juan@mail.cl
```

### Opción 7 - Insertar comprador

Permite registrar un nuevo comprador.

El programa solicita los datos correspondientes al comprador:

```text
ID
RUT
Nombre
Email
Teléfono
Dirección
```

El RUT debe utilizar el formato:

```text
12345678-9
```

### Opción 8 - Registrar venta con detalle

Permite registrar una venta y asociarle un producto.

Primero se solicitan los datos de la venta:

```text
ID de la venta
ID del comprador
```

Después se solicitan los datos del detalle:

```text
ID del detalle
ID del producto
Cantidad
```

El sistema realiza el siguiente proceso:

```text
Registrar venta
      ↓
Validar comprador
      ↓
Buscar producto
      ↓
Verificar stock
      ↓
Agregar detalle
      ↓
Descontar stock
      ↓
Calcular total
```

Por ejemplo, si se compran 2 unidades de un producto cuyo precio es:

```text
$19.990
```

el detalle tendrá:

```text
Precio unitario: $19.990
Cantidad: 2
```

y el total correspondiente será:

```text
$39.980
```

Si no existe stock suficiente, la operación genera la excepción correspondiente y no se completa la venta.

### Opción 9 - Listar ventas

Muestra las ventas registradas en el sistema.

Permite visualizar información relacionada con:

- Venta
- Comprador
- Producto
- Cantidad
- Total

Una venta puede tener varios detalles, por lo que una misma venta puede aparecer asociada a diferentes productos.

### Opción 10 - Total comprado por comprador

Permite consultar cuánto ha gastado un comprador.

El programa solicita:

```text
ID del comprador
```

Luego obtiene el total correspondiente a sus compras.

También permite utilizar las funciones relacionadas con los cálculos de las compras realizadas por el comprador.

### Opción 11 - Salir

Finaliza la ejecución del programa.

El sistema muestra un mensaje indicando que el programa ha terminado.

## 24. Ejemplo de flujo completo

Una ejecución normal del sistema puede realizarse de la siguiente manera:

```text
1. Ejecutar Oracle Database
        ↓
2. Ejecutar los scripts de database
        ↓
3. Ejecutar Python
        ↓
4. Listar productos
        ↓
5. Registrar comprador
        ↓
6. Registrar venta
        ↓
7. Agregar producto a la venta
        ↓
8. Verificar stock
        ↓
9. Descontar stock
        ↓
10. Calcular total de venta
        ↓
11. Consultar la venta
```

## 25. Repositorio

GitHub:

```text
https://github.com/jpcasassa/TiendaPolerasBDY1103_010V
```

## 26. Estudiantes

- **Juan Pablo Casassa**
- **Claudio Alberto Jaime Calderon**
- **Lucas Sebastián Vargas Panza**

## 27. Asignatura

**BDY1103 - Taller de Base de Datos**