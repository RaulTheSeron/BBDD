--Ejercicio 2-------------------------------------------------------------------
--Creacion de tabla
create table empleados(
emp_no number(3) primary key,
apellido varchar2(15),
departarmento number(3),
salario float,
oficio varchar2(20),
fecha_alta date);

--Insercion de valores
insert into empleados
values(111,'Serrano Torres',10,1500,'Programador','11/03/2015');
insert into empleados
values(110,'Perez Robleda',20,1500,'Programador','25/12/2014');
insert into empleados
values(109,'Vidal Gil',20,1700,'Programador','01/07/2013');
insert into empleados
values(108,'Baena Carmona',30,2200,'Supervisor','05/06/2012');

--Para imprimir
set serveroutput on;

--Cracion de procedimiento
create or replace procedure empleados_1 is
  numeracion integer:=1;
  cursor lista is select apellido from empleados where departarmento = 20;
begin
  for aux in lista loop
    dbms_output.put_line(numeracion||' '||aux.apellido);
    numeracion:= numeracion +1;
  end loop;
end empleados_1;
/

execute empleados_1;