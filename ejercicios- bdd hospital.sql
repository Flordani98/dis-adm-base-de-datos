-- SUBCONSULTAS

-- 1. Mostrar el numero de empleado, el apellido y la fecha de alta del empleado mas antiguo de la empresa
SELECT id_empleado, apellido, fecha_alta
FROM empleado
WHERE fecha_alta = (SELECT MIN(fecha_alta) FROM empleado);

-- 2. Mostrar el numero de empleado, el apellido y la fecha de alta del empleado mas modernos de la empresa
SELECT id_empleado, apellido, fecha_alta
FROM empleado
WHERE fecha_alta = (SELECT MAX(fecha_alta) FROM empleado);

-- 3. Mostrar el apellido y el oficio de los empleados con el mismo oficio que Arroyo.
select apellido, oficio
from empleado
WHERE oficio = (SELECT oficio FROM empleado WHERE apellido like 'ARROYO');

-- 4. Mostrar apellidos y oficio de los empleados del departamento 2 cuyo trabajo sea el mismo que el de cualquier empleado de ventas.

SELECT apellido, oficio
FROM empleado
WHERE id_departamento = 2 AND oficio IN (SELECT oficio 
										FROM empleado e
                                        WHERE id_departamento = (SELECT id_departamento FROM departamento WHERE nombre like 'VENTAS'))
;
select * from empleado;
select * from departamento;

-- 5. Mostrar los empleados que tienen mejor salario que la media de los vendedores, no incluyendo al presidente.

SELECT * 
FROM empleado
WHERE salario > (SELECT AVG(salario) FROM empleado WHERE oficio LIKE 'VENDEDOR')
AND oficio != 'presidente';


-- 6. Mostrar los hospitales que tienen personal (Doctores) de cardiología.

SELECT * 
from hospital
WHERE id_hospital IN (SELECT id_hospital FROM doctor WHERE especialidad like 'cardiologia');

select * from doctor;
select * from hospital;
select * from plantilla;
select * from empleado;

-- 7. Visualizar el salario anual de los empleados de la plantilla del Hospital Provincial y General. (Realizar con subconsulta)
SELECT salario, salario*12 AS salario_anual, id_empleado, apellido
FROM empleado
WHERE id_empleado IN (SELECT id_empleado 
					  FROM plantilla 
                      WHERE id_hospital IN (SELECT id_hospital 
											FROM hospital 
                                            WHERE nombre IN('provincial','general')));


-- 8. Realizar el ejercicio anterior pero sin subconsultas
SELECT e.salario, e.salario*12 AS salario_anual, e.id_empleado, e.apellido
FROM empleado e
INNER JOIN plantilla p ON p.id_empleado = e.id_empleado
INNER JOIN hospital h ON h.id_hospital = p.id_hospital
WHERE h.nombre IN('provincial','general')
GROUP BY (e.id_empleado);

-- 9. Mostrar el apellido de los pacientes que nacieron antes que el Señor Miller.

SELECT apellido, fecha_nac
FROM enfermo
WHERE fecha_nac < (SELECT fecha_nac FROM enfermo WHERE apellido like 'miller%')
;
select * FROM enfermo;



-- STORE PROCEDURES

-- 1 - Sacar todos los empleados que se dieron de alta entre una determinada fecha inicial y fecha final y 
-- que pertenecen a un determinado departamento.

delimiter $$
create procedure muestraEmpleadosSegunFechaAltayDepartamento
(
	in p_fechaInicial DATETIME,
	in p_fechaAlta DATETIME,
    in p_nombreDepartamento varchar(100)
)
BEGIN
	SELECT id_empleado, apellido, fecha_alta, id_departamento
	FROM empleado
	WHERE fecha_alta BETWEEN p_fechaInicial AND p_fechaAlta 
	AND id_departamento = (SELECT id_departamento FROM departamento WHERE nombre like p_nombreDepartamento)
	ORDER BY fecha_alta;
END
$$

delimiter ;
CALL muestraEmpleadosSegunFechaAltayDepartamento('1981-03-01 00:00:00', '2003-06-11 00:00:00', 'ventas');
;

select * from empleado;

-- 2 - Crear procedimiento que nos devuelva salario, oficio y comisión, pasándole el apellido.

delimiter $$
create procedure muestraEmpleadoSegunApellido
(
	IN p_apellido VARCHAR(100)
)
BEGIN
	SELECT salario, oficio, comision
	FROM empleado
	WHERE apellido like p_apellido;
END
$$

CALL muestraEmpleadoSegunApellido('sala');

-- 3 - Crear un procedimiento para mostrar el salario, oficio, apellido y nombre del departamento de todos 
-- los empleados que contengan en su apellido el valor que le pasemos como parámetro.

delimiter $$
create procedure muestraEmpleadosSegunApellido
(
	IN p_apellido VARCHAR(100)
)
BEGIN
	SELECT e.salario, e.oficio, e.apellido, (SELECT nombre FROM departamento d WHERE d.id_departamento = e.id_departamento) AS nombreDepartamento
	FROM empleado e
	WHERE e.apellido LIKE CONCAT('%', p_apellido, '%');
END
$$

delimiter ;
CALL muestraEmpleadosSegunApellido('negr');
select * from empleado;


-- 4 - Crear un procedimiento que recupere el número departamento, el nombre y número de empleados, dándole como valor el nombre del departamento, 
--     si el nombre introducido no es válido, mostraremos un mensaje informativo comunicándolo.
delimiter $$
CREATE PROCEDURE muestraDepartamentoSegunNombre
(
	IN p_nombre_dep VARCHAR(100)
)
BEGIN
	DECLARE dep_verifica VARCHAR (100); -- crea la variable dep_verifica
	SET dep_verifica = NULL;
    
	SELECT nombre INTO dep_verifica -- guarda el nombre del departamento si es que el p_nombre_dep coincide con ALGUN nombre de la tabla departamento
	FROM departamento
	WHERE nombre LIKE p_nombre_dep;
    
	IF(dep_verifica IS NULL) THEN -- si no se encontro ningun nombre de departamento con el nombre introducido
		SELECT CONCAT('DEPARTAMENTO INTRODUCIDO NO VALIDO: ', p_nombre_dep) AS mensaje;
	ELSE
		SELECT e.id_departamento, d.nombre, COUNT(e.id_empleado) AS cant_empleados
		FROM empleado e
		INNER JOIN departamento d ON d.id_departamento = e.id_departamento
		WHERE d.nombre LIKE p_nombre_dep
		GROUP BY e.id_departamento;
	END IF;
END
$$

delimiter ;
CALL muestraDepartamentoSegunNombre('inhhjformatica');