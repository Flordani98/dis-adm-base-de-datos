
-- a. Listar el total de sueldo x turno pagados en el año 2021. Mostrar únicamente turnos que tuvieron mas de 5 empleados
SELECT e.idTurno, SUM(e.sueldoBasico) AS sueldo_por_turno
FROM empleado e
INNER JOIN recibo r ON r.legajo = e.legajo
WHERE fecha like '2021%'
GROUP BY idTurno
HAVING idTurno IN (SELECT idTurno
				   FROM empleado
				   GROUP BY idTurno
				   HAVING COUNT(legajo) >= 5)
;

SELECT idTurno
FROM empleado
GROUP BY idTurno
HAVING COUNT(legajo) >= 5;

SELECT idTurno, COUNT(legajo) as cant_empleados
FROM empleado
GROUP BY idTurno
HAVING cant_empleados >= 5;

select * from empleado order by idTurno;
select * from recibo order by fecha;
select * from turno;


-- b. Listar empleados que cobran un sueldo inferior al promedio de sueldos de su mismo turno
SELECT legajo, nombre, sueldoBasico, idTurno
FROM empleado e 
WHERE e.sueldoBasico < (SELECT AVG(em.sueldoBasico) FROM empleado em  GROUP BY idTurno HAVING e.idTurno = em.idTurno);


SELECT CAST(AVG(em.sueldoBasico)AS DECIMAL(10,2)) AS promedio_sueldo_turno, idTurno
FROM empleado em  
GROUP BY idTurno ;

-- c. Crear un procedimiento que tome por parámetro una fecha de inicio y una fecha de fin y devuelva todos los empleados indicando
-- cuales cobaron, con el siguiente formato:
--                         Legajo, Cobro_sueldo
--                         1001, 		SI
--                         1002, 		NO

delimiter $$

CREATE PROCEDURE muestraEstadoCobroEmpleados 
(
	IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
	SELECT e.legajo, 
		   CASE 
				-- WHEN (SELECT r.fecha FROM recibo r WHERE e.legajo = r.legajo) BETWEEN p_fecha_inicio AND p_fecha_fin THEN 'SI'
                -- no funciona lo de arriba ya que se retorna mas de un valor y no se puede realizar la comparación
                -- si el e.legajo de empleado tiene un recibo el cual tiene una r.fecha y la misma esta entre p_fecha inicio y p_fecha fin entonces SI (cobro sueldo)
                
				WHEN EXISTS (SELECT 1 FROM recibo r WHERE e.legajo = r.legajo AND r.fecha BETWEEN p_fecha_inicio AND p_fecha_fin) THEN 'SI'
                -- Si existe al menos una fila que cumpla con la condición del where esto devuelve TRUE
                -- el '1' es un marcador de posición o una convención, en su lugar podriamos poner cualquier cosa y la consulta 
                -- seguiria siendo valida, indico que estoy buscando la existencia de algo pero no me importa que sea ese algo
                -- (ya q no lo necesito en este ejercicio)
                ELSE 'NO'
		   END AS cobro_sueldo
    FROM empleado e;

END
$$

delimiter ;

CALL muestraEstadoCobroEmpleados('2011-03-14', '2011-05-19');