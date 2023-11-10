/*store procedures*/
/*parametros de entrada*/
/*definimos a un delimiter, q me indica que termina una sentencia, para "engañar al compilador":*/
/*este procedure ejecuta el select el cual muestra un valor escalar*/
delimiter $$
create procedure insertCategoria /*nombre del procedure*/
(
p_nombre varchar(50) /*1 parametro de entrada*/
)

begin /*indica donde arranca el cuerpo del procedure*/
insert into categoria(nombre)
values(p_nombre);
select last_insert_id(); /*devuelve el id del ultimo elemento insertado*/
end/*termina el prcedure*/
$$
delimiter ;


/*para ejecutar el procedure:*/
call insertCategoria('a'); 


/*procedure para retornar un valor*/
delimiter $$
create procedure insertCategoriaa
(in p_nombre varchar (100),
out p_idCar int /*parametro de salida, cuando tengo uno de salida tengo q indicar cual es de entrada*/
)
begin 
INSERT into categoria(nombre)
values(p_nombre);
set p_idCat =  last_insert_id();
end
$$


/*llamar un procedure q retorna*/

call insertCategoriaa('b', @p_idCat);/*aca defino la variable de salida*/
select @p_idCat;