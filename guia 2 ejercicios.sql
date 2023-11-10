/*EJERCICIOS DE GUIA*/
use `utn-bdd-guia2`;

/*1. Lista el primer apellido de todos los empleados.*/
select apellido1 from empleado;

/*2. Lista el primer apellido de los empleados eliminando los apellidos que estén
repetidos*/
select distinct apellido1 from empleado;

/*3. Lista todas las columnas de la tabla empleado.*/
select * from empleado;

/*4. Lista el nombre y los apellidos de todos los empleados.*/
select nombre, apellido1, apellido2 from empleado;

/*5. Lista el código de los departamentos de los empleados que aparecen en la
tabla empleado*/
select codigo_departamento from empleado;

/*6. Lista el código de los departamentos de los empleados que aparecen en la
tabla empleado, eliminando los códigos que aparecen repetidos.
*/

select distinct codigo_departamento from empleado;

/*7. Lista el nombre y apellidos de los empleados en una única columna.*/
select concat(ifnull(nombre, 'sin nombre'), ' ', ifnull(apellido1, 'sin apellido1'), ' ', ifnull(apellido2,'sin apellido2')) as nombreApellidos
from empleado;

/*8. Lista el nombre y apellidos de los empleados en una única columna,
convirtiendo todos los caracteres en mayúscula.*/
select upper(concat(ifnull(nombre, 'sin nombre'), ' ', ifnull(apellido1, 'sin apellido1'), ' ', ifnull(apellido2,'sin apellido2'))) as nomBreAPELLIDOS
from empleado;

/*9. Lista el nombre y apellidos de los empleados en una única columna,
convirtiendo todos los caracteres en minúscula.*/
select lower(concat(ifnull(nombre, 'sin nombre'), ' ', ifnull(apellido1, 'sin apellido1'), ' ', ifnull(apellido2,'sin apellido2'))) as NOmbrEapELLIDOS
from empleado;

/*10.Lista el código de los empleados junto al nif, pero el nif deberá aparecer en
dos columnas, una mostrará únicamente los dígitos del nif y la otra la letra.*/
select codigo, substring(nif, 1, length(nif)-1),
right(nif, 1) /*recorre desde el ultimo, toma 1 solo valor desde la ultima posición*/
from empleado;

select * from empleado;

/*11. Lista el nombre de cada departamento y el valor del presupuesto actual del
que dispone. Para calcular este dato tendrá que restar al valor del
presupuesto inicial (columna presupuesto) los gastos que se han generado
(columna gastos). Tenga en cuenta que en algunos casos pueden existir
valores negativos. Utilice un alias apropiado para la nueva columna columna
que está calculando.
*/
select nombre, greatest(presupuesto-gastos, 0) as presupuestoactual /*esta funcion Devolverá el valor más grande entre la diferencia calculada y 0,*/
from departamento; /*lo que me muestra es el prespuesto actual y si el mismo es negativo entonces muestra 0*/

/*otra manera de hacerlo, para que cuando el presupuesto actual sea menor q 0, se muestre "Sin presupuesto" o "presupuesto negativo"*/
SELECT nombre, 
       caSE 
         WHEN (presupuesto - gastos) < 0 THEN 'Presupuesto negativo' 
         ELSE (presupuesto - gastos) 
       EnD AS presupuestoActual
FROM departamento;

/*12.Lista el nombre de los departamentos y el valor del presupuesto actual
ordenado de forma ascendente.*/
SELECT nombre, 
       caSE 
         WHEN (presupuesto - gastos) < 0 THEN 'Presupuesto negativo' 
         ELSE (presupuesto - gastos) 
       EnD AS presupuestoActual
FROM departamento
order by presupuestoactual asc;

/*13.Lista el nombre de todos los departamentos ordenados de forma ascendente.*/
select nombre 
from departamento
order by nombre asc;


/*14.Lista el nombre de todos los departamentos ordenados de forma
descendente.*/

select nombre
from departamento
order by nombre desc;

/*15.Lista los apellidos y el nombre de todos los empleados, ordenados de forma
alfabética tendiendo en cuenta en primer lugar sus apellidos y luego su
nombre.
*/

select  apellido1, apellido2, nombre
from empleado
order by apellido1 , apellido2 , nombre; /*por defecto se ordena de forma ascendente (ASC)*/

/*16.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
que tienen mayor presupuesto.*/
select nombre, presupuesto 
from departamento
order by presupuesto desc limit 3;

select * from departamento
order by presupuesto asc
;

/*17.Devuelve una lista con el nombre y el presupuesto, de los 3 departamentos
que tienen menor presupuesto.
*/
select nombre, presupuesto
from departamento
order by presupuesto limit 3;

/*18.Devuelve una lista con el nombre y el gasto, de los 2 departamentos que
tienen mayor gasto.
*/
select nombre, gastos
from departamento
order by gastos desc limit 2;

/*19.devuelve una lista con el nombre y el gasto, de los 2 departamentos que
tienen menor gasto.*/

select nombre, gastos
from departamento
order by gastos limit 2;


