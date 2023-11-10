USE `repaso_2do_parcial_bdd`;

CREATE TABLE empleado
(
	legajo int primary key,
    apellido varchar(50),
    nombre varchar(50),
    idTurno int,
    sueldoBasico decimal
);
CREATE TABLE recibo
(
	nroRecibo int primary key,
    legajo int,
    fecha DATE
);

CREATE TABLE turno
(
	idTurno int primary key,
    nombre varchar(50)

);

ALTER TABLE empleado
add constraint fkturno foreign key(idTurno) references turno(idTurno);

ALTER TABLE recibo
add constraint fklegajo foreign key(legajo) references empleado(legajo);

ALTER TABLE recibo
modify column legajo int;

ALTER TABLE turno
modify column idTurno int auto_increment;

alter table empleado
modify column legajo int AUTO_INCREMENT;

alter table recibo
drop foreign key fklegajo;

alter table empleado
drop foreign key fklegajo;

alter table recibo
modify column nroRecibo int AUTO_INCREMENT;

insert into turno(nombre)
values('mañana'), ('tarde'), ('noche');

insert into empleado(apellido, nombre, idTurno, sueldoBasico)
VALUES('mamani','florencia',1, 599000), ('mamani', 'ezequiel', 2, 700000);

insert into recibo(legajo, fecha)
values(1, '2016-12-22'), (2, '2011-08-11');

insert into empleado(apellido, nombre, idTurno, sueldoBasico)
VALUES('lopez','marcos',3, 9000), ('perez', 'juan', 1, 1000000), ('martinez', 'romina', 2, 240000);

