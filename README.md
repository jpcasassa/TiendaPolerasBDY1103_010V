# TiendaPolerasBDY1103_010V

Proyecto de base de datos para la gestión de una tienda de poleras, desarrollado con **Oracle, PL/SQL y Python** para la asignatura **BDY1103 - Taller de Base de Datos**.

## 1. Descripción

El proyecto permite administrar productos de una tienda de poleras.

Cada producto contiene:

- Modelo
- Color
- Talla
- Precio
- Stock

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
│       ├── 00_usuario_permisos.sql
│       ├── 01_creacion_tablas.sql
│       ├── 02_datos_prueba.sql
│       ├── 03_record_varray.sql
│       ├── 04_cursores.sql
│       ├── 05_excepciones.sql
│       ├── 06_procedures.sql
│       ├── 07_functions.sql
│       ├── 08_package.sql
│       └── 09_triggers.sql
│
└── python/
        ├── conexion.py
        ├── crud_producto.py
        └── main.py
```

## 4. Base de datos

La base de datos utiliza cuatro tablas principales:

- `MODELO`
- `COLOR`
- `TALLA`
- `PRODUCTO`

La tabla `PRODUCTO` relaciona un modelo, un color y una talla, además de almacenar el precio y el stock.

### Relaciones

```text
MODELO
   │
   └────────── PRODUCTO
                  │
             ┌────┴────┐
             │         │
           COLOR     TALLA
```

## 5. Nomenclatura utilizada

El proyecto utiliza prefijos para identificar fácilmente el propósito de las variables, parámetros, cursores, tipos, excepciones y registros.

### Variables

Las variables locales utilizan el prefijo:

```text
v_
```

Ejemplos:

```sql
v_producto
v_nombre
v_stock
v_precio
v_valor_total
```

La `v_` indica que se trata de una **variable**.

### Parámetros

Los parámetros de procedimientos y funciones utilizan:

```text
p_
```

Ejemplos:

```sql
p_id_producto
p_id_modelo
p_id_color
p_id_talla
p_precio
p_stock
```

La `p_` indica que se trata de un **parámetro** recibido por un procedimiento o función.

### Cursores

Los cursores utilizan el prefijo:

```text
c_
```

Ejemplos:

```sql
c_modelos
c_productos
```

La `c_` indica que se trata de un **cursor**.

### Excepciones

Las excepciones definidas por el usuario utilizan:

```text
e_
```

Ejemplo:

```sql
e_stock_insuficiente
```

La `e_` indica que se trata de una **excepción**.

### Tipos definidos

Los tipos utilizados para estructuras como `RECORD` y `VARRAY` utilizan:

```text
t_
```

Ejemplos:

```sql
t_producto
t_tallas
```

La `t_` indica que se trata de un **tipo definido dentro del bloque PL/SQL**.

### Registros de cursores

Los registros utilizados para recorrer los cursores utilizan:

```text
r_
```

Ejemplos:

```sql
r_modelo
r_producto
```

La `r_` indica que se trata de un **registro asociado al resultado de un cursor**.

### Resumen de nomenclatura

| Prefijo | Uso | Ejemplo |
|---|---|---|
| `v_` | Variable | `v_stock` |
| `p_` | Parámetro | `p_id_producto` |
| `c_` | Cursor | `c_productos` |
| `e_` | Excepción | `e_stock_insuficiente` |
| `t_` | Tipo definido | `t_producto` |
| `r_` | Registro de cursor | `r_producto` |

## 6. PL/SQL

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

Los procedimientos y funciones permiten trabajar con la información de los productos.

El package agrupa procedimientos y funciones relacionados con los productos.

El trigger controla que el stock de un producto no sea negativo.

## 7. Orden de ejecución de la base de datos

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
```

Debe ejecutarse conectado como:

```text
TIENDA_POLERAS@localhost:1521/XEPDB1
```

### 3. Insertar datos de prueba

```text
02_datos_prueba.sql
```

Inserta los modelos, colores, tallas y productos utilizados para probar el proyecto.

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

- Excepción predefinida de Oracle
- Excepción definida por el usuario

### 7. Crear procedimientos

```text
06_procedures.sql
```

Crea los procedimientos:

```text
insertar_producto
actualizar_stock
```

### 8. Crear funciones

```text
07_functions.sql
```

Crea la función:

```text
calcular_valor_stock
```

### 9. Crear package

```text
08_package.sql
```

Crea el package:

```text
pkg_productos
```

El package contiene procedimientos y funciones relacionados con los productos.

### 10. Crear trigger

```text
09_triggers.sql
```

Crea el trigger:

```text
trg_controlar_stock
```

Este trigger evita que un producto tenga un stock negativo.

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

## 8. Python

Python se conecta a Oracle mediante la librería `oracledb`.

Se utiliza para realizar operaciones CRUD sobre los productos y para utilizar los procedimientos y funciones almacenados en Oracle.

La conexión se encuentra en:

```text
python/conexion.py
```

Las operaciones sobre productos se encuentran en:

```text
python/crud_producto.py
```

El programa principal se encuentra en:

```text
python/main.py
```

## 9. Ejecución de Python

Primero se instala la librería necesaria:

```bash
pip install oracledb
```

Luego se ejecuta el programa desde la carpeta `python`:

```bash
python main.py
```

## 10. Repositorio

GitHub:

```text
https://github.com/jpcasassa/TiendaPolerasBDY1103_010V
```

## 11. Estudiantes

- **Juan Pablo Casassa**
- **Claudio Alberto Jaime Calderon**
- **Lucas Sebastián Vargas Panza**

## 12. Asignatura

**BDY1103 - Taller de Base de Datos**