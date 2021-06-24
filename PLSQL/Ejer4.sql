--Ejercicio 4-------------------------------------------------------------------
create or replace procedure dirsenior (departamento number) is
  emp_mas_antiguo number;
  dept_vacio exception;
begin
  select numem into emp_mas_antiguo
  from temple t 
  where numde = departamento
  and fecin = (select min(fecin)
              from temple
              where numde = departamento);
  if emp_mas_antiguo is null then
    raise dept_vacio;
  else
    update tdepto
    set direc = emp_mas_antiguo where numde = departamento;
  end if;
exception
  when NO_DATA_FOUND then
    raise_application_error(-20091,'Departamento inexistente');
  when dept_vacio then
    raise_application_error(-20092,'Departamento sin empleados');
end;
/

-- Ejemplo;
execute dirsenior(112);
-- Ahora el director de ese departamento deberia ser el 130
-- Consulta para comprobar:
select direc
from tdepto
where numde = 112;

