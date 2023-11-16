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

insert into recibo(legajo, fecha)
values(4, '2021-1-22'), (3, '2021-05-1'), (3, '2021-2-20'), (2, '2021-05-11'), (2, '2021-7-15'), (2, '2011-03-14'),
(5, '2016-12-22'), (8, '2001-03-11'),(8, '2006-09-22'), (10, '2011-05-28'),(11, '2016-10-30'), (11, '2011-05-19');

insert into empleado(apellido, nombre, idTurno, sueldoBasico)
VALUES('lopez','marcos',3, 9000), ('perez', 'juan', 1, 1000000), ('martinez', 'romina', 2, 240000);

insert into empleado(apellido, nombre, idTurno, sueldoBasico)
VALUES('pepe','juan',1, 15000), ('sanchez', 'rocio', 1, 20000), ('flores', 'sofia', 2, 10000);

insert into empleado(apellido, nombre, idTurno, sueldoBasico)
VALUES('acosta','javier',1, 50000), ('turpo', 'analia', 3, 20000), ('aguilar', 'sergio', 2, 80000);

select * from empleado;
select * from recibo;
select * from turno;