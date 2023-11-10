USE `utn-bdd`; /*las sentencias de mysql no son casesensitive, las columnas si. 
TODOS LOS CAMBIOS de una base de datos se hace con un script de datos*/
/*SQL -> DDL, DML y DCL*/

/*Diferencias entre varchar y char en ambos se especifica el tamaño ej:
char(50): cuando pongo 50, me reserva el espacio para 50 caracteres(estatico), cuando escribo el valor, se rellena los caracteres con espacios vacio
y se guarda en memoria
varchar(50): en cambio un varchar de 50, cuando escribo el valor, el espacio se acorta segun los caracteres que coloque, no se reserva el espacio
es dinamico. y si quiero modificar un nombre en el cual se guardo con el la cantidad de caracteres del nombre anterior, se corre ebn memoria, o
se coloca una direccion a  otra parte de la memoria

si voy a modificar un atributo varias veces, entonces me conviene q lo guarde en un char
si no lo voy a modificar, entonces conviene guardarlo en un varchar, por una cuestion de optimización 

*/

/*DDL: sentencias para la creación, modificacion y eliminación de tablas */

CREATE table empleado 
(
idEmpleado int auto_increment primary key,
nombre varchar(50)
);
 CREATE table departamento 
(
idDepartamento int auto_increment primary key,
nombre varchar(50)
);

ALTER table empleado
add column idDep int;

ALTER TABLE empleado
add constraint fkdep foreign key (idDep) references departamento(idDepartamento);

ALTER table departamento
add constraint uqnombre unique(nombre);

alter table empleado
add column domicilio varchar(50);

alter table empleado
modify column nombre varchar(50) not null;

alter table empleado
drop column domicilio;

drop table departamento;

alter table empleado
drop foreign key fkdep;

/*agregar foreign key sin nombre, y el nombre de la clave foranea te la asigna el motor*/
alter table empleado
add foreign key(iddep) references departamento(idDepartamento);

create table proveedor
(
idProv int auto_increment primary key,
nombre varchar(50),
tipodoc tinyint,
nrodoc char(8),

constraint uqdoc unique(tipodoc, nrodoc)
/*constraint pkprov primary key(idProv)  <-  para agregar una clave primaria compuesta*/
);

/*borrar la columna nombre y apellido y crear una columna nombre y apellido todo junto, en el parcial la tabla no tiene datos, en el final si*/
CREATE table empleado 
(
idEmpleado int auto_increment primary key,
nombre varchar(50),
apellido varchar(50),
sueldobase decimal(10,2) default(0) /*default: poner algo por defecto*/
);
/*solucion:*/
alter table empleado
add nombreApellido varchar(50),
drop column nombre,
drop column apellido;


