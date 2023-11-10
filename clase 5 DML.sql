use `utn-bdd`;

alter table empleado
add sueldo decimal(10,2);

alter table empleado
add activo bit;

alter table empleado
add apellido varchar(50);

/*-DML-
Insertar fila de datos:*/
insert into empleado(nombre, apellido, sueldo, activo) /*entre () colocamos las columnas sobre las q vamos a ingresar un valor*/
values('florencia','mamani', 550000.98, 1),
('ezequiel','mamani', 600000.01, 1);

insert into empleado(nombre, apellido, sueldo, activo)
values('juan', 'paez', null, 1);

SELECT idEmpleado, nombre, apellido, sueldo 
FROM empleado
WHERE idEmpleado =1/*condicion que tiene q cumplirse para q se muestre, el WHERE filtra FILAS*/
;
/*q hace el motor, al ejecutar esta sentencia:
*primero se fija la sintaxis, tiene un compilador q se fija antes de ejecutarlo
*si la sentencia esta bien escerita se fija si el usuario que va a ejecutar esta sentencia tiene permisos para realizarlo en esta base de datos 
en esta tabla especifica, y si puede ver esas columnas
*luego empieza armar un plan de ejecución, lee la consulta y se fija si hay un where antes de ejecutarlo, se fija la condiciòn y si incluye una columna
q es clave entonces va a ir a buscar el indice asociado a esa clave para hacer la ejecucion de acuerdo al indice.  
sino es una columna clave, entonces recorre toda la tabla y va mostrando
*luego va al select y se fija que columnas se van a mostrar

*/
SELECT * FROM empleado;
/*puedo formatear algunos resultados: */

SELECT concat(apellido, ' ', nombre), sueldo/*puedo concatenar, el nombre de la columna se muestra con el nombre de la funcion utilizada "concat(apellido,'',nombre)"*/
FROM empleado
WHERE idempleado = 1
;

SELECT concat(apellido, ' ', nombre) as nombreapellido, sueldo /*para solucionar el nombre de la columna y poner un alias(para proyectar con un emcabezado diferente)*/
FROM empleado
WHERE idempleado = 1 and nombre = 'florencia'; /*lo que va  en el where siempre son las columnas tal cual estan, nunca un alias!*/
/*se puede utilizar el AND OR mayor menor*/

/*operador para buscar similares, no exactamente iguales*/
SELECT concat(apellido, ' ', nombre) as nombreapellido, sueldo 
FROM empleado
WHERE apellido like '_a%';
/*WHERE apellido like 'perez' /*busca exactamente que sea perez*/
/*WHERE apellido like 'p%'/*q me devuelva todos los empleados que empiecen con la letra p, el apellido debe empezar con p*/
/*WHERE apellido like '_a%'; me devuelve todos los apellidos que tengan como segunda letra una a!*/

insert into empleado(nombre)
values('ana');
/*ana no tiene apellido, es null, entonces en el concat no lo va a mostrar sin embargo se lo puede mostrar de una manera con mas funciones:*/
SELECT concat(ifnull(apellido, 'x'), ' ', nombre) as nombreapellido, sueldo /*si el apellido es null, entonces lo reempleazo con el 2doparametro "x"*/
FROM empleado /*la funcion ifnull la puedo usar en ambas columnas si quiero*/
;

/*distinct: me permite listar todas las filas q son diferentes, si alguna fila es igual a otra, entonces no la muestra, ELIMINA LOS REPETIDOS*/
insert into empleado(nombre, apellido, sueldo)
values('juan', 'paez', 128000.21)
;
SELECT distinct apellido, nombre 
FROM empleado
;

/*se pueden mostrar los columnas numericas habiendo realizado alguna operacion matematica:*/
select nombre, apellido, nombre, sueldo, sueldo*2.5 
from empleado;

/*ver todos los empleados que no tienen un sueldo asignado:*/
select nombre, apellido
from empleado
where sueldo is null
;

