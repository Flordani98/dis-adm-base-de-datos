USE `proveedores_repaso_2dop`;

CREATE TABLE pieza
(
	codigo int primary key auto_increment,
    nombre varchar(100)
);

CREATE TABLE suministra
(
	codigo_pieza int ,
    id_proveedor char(4),
    precio int,
    PRIMARY KEY(codigo_pieza, id_proveedor)
);

CREATE TABLE proveedor
(
	id char(4) primary key,
    nombre varchar(100)
);

ALTER TABLE suministra
add constraint fkcodigo_pieza foreign key(codigo_pieza) references pieza(codigo),
add constraint fkid_proveedor foreign key(id_proveedor) references proveedor(id);