/*20.Devuelve una lista con 5 filas a partir de la tercera fila de la tabla empleado. La
tercera fila se debe incluir en la respuesta. La respuesta debe incluir todas las
columnas de la tabla empleado.
*/
select *
from empleado
where codigo>= 3 and codigo<8;

/*otra manera de realizar el ejercicio:*/
SELECT *
FROM empleado
limIt 2, 5; /*el 1er valor(2) indica el indice de la fila el cual comienzo a obtener los resultado
, y el2do valor(5) indica la cantidad de filas que deseo obtener*/

select * from empleado;

/*21.devuelve una lista con el nombre de los departamentos y el presupuesto, de
aquellos que tienen un presupuesto mayor o igual a 150000 euros.*/

select nombre, presupuesto
from departamento
where presupuesto >= 150000;

/*22.Devuelve una lista con el nombre de los departamentos y el gasto, de
aquellos que tienen menos de 5000 euros de gastos.*/

select nombre, gastos
from departamento
where gastos < 5000;

/*23.Devuelve una lista con el nombre de los departamentos y el presupesto, de
aquellos que tienen un presupuesto entre 100000 y 200000 euros. Sin utilizar
el operador BETWEEN.
*/
select nombre, presupuesto
from departamento
where presupuesto>100000 and presupuesto<200000;
/*con BETWEen seria:
WHERE presupuesto BETWEEN 100000 AND 200000*/

/*24.Devuelve una lista con el nombre de los departamentos que no tienen un
presupuesto entre 100000 y 200000 euros. Sin utilizar el operador BETWEEN.
*/
select nombre, presupuesto
from departamento
where presupuesto<100000 or presupuesto>200000;

select nombre, presupuesto from departamento
order by presupuesto;

/*25.Devuelve una lista con el nombre de los departamentos que tienen un
presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.
*/
select nombre, presupuesto
from departamento
where presupuesto BEtween 100000 AND 200000;

/*26.devuelve una lista con el nombre de los departamentos que no tienen un
presupuesto entre 100000 y 200000 euros. Utilizando el operador BETWEEN.*/
select nombre, presupuesto
from departamento
where presupuesto NOt betWEEN 100000 And 200000;

/*27.devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean mayores que
el presupuesto del que disponen.*/

select nombre, gastos, presupuesto
from departamento
where gastos > presupuesto;

select presupuesto, gastos from departamento
order by presupuesto;

/*28.Devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean menores que
el presupuesto del que disponen.
*/

select nombre, gastos, presupuesto
from departamento
where gastos<presupuesto;

/*29.devuelve una lista con el nombre de los departamentos, gastos y
presupuesto, de aquellos departamentos donde los gastos sean iguales al
presupuesto del que disponen.
*/
select nombre, gastos, presupuesto
from departamento
where gastos = presupuesto;

/*30.Lista todos los datos de los empleados cuyo segundo apellido sea NULL.*/
select * 
from empleado
where apellido2 is null;

/*31.Lista todos los datos de los empleados cuyo segundo apellido no sea NULL.*/
select * 
from empleado
where apellido2  is not null;

/*32.Lista todos los datos de los empleados cuyo segundo apellido sea López.*/
select *
from empleado
where apellido2 like 'lopez';

/*33.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o
Moreno. Sin utilizar el operador IN.*/

select * 
from empleado
where apellido2 like 'diaz' or apellido2 like 'moreno';

/*34.Lista todos los datos de los empleados cuyo segundo apellido sea Díaz o
Moreno. Utilizando el operador IN.*/
select * 
from empleado
where apellido2 in('diaz','moreno');

/*35.Lista los nombres, apellidos y nif de los empleados que trabajan en el
departamento 3.*/

select nombre, apellido1, apellido2, nif
from empleado
where codigo_departamento = 3; 

select * from empleado;
/*36.Lista los nombres, apellidos y nif de los empleados que trabajan en los
departamentos 2, 4 o 5.*/

select nombre, apellido1, apellido2, nif
from empleado
where codigo_departamento in(2,4,5); 


/*Consultas multitabla (Composición interna)
1. Devuelve un listado con los empleados y los datos de los departamentos
donde trabaja cada uno.
*/
select * 
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento;

select * from empleado;
select * from departamento;
use `utn-bdd-guia2`;


/*2. Devuelve un listado con los empleados y los datos de los departamentos
donde trabaja cada uno. Ordena el resultado, en primer lugar por el nombre
del departamento (en orden alfabético) y en segundo lugar por los apellidos y
el nombre de los empleados.
*/

select e.nombre, e.apellido1, e.apellido2, e.codigo_departamento, d.nombre
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
order by d.nombre asc, e.apellido1 asc, e.apellido2 asc, e.nombre;

/*3. Devuelve un listado con el código y el nombre del departamento, solamente
de aquellos departamentos que tienen empleados*/

select distinct d.codigo, d.nombre /*muestra solo los codigo distintos*/
from departamento d 
inner join empleado e on d.codigo = e.codigo_departamento
order by d.codigo;

/*4. Devuelve un listado con el código, el nombre del departamento y el valor del
presupuesto actual del que dispone, solamente de aquellos departamentos
que tienen empleados. El valor del presupuesto actual lo puede calcular
restando al valor del presupuesto inicial (columna presupuesto) el valor de los
gastos que ha generado (columna gastos).
*/

