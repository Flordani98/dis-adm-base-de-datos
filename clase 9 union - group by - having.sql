select * from empleado;
select * from departamento;


/*UNION /*se unen las filas de las tablas, NO las COLUMNAS como lo hace el JOIN
*el JOIN es mas efectivo que el UNION
*hay algunos casos que se utiliza el UNION
*caracteristicas: 
-existen en casi todos los motores
-cuando uso select especifico las columnas, si uso un 2do select este sirve para anexar mas filas, las mismas tienen que ser de igual tipo de dato
que las columnas de la 1er fila y el orden tiene que corresponder  
-la utilidad es baja, pero hay veces que necesitamos ver la información de esa manera*/

select e.codigo, e.nombre, d.nombre, d.gastos as gastos_departamento
from departamento d left join empleado e on e.codigo_departamento = d.codigo
where e.codigo is null
UNION
select e.codigo, e.nombre, d.nombre, d.gastos as gastos_departamento
from departamento d left join empleado e on e.codigo_departamento = d.codigo
where e.codigo is null
order by 2; /*se ordena segun la 2da columna, es decir el e.nombre*/


/*FUNCIONES DE AGREGADO
Sirven para proyectar el resultado de un calculo*/

select SUM(gastos) as SUMA_GASTOS, max(gastos) as maximo,
/*SUM: me suma el valor de la columna gastos, como no hay un where me suma todas las filas, devuelve un(1) valor.
q NO puedo hacer:
  --select nombre, SUM(gastos) as SUMA_GASTOS
  --from departamento;
//esto no se puede hacer ya que el sum esta sumando TODAS las filas, entonces no puede mostrar el nombre de cada departamento

*MAX: devuelve el valor maximo de todas las filas en la columna gastos
*MIN: "" ""  el minimo ""

*/


min(gastos), cast(avg(ifnull(gastos,0)) as decimal(10,2)), count(ifnull(gastos,0))
/*
*AVG(average): devuelve el promedio de gastos, IMPORTANTE: si una fila tiene nulos entonces saltea la fila, es decir no los cuenta para la división,
para que cuente en la división utilizo la función isnull, si gastos es null entonces q le coloque 0, y ahi SI lo cuenta. 
 
*COUNT: cuenta filas, al igual que el AVG ignora los nulos
count(*): cuenta todas las filas que tengan valores
count(gastos): cuenta todas las filas donde haya un valor en gastos

FUNCIONES DE CONVERSION
CAST: convierte el resultado del promedio a lo que le especifico AS decimal(10,2) -> 10 digitos que incluyen 2 decimales
CONVERT
*/

from departamento;


/*group by: agrupar por una columna especificada, sin el group by me devuelve 1 solo resultado, lo agrego cuando quiero hacer sumas parciales
SUMA PARCIALES*/
select e.codigo_departamento, count(*)
from empleado e
group by e.codigo_departamento; /*si quiero en el select mostrar el codigo y el nombre, en el group by tambien tengo q poner esas columnas */
/*te cuenta la cantidad de empleados que hay en un departamento*/


/*select e.codigo_departamento, count(*)
from empleado e
where e.codigo_departamento is not null //*saca las filas ANTES de hacer el CALCULO
group by e.codigo_departamento;
/*having: solamente me interesa/sacame las cuentas que superen los 2 empleados/quiero filtrar los resultados del count*/
/*having count(*) >2 *//*muestra los calculos que cumplan con el having*/

/*podemos agrupar por varias columnas*/