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
 