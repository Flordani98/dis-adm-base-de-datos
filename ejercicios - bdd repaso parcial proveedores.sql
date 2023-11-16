/*1. Crear un procedimiento almacenado para dar de alta una nueva pieza. Se debe agregar la pieza y el precio de la
misma. Realice la llamada al procedimiento.*/
delimiter $$
create procedure alta_nueva_pieza
(
	IN p_nombre_pieza varchar(100),
    IN p_precio_pieza int,
    IN p_id_proveedor char(4)
)
BEGIN
	DECLARE codigo_pieza_insertada int;
	
    insert into pieza(nombre)
    values(p_nombre_pieza);

    set codigo_pieza_insertada = last_insert_id();
    
    insert into suministra(codigo_pieza, id_proveedor, precio)
    values(codigo_pieza_insertada, p_id_proveedor, p_precio_pieza)
    ;
END
$$
delimiter ;



CALL alta_nueva_pieza("nueva pieza", 12400, 'A1');

-- 2. Mostrar todos los proveedores que tengan en el nombre la palabra “Gonzalez”. 
SELECT * 
FROM proveedor
WHERE nombre like "%gonzalez%";

-- 3. Mostrar el nombre del proveedor, nombre de la pieza y precio de todas las piezas. Mostrar todos los
-- proveedores, si no suministran piezas, mostrar en su lugar “sin piezas” 
SELECT pr.nombre, 
		CASE 
			WHEN s.id_proveedor IS NOT NULL THEN CONCAT(pi.nombre, ', $',s.precio)
			ELSE "sin piezas"
		END AS nombre_precio_pieza
FROM proveedor pr
LEFT JOIN suministra s ON pr.id = s.id_proveedor 
LEFT JOIN pieza pi ON pi.codigo = s.codigo_pieza

/*sino encuentra en la tabla suministra el id del proveedor, significa q no suministra piezas*/
;
select * from pieza;
select * from suministra;
select * from proveedor;

-- 4. Mostrar las piezas más caras de cada proveedor. (sin subconsultas) 
select s1.id_proveedor, pr.nombre, pi.nombre, s1.precio -- piezas mas caras, si hay 2 piezas mas caras se tiene q mostrar junto con el nombre del proveedor
from proveedor pr
join suministra s1 ON s1.id_proveedor = pr.id
join pieza pi ON pi.codigo = s1.codigo_pieza
LEFT JOIN suministra s2 ON s2.id_proveedor = pr.id AND s2.precio > s1.precio
WHERE s2.id_proveedor IS NULL
order by pr.id
;

/*5. Mostrar la cantidad de piezas suministradas por cada proveedor, pero solamente de aquellos que suministran
más de 100 piezas. (sin subconsultas)*/

SELECT pr.nombre, COUNT(s.codigo_pieza), pr.id
FROM suministra s
LEFT JOIN proveedor pr ON s.id_proveedor = pr.id
GROUP BY s.id_proveedor
HAVING COUNT(s.codigo_pieza) >3; -- >100 (pero no tengo un proveedor q tenga tantas piezas)

/*6. Mostrar el nombre de los proveedores que suministran piezas con precio mayor a la media de todas las piezas
(con subconsultas). */

SELECT DISTINCT nombre
FROM proveedor pr
INNER JOIN suministra s ON pr.id = s.id_proveedor
WHERE s.precio > (SELECT AVG(precio) FROM suministra)
;