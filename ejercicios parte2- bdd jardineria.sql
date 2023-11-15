/*1.4.6 Consultas multitabla (Composición externa)*/

/*1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.*/

SELECT c.codigo_cliente
FROM cliente c
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE p.codigo_cliente IS NULL
ORDER BY c.codigo_cliente
;

/*2. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.*/

SELECT c.codigo_cliente
FROM cliente c
LEFT JOIN pedido pe ON pe.codigo_cliente = c.codigo_cliente
WHERE pe.codigo_cliente IS NULL
ORDER BY c.codigo_cliente;

/*3. Devuelve un listado que muestre los clientes que no han realizado
ningún pago y los que no han realizado ningún pedido*/

SELECT c.codigo_cliente
FROM pedido pe 
RIGHT JOIN cliente c ON pe.codigo_cliente = c.codigo_cliente
LEFT JOIN pago p ON p.codigo_cliente = c.codigo_cliente
WHERE pe.codigo_cliente IS NULL AND p.codigo_cliente IS NULL
ORDER BY c.codigo_cliente;

select DISTINCT codigo_cliente from cliente order by codigo_cliente;
select DISTINCT codigo_cliente from pago order by codigo_cliente;
select DISTINCT codigo_cliente from pedido order by codigo_cliente;

/*4. Devuelve un listado que muestre solamente los empleados que no
tienen una oficina asociada.*/

SELECT e.codigo_empleado
FROM empleado e
LEFT JOIN oficina o ON o.codigo_oficina = e.codigo_oficina
WHERE e.codigo_oficina IS NULL;

/*5. Devuelve un listado que muestre solamente los empleados que no
tienen un cliente asociado.*/
SELECT e.codigo_empleado
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL;

/*6. Devuelve un listado que muestre solamente los empleados que no
tienen un cliente asociado junto con los datos de la oficina donde
trabajan.*/

SELECT e.codigo_empleado
FROM empleado e
LEFT JOIN cliente c ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE c.codigo_empleado_rep_ventas IS NULL
;