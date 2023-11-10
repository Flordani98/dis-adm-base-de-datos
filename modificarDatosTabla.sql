update empleado
set nombre = 'juana', apellido='lopez'
where idempleado = 3;

select * from empleado;

update empleado
set sueldo=0
where sueldo is null;

delete from empleado /*borra todas las filas sino pongo alguna condición con el where*/
where idempleado = 4
;

select * from departamento;
insert into departamento(iddepartamento, nombre)
values(1, 'Sistemas');

update empleado
set iddep = 3 /*no se puede añadir este id a estos empleados porque no existe es iddep en la tabla departamento ya que es una foreign key*/
where idempleado in(4,5); /*para que la condicion se aplique en los empleados con id 1,2 y 3*/

/*borro un departamento a todos los empleados
update: para borrar el valor de una celda(columna)
delete: para borrar filas completas */
update empleado
set iddep = null
where iddep = 1;

select * from empleado
where sueldo>=0
order by nombre asc, apellido desc limit 2; /*van las columnas que quiero que tengan un orden, sino le pongo nada por defecto es asc
entonces ordena por nombre ascendente primero y luego hace un 2do ordenamiento por apellido de forma descendente
LIMIT: para limitar la cantidad de filas q quiero mostrar*/
/*con ORDER BY podemos dar un orden especifico a la salida de datos, si no lo pongo un orden por lo general se le ordena por la clave primaria*/
