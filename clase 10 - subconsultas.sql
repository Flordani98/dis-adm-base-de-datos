-- CLASE 10 - SUBCONSULTAS
/*
	Hay situaciones (pocas) en que resolver una situación no alcanza con una consulta, pero podemos dentro de esa consulta 
    hacer subconsultas. Una subconsulta es una consulta dentro de otra.
	
    Solamente uno utiliza subconsultas en situaciones muy particulares, dondee lo q yo quiero buscar o analizar no lo conozco sino lo hago con una consulta
    Por ejemplo: quiero ver todos los departamentos que tengan un gasto superior al promedio de gastos que tienen
    
    Las subconsultas tienen un costo bastante elevado
    
    Otro motivo por el cual usar subconsultas 
    
    Tipos de Consultas
		*Valor escalar: producen un unico valor(Una sola fila en una sola columna)
        *Listas: producen una lista de valores (una o mas filas con UNA SOLA columna)
        *Matrices: devuelven un conjunto de resultados (conjunto de filas y columnas)
        
	CUALQUIER TIPO DE CONSULTA SE PUEDE UTILIZAR COMO SUBCONSULTA.
    
    1.Subconsultas ESCALAR se pueden usar en:
		a.*en la clausula SELECT como parte de la lista de los campos de salida
        b.*en el SET de un UPDATE
        c.*en la clausula FROM
        d.*en la clausula WHERE (La MAS COMÚN)
        e.*en la clausula HAVING
	
	2.Subconsultas LISTAS se pueden usar en:
		a.*en la clausula WHERE de cualquier consulta que use el operador IN
        b.*en la clausula WHERE de cualquier consulta que use cualquier operador de comparación con los operadores ALL, SOME, ANY
        
	3.Subconsultas MATRICES se pueden usar en:
		a.*en la clausula FROM
        b.*en la clausula WHERE cuando se usa la función EXISTS o NOT EXISTS para verificar la existencia de valores en la lista. 
			la funcion EXISTS solo devuelve TRUE si existe al menos una fila
            
	
    4.SUBCONSULTAS RELACIONADAS
    Las mas complejas y mas costosas, hay que tratar de evitarlas. 
    Son subconsultas que dependen de valores devueltos por la consulta exterior, no hay forma de que se puede ejecutar de forma independiente
    
*/

-- ej consultas tipo escalar
select avg(gastos) from departamento;
-- ej consultas tipo lista
select gastos from departamento where presupuesto>0;
-- ej. consultas tipo matriz
select * from departamento;
/*------------------------------------------------------------------------------*/
				-- ESCALARES
-- 1a. Solo las subconsultas que devuelven un ESCALAR pueden ir en el SELECT :
SELECT codigo, nombre, (select avg(gastos) from departamento) AS promedio_gastos
from departamento;

-- 1b.
UPDATE departamento -- actualiza los valores de las filas
SET gastos = (SELECT AVG(gastos) FROM departamento)
WHERE codigo = 1;

-- 1c. solo ejemplificamos q se puede utilizar pero no esta correctamente implementado.
SELECT codigo, nombre, (select avg(gastos) from departamento) AS promedio_gastos
from (SELECT MAX(gastos) FROM departamento);

-- 1d.
select codigo, nombre
from departamento
where gastos > (select avg(gastos) from departamento);

-- 1e. solo ejemplificamos q se puede utilizar pero no esta correctamente implementado.
select codigo_departamento, count(*) AS cant_empleados
from empleado
group by codigo_departamento
having count(*) > (select avg(presupuesto) from empleado)  
;

				-- LISTAS
-- 2.a. estos operadores > < <> = no se pueden utilizar con listas
select * from empleado e
where codigo_departamento IN (select codigo from departamento where gastos > 120000); -- hace la comparación de gastos = a cada resultado q devuelva la subconsulta
-- Con el IN pregunto que este dentro de esa lista

-- 2.b.
select * from empleado e
join departamento d on e.codigo_departamento = d.codigo
where gastos >= ALL (select gastos from departamento where gastos > 100000); 
-- con ALL yo quiero q gastos sea MAYOR a TODOS los de la lista
-- ANY: mayor a ALGUNO de la LISTA
-- SOME es equivalente a ANY

-- 3.a. Es util utilizar este tipo de subconsultas cuando se quiere una vista parcial de una tabla, ya q es un subconjunto de la tabla empleado
select * from (select * from empleado where codigo_departamento is not null) emp_con_departamento;

-- 3.b. 
select * from empleado e
join departamento d on e.codigo_departamento = d.codigo
where exists (select 1 from empleado where gastos is not null);
-- el exists solo se fija que devuelva algo, NO se fija que devuelva
-- por lo general el EXISTS se usa en un contexto en el q la subconsulta no se puede ejecutar por separado (dependientes)

-- 4.
select * from empleado e
join departamento d1 on e.codigo_departamento = d1.codigo
where gastos > (select avg(gastos) from departamento d2 where d1.codigo = d2.codigo);
-- listame todos los empleados que trabajan en un departamento donde los gastos sean mayor al promedio de gastos del departamento de ese mismo empleado
-- esta subconsulta es dependiente a la consulta exterior
-- va ejecutando las dos consultas al mismo tiempo, en simultaneo
-- esta subconsulta(DEPENDIENTE) se va ejecutar tantas veces como se ejecuta la consulta general, ya que el valor va cambiando

-- en cambio en las subconsultas INDEPENDIENTES, la subconsulta se ejecuta una vez, se guarda ese valor y se va comparando.
