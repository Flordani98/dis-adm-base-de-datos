-- CLASE 12: CASE y repaso 2do parcial
-- sentencia case: en este ejercicio vamos a utilzarlo para devolver algo puntual
select codigo, 
	   nombre, 
       CASE 
			WHEN gastos <1000 THEN 'bajo'
            WHEN gastos >1000 AND gastos <= 10000 THEN 'medio'
			ELSE 'alto'
		END AS categoria_gastos
            
from departamento;

-- a veces se pide no un numero sino una categoria, entonces utilizo el CASE para devolver la categoria
-- when serian los casos

select codigo, 
	   nombre, 
       CASE gastos
			WHEN 1000 THEN 'bajo'
            WHEN gastos BETWEEN 1001 AND 10000 THEN 'medio'
			ELSE 'alto'
		END AS categoria_gastos
            
from departamento;


SELECT codigo, 
       nombre,
       CASE sexo
			WHEN 1 THEN 'femenino'
            WHEN 2 THEN 'masculino'
	   END
from empleado;
-- para migrar la información (normalizar los datos):		
UPDATE empleado SET sexo = 
			CASE sexo
			WHEN 1 THEN 'femenino'
            WHEN 2 THEN 'masculino'
	   END
;

-- si solo hay 2 opciones en vez de utilizar CASE se puede utilizar un IF
-- las sentencias if else no son sentencias sql nativas, sino que cada motor las implementa
UPDATE empleado SET sexo = 
			IF(sexo = 1, 'f', 'm') -- si sexo es igual a 1 entonces se guarda un 'f', sino se guarda 'm'
			-- este IF es una funcion
;	
-- el: if then else se utiliza en procedimientos, es otro if
-- tambien existen iteradores


-- Cuento la cantidad de empleados y quiero q me muestre en columnas
-- se utiliza mucho cuando se hace estadisticas periodicas, por ej: devolver todas las ventas q se hicieron año por año, desde hace 5 años para atras

SELECT count(*),
		count(case WHEN codigo_departamento IN (1,2) THEN 1 END)  as 'sistemas', -- cuento si se cumple una condición(cuando el dep sea 1 o 2 entonces es del area de sistemas
        count(CASE when codigo_departamento IN (3,4) THEN 1 END) as 'administracion' -- cuando cod_dep sea 3 o 4 es del area de administración
        -- no me importa lo q devuelve, en este caso ponemos 1 pero podriamos poner cualquier otra cosa ya q no nos interesa
        -- solo importa q se cuente, cuando la condición no se cumple devuelve NULL entonces AHI no lo cuenta el COUNT()
        
FROM empleado e;

-- PARCIAL DE REPASO
-- Resolución hecha en clase:


-- b.
SELECT *
FROM empleado e1 
WHERE e1.sueldoBasico < (SELECT AVG(e2.sueldoBasico) FROM empleado e2  WHERE e1.idTurno = e2.idTurno);



-- c.

delimiter $$

CREATE PROCEDURE recibos
(
	IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
	SELECT e.legajo, 
		   CASE 
				WHEN r.nroRecibo IS NOT NULL THEN 'SI'
                ELSE 'NO'
		   END AS cobro_sueldo
    FROM empleado e
    LEFT JOIN recibo r ON r.legajo = e.legajo
    AND r.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;

END
$$

delimiter ;

CALL recibos('2011-03-14', '2011-05-19');