select distinct d.codigo, d.nombre, greatest(presupuesto-gastos, 0) as presupuestoActual /*esta funcion Devolverá el valor más grande entre la diferencia calculada y 0,*/
from departamento d
inner join empleado e on d.codigo = e.codigo_departamento
order by presupuestoActual desc;

/*devuelve el nombre del departamento donde trabaja el empleado que tiene el
nif 38382980M.
*/
select d.nombre
from departamento d
inner join empleado e on d.codigo = e.codigo_departamento
where e.nif = '38382980M';

/*6. devuelve el nombre del departamento donde trabaja el empleado Pepe Ruiz
Santana.
*/
select d.nombre, e.nombre, e.apellido1, e.apellido2
from departamento d
inner join empleado e on d.codigo = e.codigo_departamento
where e.nombre like 'Pepe' and e.apellido1 like 'Ruiz' and e.apellido2 like 'Santana';

/*7. Devuelve un listado con los datos de los empleados que trabajan en el
departamento de I+D. Ordena el resultado alfabéticamente.
*/
select e.codigo, e.nif, e.nombre, e.apellido1, e.apellido2, e.codigo_departamento
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
where d.nombre = 'I+D'
order by e.nombre asc;

/*8. Devuelve un listado con los datos de los empleados que trabajan en el
departamento de Sistemas, Contabilidad o I+D. Ordena el resultado
alfabéticamente.
*/

select e.codigo, e.nif, e.nombre, e.apellido1, e.apellido2, e.codigo_departamento, d.nombre
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
where d.nombre in('Sistemas', 'contabilidad', 'i+D')
order by d.nombre;

/*9. Devuelve una lista con el nombre de los empleados que tienen los
departamentos que no tienen un presupuesto entre 100000 y 200000 euros.*/
select e.nombre, d.presupuesto, d.nombre
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
/*where presupuesto < 100000 or presupuesto >200000;*/
where presupuesto not between 100000 and 200000;

/*10.devuelve un listado con el nombre de los departamentos donde existe algún
empleado cuyo segundo apellido sea NULL. Tenga en cuenta que no debe
mostrar nombres de departamentos que estén repetidos.
*/

select distinct d.nombre, e.apellido2
from empleado e
inner join departamento d on d.codigo = e.codigo_departamento
where apellido2 is null;

/*Consultas multitabla (composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

1. Devuelve un listado con todos los empleados junto con los datos de los
departamentos donde trabajan. Este listado también debe incluir los
empleados que no tienen ningún departamento asociado.
*/

select * 
from empleado e
left join departamento d on d.codigo = e.codigo_departamento;

/*2. Devuelve un listado donde sólo aparezcan aquellos empleados que no tienen
ningún departamento asociado.
*/

select *
from empleado e
left join departamento d on d.codigo = e.codigo_departamento
where d.codigo is null;

/*3. Devuelve un listado donde sólo aparezcan aquellos departamentos que no
tienen ningún empleado asociado.
*/

select * 
from departamento d
left join empleado e on e.codigo_departamento = d.codigo
where e.codigo_departamento is null;

/*4.devuelve un listado con todos los empleados junto con los datos de los
departamentos donde trabajan. El listado debe incluir los empleados que no
tienen ningún departamento asociado y los departamentos que no tienen
ningún empleado asociado. Ordene el listado alfabéticamente por el nombre
del departamento.
*/
/*NO FUNCIONA EL ORDER CON EL UNION*/
(select *
from empleado e
left join departamento d on d.codigo = e.codigo_departamento
order by d.nombre)
UnIOn
(select e.codigo, e.nif, e.nombre, e.apellido1, e.apellido2, e.codigo_departamento, d.codigo, d.nombre, d.presupuesto, d.gastos
from departamento d
left join empleado e on e.codigo_departamento = d.codigo
order by d.nombre);

/*5. Devuelve un listado con los empleados que no tienen ningún departamento
asociado y los departamentos que no tienen ningún empleado asociado.
Ordene el listado alfabéticamente por el nombre del departamento.*/

/*NO FUNCIONA EL ORDER CON EL UNION*/
(
select *
from empleado e
left join departamento d on d.codigo = e.codigo_departamento
where e.codigo_departamento is null
)

UNION
(
select e.codigo, e.nif, e.nombre, e.apellido1, e.apellido2, e.codigo_departamento, d.codigo, d.nombre, d.presupuesto, d.gastos
from departamento d
left join empleado e on e.codigo_departamento = d.codigo
where e.codigo is null
);

/*RESOLUCiON DEL CAMpus:*/
SELECT e.*, d.*
FROM empleado e
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
UNION
SELECT e.*, d.*
FROM empleado e
RIGHT JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE e.codigo IS NULL OR d.codigo IS NULL
order BY 8; /*de esta mAnerA si funciona, sE ordeNa poR La columna 8*/
/*antes: order by d.nombre*/

 
 /*response:  La tabla 'd' de uno de los SELECT no se puede utilizar en la cláusula ORDER global*/

