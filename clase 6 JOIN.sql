use `utn-bdd`;
select * from empleado;
select * from departamento;

/*update empleado
set iddep = 1
where idEmpleado in(1,2,3);

update empleado
set iddep = 2
where idEmpleado =4;

insert into departamento(idDepartamento, nombre)
values(2, 'Marketing');*/
insert into departamento(idDepartamento, nombre)
values(3, 'Publicidad');

select *
from empleado e /*el e es el alias*/
inner join departamento d on e.iddep = d.idDepartamento
where d.nombre = 'sistemas'
;
/*inner: quiero lo que estan en las dos tablas, por mas que yo tenga solo 1 clave foranea y 1 clave primaria, podria tener yo otra u otra vinculacion,
 siempre por lo clave primaria de una tabla y por la foranea de la otra pero NO es la unica condición,entonces
 la condicion para vincular estas dos tablas son de empleado el iddep y de departamento el iddepartamento 
 entonces lo que hace el motor es buscar todas las filas en las que el id dep del empleado coincidan con las iddep de departamento*/
 
 select *
from empleado e /*el e es el alias*/
left join departamento d on e.iddep = d.idDepartamento
/*me lista todas las filas que estan a la izquierda del left,
La tabla que esta a la izquierda es EMPLEADO y a la derecha DEPARTAMENTO
left me trae todas las filas que estan en la tabla empleado más las que coinciden que tengan un departamento con id dep = a iddep del empleado*/
;

select * from empleado e
right join departamento d on e.iddep = d.idDepartamento;
 
/*quiero ver todos los departamentos que no tienen ningun empleado asignado*/
  select *
from departamento d 
left join empleado e on e.iddep = d.idDepartamento
where e.idempleado is null;



/*falta crear ejemplo con la tabla categoria*/
/*listar todos los empleados de la categoria A*/
select * from empleado e
left join departamento d on e.iddep = d.iddep
left join categoria c on c.idcat = d.idcat
where c.nombre = 'A'
;
/*a empleado lo uno a departamento y departamento a categoria*/

/*para vincular 3 tablas*/
