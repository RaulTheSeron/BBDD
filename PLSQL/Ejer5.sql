create or replace function exteldirec (numero_emp in temple.numem%type) return number
  is
  numero_extensiones number := 0;
  empleado number;
  emp_no_direc exception;
  emp_no_existe exception;

begin     
  select numem into empleado
  from temple
  where numem = numero_emp;

  select count(distinct extel) into numero_extensiones
  from temple
  where numde in (select numde
                 from tdepto
                 where direc = numero_emp);       
                 
  if numero_extensiones = 0  then
    raise emp_no_direc;
  end if;
                
  return (numero_extensiones);
  
exception
  when no_data_found then
    raise_application_error(-20093,'Empleado inexistente');
  when emp_no_direc then
    raise_application_error(-20094,'El empleado no es director');
END exteldirec;
/

--Ejemplos:
--Correcto: el empleado 150 dirige dos departamentos(120 y 121) con 4 extensiones.
select exteldirec(150) from dual;
--Error: el empleado no existe.
select exteldirec(151) from dual;
--Error: el empleado no es director.
select exteldirec(120) from dual;




 
  

