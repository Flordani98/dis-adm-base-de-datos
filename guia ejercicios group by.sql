/*GROUP BY*/

/*1. Calcula la suma del presupuesto de todos los departamentos.*/
SELECT 
    SUM(presupuesto)
FROM
    departamento;

/*2. Calcula la media del presupuesto de todos los departamentos*/
SELECT 
    CAST(IFNULL((AVG(presupuesto)), 0) AS DECIMAL (10 , 2 )) AS promedio
FROM
    departamento;

 -- 3.Calcula el valor mínimo del presupuesto de todos los departamentos.
SELECT 
	MIN(presupuesto)
FROM
	departamento;
    
-- 4. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con menor presupuesto.
SELECT 
    d.nombre, d.presupuesto
FROM
    departamento d
WHERE
    d.presupuesto = (SELECT 
            MIN(presupuesto)
        FROM
            departamento);
-- 5. Calcula el valor máximo del presupuesto de todos los departamentos
SELECT
	MAX(presupuesto)
FROM departamento;

-- 6. Calcula el nombre del departamento y el presupuesto que tiene asignado, del departamento con mayor presupuesto.
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamento);

-- 7. Calcula el número total de empleados que hay en la tabla empleado.
SELECT COUNT(*) AS total_empleados
FROM empleado; 

-- 8. Calcula el número de empleados que no tienen NULL en su segundo apellido
SELECT COUNT(*) AS empleados_con_2apellidos
FROM empleado e
WHERE e.apellido2 is not null;

-- 9. Calcula el número de empleados que hay en cada departamento. Tienes que
-- devolver dos columnas, una con el nombre del departamento y otra con el
-- número de empleados que tiene asignados.

SELECT d.nombre, COUNT(*) as cantidad_empleados
FROM empleado e
INNER JOIN departamento d ON d.codigo = e.codigo_departamento
GROUP BY e.codigo_departamento;

/*10.Calcula el nombre de los departamentos que tienen más de 2 empleados. El
resultado debe tener dos columnas, una con el nombre del departamento y
otra con el número de empleados que tiene asignados.
*/ 

SELECT d.nombre, COUNT(*) as cantidad_empleados
FROM empleado e
INNER JOIN departamento d ON d.codigo = e.codigo_departamento
GROUP BY e.codigo_departamento
HAVING cantidad_empleados > 2;

/*11. Calcula el número de empleados que trabajan en cada uno de los
departamentos. El resultado de esta consulta también tiene que incluir
aquellos departamentos que no tienen ningún empleado asociado.
*/

SELECT d.nombre, COUNT(e.codigo) as cantidad_empleados
FROM empleado e 
RIGHT JOIN departamento d ON d.codigo = e.codigo_departamento
GROUP BY d.codigo;

select e.*, d.*
from empleado e
right join departamento d on d.codigo = e.codigo_departamento;

/*12.Calcula el número de empleados que trabajan en cada unos de los
departamentos que tienen un presupuesto mayor a 200000 euros.*/

SELECT d.nombre, d.presupuesto, COUNT(e.codigo) AS cantidad_empleados
FROM empleado e
INNER JOIN departamento d ON d.codigo = e.codigo_departamento
GROUP BY d.codigo
HAVING d.presupuesto > 200000;