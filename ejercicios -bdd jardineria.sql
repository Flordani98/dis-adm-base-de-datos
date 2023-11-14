/*Guia de ejercicios - Jardineria - Repaso*/

-- 1.4.4 Consultas sobre una tabla

/*1. Devuelve un listado con el código de oficina y la ciudad donde hay
oficinas.*/

SELECT codigo_oficina, ciudad
FROM oficina;

/*2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.*/
SELECT ciudad, telefono
FROM oficina
WHERE codigo_oficina LIKE '%ES';

/*3. Devuelve un listado con el nombre, apellidos y email de los empleados
cuyo jefe tiene un código de jefe igual a 7.*/

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe = 7;


/*4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
empresa.*/

SELECT nombre, apellido1, apellido2, email
FROM empleado
WHERE codigo_jefe IS NULL;

/*5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
empleados que no sean representantes de ventas.*/

SELECT nombre, apellido1, apellido2, puesto
FROM empleado
WHERE puesto != 'representante ventas';

/*6. Devuelve un listado con el nombre de los todos los clientes españoles.*/
SELECT nombre_cliente, pais 
FROM cliente
WHERE pais = 'Spain';

/*7. Devuelve un listado con los distintos estados por los que puede pasar
un pedido.*/

SELECT DISTINCT estado
FROM pedido;

/*8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la
consulta:
● Utilizando la función YEAR de MySQL.
● Utilizando la función DATE_FORMAT de MySQL.
● Sin utilizar ninguna de las funciones anteriores.*/

-- Utilizando funcion YEAR
SELECT DISTINCT codigo_cliente
FROM pago
WHERE YEAR(fecha_pago) = 2008;

-- Utilizando la función DATE_FORMAT de MySQL.
SELECT DISTINCT codigo_cliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, '%Y') = 2008;

select * from pago;

-- Sin utilizar ninguna de las funciones anteriores.
SELECT DISTINCT codigo_cliente
FROM pago
WHERE fecha_pago LIKE '2008%';

/*9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados
a tiempo.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada
order by fecha_entrega;

/*10.Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha
sido al menos dos días antes de la fecha esperada. //dos dias o mas >=
● Utilizando la función ADDDATE de MySQL.
● Utilizando la función DATEDIFF de MySQL.
● ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -?*/

/*● Utilizando la función ADDDATE de MySQL.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_esperada >= ADDDATE(fecha_entrega, 2)
order by fecha_esperada;

/*● Utilizando la función DATEDIFF de MySQL.*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;  

/*● ¿Sería posible resolver esta consulta utilizando el operador de suma + o
resta -?*Si, es posible*/
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_esperada >= fecha_entrega+2;

/*11. Devuelve un listado de todos los pedidos que fueron rechazados en
2009.*/
SELECT *
FROM pedido
WHERE estado = 'rechazado' AND YEAR(fecha_entrega) = 2009;

/*12.Devuelve un listado de todos los pedidos que han sido entregados en el
mes de enero de cualquier año.*/

SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;

/*13.Devuelve un listado con todos los pagos que se realizaron en el año 2008
mediante Paypal. Ordene el resultado de mayor a menor.*/

SELECT * 
FROM pago
WHERE YEAR(fecha_pago) = 2008 AND forma_pago like 'paypal'
ORDER BY total;

/*14.Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas.*/

SELECT DISTINCT forma_pago 
FROM pago;

/*15.Devuelve un listado con todos los productos que pertenecen a la gama
Ornamentales y que tienen más de 100 unidades en stock. El listado deberá
estar ordenado por su precio de venta, mostrando en primer lugar los
de mayor precio.*/

SELECT * 
FROM producto
WHERE gama like 'ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta ASC;

/*16.Devuelve un listado con todos los clientes que sean de la ciudad de
Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.*/
SELECT *
FROM cliente
WHERE ciudad like 'madrid' AND codigo_empleado_rep_ventas IN (11,30);

-- 1.4.5 Consultas multitabla (Composición interna)

