--Ejercicio 3------------------------------------------------------------------
--Para imprimir
set serveroutput on;

--Procedimiento
create or replace procedure empleados_2 is
  numeracion integer:=1;
  cursor empleados is select apellido,fecha_alta 
                  from empleados
                  order by fecha_alta;
begin
  for aux in empleados loop
    dbms_output.put_line(aux.apellido||' '||aux.fecha_alta);
    numeracion:= numeracion +1;
  end loop;
end empleados_2;
/
execute empleados_2;