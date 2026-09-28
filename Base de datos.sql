-- Los ejercicios fueron tomados por Claude
-- SQL para Oracle Database
-- ---------------------------------------------- Clase 1 Crear, modificar y eliminar tablas ----------------------------------------------

-- Crear tabla de categorias
CREATE TABLE categorias (
    id_categoria NUMBER PRIMARY KEY,
    nombre_categoria VARCHAR2(100) NOT NULL
);

-- Crear tabla de productos con clave foranea a categorias
CREATE TABLE productos (
    id_producto  NUMBER PRIMARY KEY,
    nombre       VARCHAR2(100) NOT NULL,
    precio       NUMBER(10, 2),
    stock        NUMBER,
    id_categoria NUMBER,
    CONSTRAINT fk_prod_cat FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

-- Crear tabla de clientes
CREATE TABLE clientes (
    id_cliente      NUMBER PRIMARY KEY,
    nombre          VARCHAR2(100) NOT NULL,
    telefono        VARCHAR2(15),
    email           VARCHAR2(100),
    fecha_registro  DATE
);

-- Crear tabla de empleados
CREATE TABLE empleados (
    id_empleado   NUMBER PRIMARY KEY,
    nombre        VARCHAR2(100) NOT NULL,
    cargo         VARCHAR2(50),
    salario       NUMBER(10, 2),
    fecha_ingreso DATE
);

-- Crear tabla de ventas con claves foraneas a clientes y empleados
CREATE TABLE ventas (
    id_venta      NUMBER PRIMARY KEY,
    fecha_venta   DATE NOT NULL,
    id_cliente    NUMBER,
    id_empleado   NUMBER,
    total         NUMBER(10, 2),
    CONSTRAINT fk_ven_cli FOREIGN KEY (id_cliente)  REFERENCES clientes(id_cliente),
    CONSTRAINT fk_ven_emp FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

-- Crear tabla de detalle_venta con claves foraneas a ventas y productos
CREATE TABLE detalle_venta (
    id_detalle      NUMBER PRIMARY KEY,
    id_venta        NUMBER,
    id_producto     NUMBER,
    cantidad        NUMBER,
    precio_unitario NUMBER(10, 2),
    CONSTRAINT fk_det_ven FOREIGN KEY (id_venta)    REFERENCES ventas(id_venta),
    CONSTRAINT fk_det_pro FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Agregar columna descripcion a productos
ALTER TABLE productos ADD descripcion VARCHAR2(200);

-- Eliminar la columna descripcion de productos
ALTER TABLE productos DROP COLUMN descripcion;

-- Eliminar todas las tablas en orden (respetando las claves foraneas)
DROP TABLE detalle_venta;
DROP TABLE ventas;
DROP TABLE productos;
DROP TABLE clientes;
DROP TABLE empleados;
DROP TABLE categorias;


-- ---------------------------------------------- Clase 2 INSERT, UPDATE, DELETE ----------------------------------------------

-- Insertar categorias
INSERT INTO categorias VALUES (1, 'Bebidas');
INSERT INTO categorias VALUES (2, 'Snacks');
INSERT INTO categorias VALUES (3, 'Lácteos');
INSERT INTO categorias VALUES (4, 'Aseo');
INSERT INTO categorias VALUES (5, 'Panadería');
COMMIT;

-- Insertar empleados
INSERT INTO empleados VALUES (1, 'Laura Gómez',   'Cajera',  1800000, DATE '2023-03-15');
INSERT INTO empleados VALUES (2, 'Carlos Ruiz',   'Cajero',  1800000, DATE '2022-08-01');
INSERT INTO empleados VALUES (3, 'Marta Jiménez', 'Gerente', 3500000, DATE '2020-01-10');
COMMIT;

-- Insertar clientes (Diego no tenia email, se registra con NULL)
INSERT INTO clientes VALUES (1, 'Ana Torres',    '3101234567', 'ana@gmail.com',   DATE '2024-01-10');
INSERT INTO clientes VALUES (2, 'Pedro Salcedo', '3209876543', 'pedro@gmail.com', DATE '2024-02-20');
INSERT INTO clientes VALUES (3, 'Julia Mora',    '3155554433', 'julia@gmail.com', DATE '2024-03-05');
INSERT INTO clientes VALUES (4, 'Diego Parra',   '3001112233', NULL,              DATE '2024-04-18');
COMMIT;

-- Insertar productos
INSERT INTO productos VALUES (1,  'Coca-Cola 350ml',     2500,  80, 1);
INSERT INTO productos VALUES (2,  'Agua Cristal 600ml',  1500, 120, 1);
INSERT INTO productos VALUES (3,  'Jugo Hit mango',      2800,  60, 1);
INSERT INTO productos VALUES (4,  'Papas Margarita',     3000,  50, 2);
INSERT INTO productos VALUES (5,  'Chitos',              2500,  45, 2);
INSERT INTO productos VALUES (6,  'Leche Alquería 1L',   4200,  30, 3);
INSERT INTO productos VALUES (7,  'Yogurt Alpina',       3500,  25, 3);
INSERT INTO productos VALUES (8,  'Jabón Palmolive',     4500,  40, 4);
INSERT INTO productos VALUES (9,  'Shampoo Head&Shldr', 12000,  20, 4);
INSERT INTO productos VALUES (10, 'Pan tajado Bimbo',    5500,  35, 5);
COMMIT;

-- Insertar ventas (total en 0, se calcula despues)
INSERT INTO ventas VALUES (1, DATE '2026-05-01', 1, 1, 0);
INSERT INTO ventas VALUES (2, DATE '2026-05-02', 2, 2, 0);
INSERT INTO ventas VALUES (3, DATE '2026-05-03', 3, 1, 0);
INSERT INTO ventas VALUES (4, DATE '2026-05-05', 1, 2, 0);
INSERT INTO ventas VALUES (5, DATE '2026-05-10', 4, 1, 0);
COMMIT;

-- Insertar detalle de ventas
INSERT INTO detalle_venta VALUES (1,  1, 1, 2, 2500);
INSERT INTO detalle_venta VALUES (2,  1, 4, 1, 3000);
INSERT INTO detalle_venta VALUES (3,  2, 2, 3, 1500);
INSERT INTO detalle_venta VALUES (4,  2, 7, 1, 3500);
INSERT INTO detalle_venta VALUES (5,  2, 10, 1, 5500);
INSERT INTO detalle_venta VALUES (6,  3, 6, 2, 4200);
INSERT INTO detalle_venta VALUES (7,  3, 8, 1, 4500);
INSERT INTO detalle_venta VALUES (8,  4, 3, 2, 2800);
INSERT INTO detalle_venta VALUES (9,  4, 5, 1, 2500);
INSERT INTO detalle_venta VALUES (10, 5, 9, 1, 12000);
INSERT INTO detalle_venta VALUES (11, 5, 1, 2, 2500);
COMMIT;

-- Actualizar el salario de Laura Gomez
UPDATE empleados SET salario = 2000000 WHERE id_empleado = 1;
COMMIT;

-- Eliminar el cliente Diego Parra
DELETE FROM clientes WHERE id_cliente = 4;
COMMIT;


-- ---------------------------------------------- Clase 3 SELECT, WHERE y ORDER BY ----------------------------------------------

-- Ver todos los productos
SELECT * FROM productos;

-- Ver solo nombre, precio y stock de los productos
SELECT nombre, precio, stock FROM productos;

-- Productos que cuestan mas de 3000
SELECT nombre, precio FROM productos
WHERE precio > 3000;

-- Buscar un cliente especifico por nombre
SELECT * FROM clientes
WHERE nombre = 'Ana Torres';

-- Productos con stock menor a 30 unidades
SELECT nombre, stock FROM productos
WHERE stock < 30;

-- Productos entre 2000 y 5000 de precio
SELECT nombre, precio FROM productos
WHERE precio BETWEEN 2000 AND 5000;

-- Productos cuyo nombre contiene "Coca"
SELECT * FROM productos
WHERE nombre LIKE '%Coca%';

-- Clientes sin email registrado
SELECT nombre FROM clientes
WHERE email IS NULL;

-- Productos de categoria 1 o 2
SELECT nombre, precio FROM productos
WHERE id_categoria = 1 OR id_categoria = 2;

-- Productos caros con poco stock
SELECT nombre, precio, stock FROM productos
WHERE precio > 5000 AND stock < 30;

-- Productos del mas caro al mas barato
SELECT nombre, precio FROM productos
ORDER BY precio DESC;

-- Clientes en orden alfabetico
SELECT nombre FROM clientes
ORDER BY nombre ASC;

-- Ventas realizadas en mayo de 2026 (tres formas equivalentes)
SELECT * FROM ventas
WHERE fecha_venta BETWEEN DATE '2026-05-01' AND DATE '2026-05-31';

SELECT * FROM ventas
WHERE EXTRACT(MONTH FROM fecha_venta) = 5
    AND EXTRACT(YEAR FROM fecha_venta) = 2026;

SELECT * FROM ventas
WHERE TO_CHAR(fecha_venta, 'MM-YYYY') = '05-2026';


-- ---------------------------------------------- Clase 4 Funciones de agregacion y GROUP BY ----------------------------------------------

-- Contar cuantos productos hay en total
SELECT COUNT(*) AS total_productos FROM productos;

-- Precio maximo, minimo y promedio de los productos
SELECT MAX(precio) AS mas_caro,
        MIN(precio) AS mas_barato,
        ROUND(AVG(precio), 2) AS precio_promedio
FROM productos;

-- Valor total del inventario
SELECT SUM(precio * stock) AS valor_inventario FROM productos;

-- Cuantos productos hay por categoria
SELECT id_categoria, COUNT(*) AS cantidad_productos
FROM productos
GROUP BY id_categoria
ORDER BY id_categoria;

-- Cuantas ventas realizo cada empleado
SELECT id_empleado, COUNT(*) AS ventas_realizadas
FROM ventas
GROUP BY id_empleado;

-- Cuantas ventas realizo cada empleado en mayo de 2026
SELECT id_empleado, COUNT(*) AS ventas_realizadas
FROM ventas
WHERE fecha_venta BETWEEN DATE '2026-05-01' AND DATE '2026-05-31'
GROUP BY id_empleado
ORDER BY ventas_realizadas DESC;

-- Valor del inventario por categoria ordenado de mayor a menor
SELECT id_categoria,
       SUM(precio * stock) AS valor_inventario
FROM productos
GROUP BY id_categoria
ORDER BY valor_inventario DESC;

-- Empleado con el salario mas alto (dos formas)
SELECT nombre, cargo, salario
FROM empleados
ORDER BY salario DESC
FETCH FIRST 1 ROWS ONLY;

SELECT nombre, cargo, salario
FROM empleados
WHERE salario = (SELECT MAX(salario) FROM empleados);

-- Categorias con mas de 2 productos (HAVING)
SELECT id_categoria, COUNT(*) AS cantidad
FROM productos
GROUP BY id_categoria
HAVING COUNT(*) > 2;

-- Los 3 productos mas caros (FETCH FIRST)
SELECT nombre, precio
FROM productos
ORDER BY precio DESC
FETCH FIRST 3 ROWS ONLY;


-- ---------------------------------------------- Clase 5 INNER JOIN ----------------------------------------------

-- Cada producto con el nombre de su categoria
SELECT productos.nombre,
        productos.precio,
        categorias.nombre_categoria
FROM productos
INNER JOIN categorias ON productos.id_categoria = categorias.id_categoria;

-- Cada venta con el nombre del cliente que la realizo
SELECT ventas.id_venta,
        clientes.nombre,
        ventas.fecha_venta
FROM ventas
INNER JOIN clientes ON ventas.id_cliente = clientes.id_cliente;

-- Cada venta con el nombre del cliente y del empleado que la registro
SELECT ventas.id_venta,
        ventas.fecha_venta,
        clientes.nombre  AS nombre_cliente,
        empleados.nombre AS nombre_empleado
FROM ventas
INNER JOIN clientes  ON ventas.id_cliente  = clientes.id_cliente
INNER JOIN empleados ON ventas.id_empleado = empleados.id_empleado;

-- Detalle de ventas con nombre del cliente, producto y cantidad
SELECT clientes.nombre  AS nombre_cliente,
        productos.nombre AS nombre_producto,
        detalle_venta.cantidad
FROM detalle_venta
INNER JOIN ventas    ON detalle_venta.id_venta    = ventas.id_venta
INNER JOIN clientes  ON ventas.id_cliente         = clientes.id_cliente
INNER JOIN productos ON detalle_venta.id_producto = productos.id_producto;

-- Solo las compras realizadas por Ana Torres
SELECT clientes.nombre  AS nombre_cliente,
        productos.nombre AS nombre_producto,
        detalle_venta.cantidad,
        detalle_venta.precio_unitario
FROM detalle_venta
INNER JOIN ventas    ON detalle_venta.id_venta    = ventas.id_venta
INNER JOIN clientes  ON ventas.id_cliente         = clientes.id_cliente
INNER JOIN productos ON detalle_venta.id_producto = productos.id_producto
WHERE clientes.nombre = 'Ana Torres';

-- Detalle completo de todas las ventas (4 tablas)
SELECT clientes.nombre         AS nombre_cliente,
        empleados.nombre        AS nombre_empleado,
        productos.nombre        AS nombre_producto,
        detalle_venta.cantidad,
        detalle_venta.precio_unitario,
       (detalle_venta.cantidad * detalle_venta.precio_unitario) AS subtotal
FROM detalle_venta
INNER JOIN ventas    ON detalle_venta.id_venta    = ventas.id_venta
INNER JOIN clientes  ON ventas.id_cliente         = clientes.id_cliente
INNER JOIN empleados ON ventas.id_empleado        = empleados.id_empleado
INNER JOIN productos ON detalle_venta.id_producto = productos.id_producto
ORDER BY clientes.nombre, ventas.id_venta;

-- Cuanto gasto cada cliente en total
SELECT clientes.nombre AS nombre_cliente,
        COUNT(DISTINCT ventas.id_venta) AS num_compras,
        SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_gastado
FROM clientes
INNER JOIN ventas        ON clientes.id_cliente  = ventas.id_cliente
INNER JOIN detalle_venta ON ventas.id_venta      = detalle_venta.id_venta
GROUP BY clientes.nombre
ORDER BY total_gastado DESC;

-- Que empleado vendio mas en dinero
SELECT empleados.nombre AS nombre_empleado,
       SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_vendido
FROM empleados
INNER JOIN ventas        ON empleados.id_empleado = ventas.id_empleado
INNER JOIN detalle_venta ON ventas.id_venta       = detalle_venta.id_venta
GROUP BY empleados.nombre
ORDER BY total_vendido DESC;

-- Cual es el producto mas vendido en unidades
SELECT productos.nombre AS nombre_producto,
        SUM(detalle_venta.cantidad) AS unidades_vendidas
FROM productos
INNER JOIN detalle_venta ON productos.id_producto = detalle_venta.id_producto
GROUP BY productos.nombre
ORDER BY unidades_vendidas DESC;


-- ---------------------------------------------- Clase 6 LEFT JOIN y RIGHT JOIN ----------------------------------------------

-- Todos los clientes con sus ventas (los que no compraron muestran NULL)
SELECT clientes.nombre,
        ventas.id_venta,
        ventas.fecha_venta
FROM clientes
LEFT JOIN ventas ON clientes.id_cliente = ventas.id_cliente;

-- Clientes que nunca han comprado
SELECT clientes.nombre
FROM clientes
LEFT JOIN ventas ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.id_venta IS NULL;

-- Cuantas ventas tiene cada cliente incluyendo los que no han comprado (muestra 0)
SELECT clientes.nombre AS nombre_cliente,
        COUNT(ventas.id_venta) AS total_compras
FROM clientes
LEFT JOIN ventas ON clientes.id_cliente = ventas.id_cliente
GROUP BY clientes.nombre
ORDER BY total_compras DESC;

-- Productos que nunca han sido vendidos
SELECT productos.nombre, productos.precio
FROM productos
LEFT JOIN detalle_venta ON productos.id_producto = detalle_venta.id_producto
WHERE detalle_venta.id_detalle IS NULL;

-- Total gastado por cliente incluyendo los que no han comprado (NVL reemplaza NULL por 0)
SELECT clientes.nombre AS nombre_cliente,
       NVL(SUM(detalle_venta.cantidad * detalle_venta.precio_unitario), 0) AS total_gastado
FROM clientes
LEFT JOIN ventas        ON clientes.id_cliente  = ventas.id_cliente
LEFT JOIN detalle_venta ON ventas.id_venta      = detalle_venta.id_venta
GROUP BY clientes.nombre
ORDER BY total_gastado DESC;

-- Todas las categorias con sus productos (RIGHT JOIN: las categorias sin productos muestran NULL)
SELECT categorias.nombre_categoria,
        productos.nombre AS nombre_producto
FROM productos
RIGHT JOIN categorias ON productos.id_categoria = categorias.id_categoria;

-- Categorias que no tienen ningun producto asignado
SELECT categorias.nombre_categoria
FROM productos
RIGHT JOIN categorias ON productos.id_categoria = categorias.id_categoria
WHERE productos.id_producto IS NULL;

-- Todos los empleados con cuantas ventas han registrado (RIGHT JOIN)
SELECT empleados.nombre AS nombre_empleado,
        COUNT(ventas.id_venta) AS total_ventas
FROM ventas
RIGHT JOIN empleados ON ventas.id_empleado = empleados.id_empleado
GROUP BY empleados.nombre
ORDER BY total_ventas DESC;


-- ---------------------------------------------- Clase 7 Subconsultas ----------------------------------------------

-- Productos mas caros que el precio promedio
SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- Empleado que mas gana
SELECT nombre, cargo, salario
FROM empleados
WHERE salario = (SELECT MAX(salario) FROM empleados);

-- Clientes que han comprado al menos una vez (subconsulta con IN)
SELECT nombre
FROM clientes
WHERE id_cliente IN (SELECT id_cliente FROM ventas);

-- Clientes que nunca han comprado (subconsulta con NOT IN)
SELECT nombre
FROM clientes
WHERE id_cliente NOT IN (SELECT id_cliente FROM ventas);

-- Productos que nunca han sido vendidos (subconsulta con NOT IN)
SELECT nombre, precio
FROM productos
WHERE id_producto NOT IN (SELECT id_producto FROM detalle_venta);

-- Cada producto con su precio y el precio promedio general al lado
SELECT nombre,
        precio,
        (SELECT ROUND(AVG(precio), 2) FROM productos) AS precio_promedio
FROM productos
ORDER BY precio DESC;

-- Cada cliente con cuantas compras ha hecho (subconsulta correlacionada)
SELECT clientes.nombre,
        (SELECT COUNT(*)
        FROM ventas
        WHERE ventas.id_cliente = clientes.id_cliente) AS total_compras
FROM clientes;

-- El cliente que mas dinero ha gastado en total
SELECT clientes.nombre AS nombre_cliente,
       SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total_gastado
FROM clientes
INNER JOIN ventas        ON clientes.id_cliente  = ventas.id_cliente
INNER JOIN detalle_venta ON ventas.id_venta      = detalle_venta.id_venta
GROUP BY clientes.nombre
HAVING SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) =
    (SELECT MAX(total)
     FROM (SELECT SUM(detalle_venta.cantidad * detalle_venta.precio_unitario) AS total
            FROM ventas
            INNER JOIN detalle_venta ON ventas.id_venta = detalle_venta.id_venta
            GROUP BY ventas.id_cliente) totales);

-- Los 3 productos mas caros y cuanto valen juntos (subconsulta en FROM)
SELECT SUM(precio_top) AS valor_top3
FROM (
    SELECT precio AS precio_top
    FROM productos
    ORDER BY precio DESC
    FETCH FIRST 3 ROWS ONLY
) productos_top;


-- ---------------------------------------------- Clase 8 Vistas ----------------------------------------------

-- Vista con el detalle completo de todas las ventas
CREATE VIEW ventas_detalladas AS
SELECT clientes.nombre  AS nombre_cliente,
        empleados.nombre AS nombre_empleado,
        ventas.fecha_venta,
        productos.nombre AS nombre_producto,
        detalle_venta.cantidad,
        detalle_venta.precio_unitario,
       (detalle_venta.cantidad * detalle_venta.precio_unitario) AS subtotal
FROM detalle_venta
INNER JOIN ventas    ON detalle_venta.id_venta    = ventas.id_venta
INNER JOIN clientes  ON ventas.id_cliente         = clientes.id_cliente
INNER JOIN empleados ON ventas.id_empleado        = empleados.id_empleado
INNER JOIN productos ON detalle_venta.id_producto = productos.id_producto;

-- Usar la vista: ver todo
SELECT * FROM ventas_detalladas;

-- Usar la vista: filtrar por cliente
SELECT * FROM ventas_detalladas
WHERE nombre_cliente = 'Ana Torres';

-- Usar la vista: total vendido por cliente
SELECT nombre_cliente, SUM(subtotal) AS total_gastado
FROM ventas_detalladas
GROUP BY nombre_cliente
ORDER BY total_gastado DESC;

-- Vista con el resumen de ventas y total por empleado
CREATE VIEW empleados_con_ventas AS
SELECT empleados.nombre AS nombre_empleado,
        empleados.cargo,
        COUNT(ventas.id_venta) AS total_ventas
FROM empleados
LEFT JOIN ventas ON empleados.id_empleado = ventas.id_empleado
GROUP BY empleados.nombre, empleados.cargo;

-- Usar la vista: empleados sin ventas
SELECT * FROM empleados_con_ventas
WHERE total_ventas = 0;

-- Vista del resumen de inventario por categoria
CREATE VIEW inventario_por_categoria AS
SELECT categorias.nombre_categoria,
        COUNT(productos.id_producto)       AS cantidad_productos,
        SUM(productos.stock)               AS stock_total,
        SUM(productos.precio * productos.stock) AS valor_inventario
FROM categorias
LEFT JOIN productos ON categorias.id_categoria = productos.id_categoria
GROUP BY categorias.nombre_categoria;

-- Usar la vista ordenada por valor de inventario
SELECT * FROM inventario_por_categoria
ORDER BY valor_inventario DESC;

-- Modificar una vista existente con OR REPLACE
CREATE OR REPLACE VIEW ventas_detalladas AS
SELECT clientes.nombre  AS nombre_cliente,
        empleados.nombre AS nombre_empleado,
        ventas.fecha_venta,
        productos.nombre AS nombre_producto,
        detalle_venta.cantidad,
        detalle_venta.precio_unitario,
        (detalle_venta.cantidad * detalle_venta.precio_unitario) AS subtotal
FROM detalle_venta
INNER JOIN ventas    ON detalle_venta.id_venta    = ventas.id_venta
INNER JOIN clientes  ON ventas.id_cliente         = clientes.id_cliente
INNER JOIN empleados ON ventas.id_empleado        = empleados.id_empleado
INNER JOIN productos ON detalle_venta.id_producto = productos.id_producto;

-- Ver todas las vistas creadas
SELECT view_name FROM user_views;

-- Eliminar una vista
DROP VIEW ventas_detalladas;


-- ---------------------------------------------- Clase 9 Secuencias ----------------------------------------------

-- Crear las secuencias del proyecto (empiezan desde el siguiente ID disponible)
CREATE SEQUENCE seq_clientes   START WITH 6  INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_empleados  START WITH 5  INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_categorias START WITH 7  INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_productos  START WITH 11 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_ventas     START WITH 6  INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_detalle    START WITH 12 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Ver el numero que generaria la secuencia sin avanzarla
SELECT seq_clientes.NEXTVAL FROM dual;
SELECT seq_clientes.CURRVAL FROM dual;

-- Insertar un cliente usando la secuencia (el ID se genera automaticamente)
INSERT INTO clientes VALUES (seq_clientes.NEXTVAL, 'Mario Díaz', '3112223344', 'mario@gmail.com', DATE '2026-06-01');
COMMIT;

-- Insertar varios clientes seguidos con la secuencia
INSERT INTO clientes VALUES (seq_clientes.NEXTVAL, 'Sandra López',  '3201234321', 'sandra@gmail.com',  DATE '2026-06-02');
INSERT INTO clientes VALUES (seq_clientes.NEXTVAL, 'Felipe Castro', '3009876543', NULL,                DATE '2026-06-02');
INSERT INTO clientes VALUES (seq_clientes.NEXTVAL, 'Natalia Ríos',  '3154433221', 'natalia@gmail.com', DATE '2026-06-03');
COMMIT;

-- Registrar una venta completa con secuencias (CURRVAL vincula el detalle a la venta recien creada)
INSERT INTO ventas VALUES (
    seq_ventas.NEXTVAL,
    DATE '2026-06-05',
    1,
    2,
    0
);
INSERT INTO detalle_venta VALUES (seq_detalle.NEXTVAL, seq_ventas.CURRVAL, 1, 3, 2500);
INSERT INTO detalle_venta VALUES (seq_detalle.NEXTVAL, seq_ventas.CURRVAL, 6, 1, 4200);
COMMIT;

-- Ver todas las secuencias creadas y su ultimo numero generado
SELECT sequence_name, last_number FROM user_sequences;

-- Eliminar una secuencia
DROP SEQUENCE seq_clientes;