/*1. Obtén un listado con el nombre de cada cliente y el nombre y apellido
de su representante de ventas.*/
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON  c.codigo_empleado_rep_ventas = e.codigo_empleado;

/*2. Muestra el nombre de los clientes que hayan realizado pagos junto con
el nombre de sus representantes de ventas.*/

select c.codigo_cliente, c.nombre_cliente, e.nombre
FROM pago p
INNER JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas;

/*3. Muestra el nombre de los clientes que no hayan realizado pagos junto
con el nombre de sus representantes de ventas.*/

/*No encontre la forma de hacerlo sin subconsultas*/
-- No funciona
SELECT DISTINCT c.nombre_cliente, c.codigo_cliente
FROM pago p, cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE p.codigo_cliente != c.codigo_cliente;


-- Utilzando subconsultas:
SELECT  c.nombre_cliente, c.codigo_cliente
FROM cliente c, empleado e
WHERE c.codigo_cliente != ALL(SELECT codigo_cliente from pago)
AND e.codigo_empleado = c.codigo_empleado_rep_ventas
;

-- Utilzando INNER JOIN y subconsultas:
SELECT  c.nombre_cliente, c.codigo_cliente
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente != ALL(SELECT codigo_cliente from pago)
;

/*4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de
sus representantes junto con la ciudad de la oficina a la que pertenece
el representante.*/
SELECT c.nombre_cliente, c.codigo_cliente, e.nombre, o.ciudad
FROM pago p
INNER JOIN cliente c ON p.codigo_cliente = c.codigo_cliente
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina;

/*5. Devuelve el nombre de los clientes que no hayan hecho pagos y el
nombre de sus representantes junto con la ciudad de la oficina a la que
pertenece el representante.
*/

SELECT  c.nombre_cliente, c.codigo_cliente, e.nombre, o.ciudad
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE c.codigo_cliente != ALL(SELECT codigo_cliente from pago)
;

/*6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada*/

SELECT DISTINCT o.codigo_oficina, o.linea_direccion1, c.ciudad 
FROM oficina o
INNER JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
INNER JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.ciudad like 'Fuenlabrada';

/*7. Devuelve el nombre de los clientes y el nombre de sus representantes
junto con la ciudad de la oficina a la que pertenece el representante.*/

SELECT c.nombre_cliente, e.nombre, o.ciudad
FROM cliente c
INNER JOIN empleado e ON e.codigo_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina o ON o.codigo_oficina = e.codigo_oficina;

/*8. Devuelve un listado con el nombre de los empleados junto con el
nombre de sus jefes.*/
SELECT e.nombre, e.apellido1, e.codigo_empleado, s.codigo_empleado AS codigo_jefe , s.nombre AS nombre_jefe
FROM empleado s
INNER JOIN empleado e ON e.codigo_jefe = s.codigo_empleado
order by e.codigo_empleado;

/*9. Devuelve un listado que muestre el nombre de cada empleados, el
nombre de su jefe y el nombre del jefe de sus jefe.*/
SELECT e.nombre, e.codigo_empleado, s.nombre AS nombre_jefe, s.codigo_empleado AS codigo_jefe, t.nombre AS nombre_jefe_de_jefe, t.codigo_empleado AS codigo_jefe_de_jefe
FROM empleado e
INNER JOIN empleado s ON e.codigo_jefe = s.codigo_empleado
INNER JOIN empleado t ON s.codigo_jefe = t.codigo_empleado
;

/*10.Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.*/

SELECT DISTINCT c.nombre_cliente, c.codigo_cliente
FROM cliente c
INNER JOIN pedido p ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada
ORDER BY c.codigo_cliente;

/*11. Devuelve un listado de las diferentes gamas de producto que ha
comprado cada cliente.*/

SELECT DISTINCT p.gama, c.nombre_cliente
FROM producto p
INNER JOIN detalle_pedido dp ON dp.codigo_producto = p.codigo_producto
INNER JOIN pedido pe ON pe.codigo_pedido = dp.codigo_pedido
INNER JOIN cliente c ON pe.codigo_cliente = c.codigo_cliente
ORDER BY c.nombre_cliente
;