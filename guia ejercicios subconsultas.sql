/*SUBCONSULTAS*/
-- 1.2.7.1 Con operadores básicos de comparación

/*1. Devuelve un listado con todos los empleados que tiene el departamento de
Sistemas. (Sin utilizar INNER JOIN).*/

SELECT e.nombre
FROM empleado e
WHERE e.codigo_departamento = (SELECT d.codigo FROM departamento d WHERE d.nombre = 'sistemas');


select d.nombre, count(e.codigo)
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
group by d.nombre;

/*2. Devuelve el nombre del departamento con mayor presupuesto y la cantidad
que tiene asignada.
*/

SELECT nombre, presupuesto, (SELECT cast(avg(presupuesto) as decimal(10,2)) FROM departamento) as  promedio_presupuesto
FROM departamento
where presupuesto = (SELECT MAX(presupuesto) from departamento);


select cast(avg(presupuesto) as decimal(10,2)) as promedio_presupuesto
from departamento;

/*3. Devuelve el nombre del departamento con menor presupuesto y la cantidad
que tiene asignada.*/

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (SELECT MIN(presupuesto) from departamento);


-- 1.2.7.2 Subconsultas con ALL y ANY
/*4. Devuelve el nombre del departamento con mayor presupuesto y la cantidad
que tiene asignada. Sin hacer uso de MAX, ORDER BY ni LIMIT*/

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto >= ALL (SELECT presupuesto FROM departamento);

/*5. Devuelve el nombre del departamento con menor presupuesto y la cantidad
que tiene asignada. Sin hacer uso de MIN, ORDER BY ni LIMIT.*/

SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto <= ALL(SELECT presupuesto FROM departamento);

/*6. Devuelve los nombres de los departamentos que tienen empleados
asociados. (Utilizando ALL o ANY).*/

SELECT nombre, codigo
FROM departamento
WHERE codigo = ANY(SELECT codigo_departamento FROM empleado);

/*7. Devuelve los nombres de los departamentos que no tienen empleados
asociados. (Utilizando ALL o ANY).*/
SELECT nombre, codigo
FROM departamento
WHERE codigo <> ALL(SELECT codigo_departamento FROM empleado WHERE codigo_departamento IS NOT NULL);
