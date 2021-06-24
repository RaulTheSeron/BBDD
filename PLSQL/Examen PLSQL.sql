--Ejercicio 1: Procedimiento que imprima en pantalla todos los n�meros del 0 al 99 excepto el 3, el 6 y el 11.
-------------------------------------------------------------------------------------------------------------------------------

--Para imprimir
set serveroutput on;

--Procedimiento
create or replace procedure contar is
begin
    for aux in 0 .. 99 loop
        if(aux not in (3,6,11)) then
            dbms_output.put_line(aux);    
        end if;
    end loop;
end contar;
/

--Ejecucion del procedimiento
execute contar;

-------------------------------------------------------------------------------------------------------------------------------
-- Ejercicio 2 : Procedimiento que modifica el precio de un producto pas�ndole como par�metros el c�digo y el nuevo precio. El
-- procedimiento comprobar� que la variaci�n de precio no supere el 20 por 100.
-------------------------------------------------------------------------------------------------------------------------------

-- Tabla.
CREATE TABLE productos (
 c�digo INTEGER,
 t�tulo VARCHAR(50),
 descripci�n VARCHAR(300),
 precio NUMERIC(5,2),
 CONSTRAINT PK_Producto PRIMARY KEY (c�digo) );

-- Inserts.
INSERT INTO productos VALUES (1, 'Disco duro', '2 TB y USB 3.1', 100.00);
INSERT INTO productos VALUES (2, 'Camisa', 'Hawaina de cuatro botones', 10.00);
INSERT INTO productos VALUES (3, 'Videojuego', 'Mario Kart 8 Deluxe', 50.00);

--Funcion
create or replace procedure cambio_precio(codigo_p in productos.c�digo%type,nuevo_precio in productos.precio%type) is
    cambio_demasiado_grande exception;
    precio_antiguo productos.precio%type;
begin
    select precio into precio_antiguo from productos where c�digo = codigo_p;
    
    if(nuevo_precio between (precio_antiguo*0.8) and (precio_antiguo*1.2)) then
        update productos
        set precio = nuevo_precio
        where c�digo = codigo_p;
        dbms_output.put_line('Cambios realizados correctamente');
    else
        raise cambio_demasiado_grande;
    end if;
exception
    when cambio_demasiado_grande then
        dbms_output.put_line('El nuevo precio introducido varia en m�s del 20% del antiguo precio');
end cambio_precio;
/

--Ejecucion del procedimiento: Fallo, aumento demasiado grande.
execute cambio_precio(1,130);
-- Fallo, disminucion demasiado grande.
execute cambio_precio(1,70);
-- Correcto.
execute cambio_precio(1,110);
--Comprobacion del cambio
select c�digo,precio
from productos
where c�digo=1;

-------------------------------------------------------------------------------------------------------------------------------
-- Ejercicio 3:  Procedimiento que recibe un c�digo de empleado y una cadena de caracteres correspondiente a su nuevo oficio. 
-- El procedimiento debe localizar al empleado, modificar su oficio en la tabla y visualizar en consola los cambios realizados.
-------------------------------------------------------------------------------------------------------------------------------

-- Tabla.
CREATE TABLE empleados (
 c�digo INTEGER,
 apellidos VARCHAR(50),
 nombre VARCHAR(50),
 oficio VARCHAR(20),
 aumento INTEGER,
 CONSTRAINT PK_Empleado PRIMARY KEY (c�digo) );

-- Inserts.
INSERT INTO empleados VALUES (1, 'Ma�as Rojo', 'Marcos', 'Abogado', 500);
INSERT INTO empleados VALUES (2, 'Carretero Izaguirre', 'M�nica', 'Periodista', 550);
INSERT INTO empleados VALUES (3, 'Miguel Robles', 'Jos� Luis', 'Alba�il', 600);

-- Procedimiento
create or replace procedure cambio_oficio(codigo_emp in empleados.c�digo%type, nuevo_oficio empleados.oficio%type) is
    aux varchar(20);
begin
    select oficio into aux
    from empleados
    where c�digo = codigo_emp;

    update empleados
    set oficio = nuevo_oficio
    where c�digo = codigo_emp;

    dbms_output.put_line('El empleado '||codigo_emp||' pasa de '||aux||' a '||nuevo_oficio);
    
exception
    when no_data_found then
        dbms_output.put_line('El empleado con codigo '||codigo_emp||' no existe');
end cambio_oficio;
/

-- Ejecucion erronea
execute cambio_oficio(7,'Programador');
-- Ejecucion correcta
execute cambio_oficio(1,'Programador');
--Comprobacion
select c�digo, oficio
from empleados
where c�digo = 1;

-------------------------------------------------------------------------------------------------------------------------------
-- Ejercicio 4: Procedimiento que actualiza el aumento de salario de cada empleado increment�ndoloen 300 �. 
-------------------------------------------------------------------------------------------------------------------------------

--Procedimiento
create or replace procedure aumento_salario is
    cursor lista is select * from empleados;
begin
    for aux in lista loop
        update empleados
        set aumento = aumento + 300
        where c�digo = aux.c�digo;
    end loop;
end aumento_salario;
/

--Ejecucion de procedimiento
execute aumento_salario;
--Comprobacion
select c�digo,aumento
from empleados;


-------------------------------------------------------------------------------------------------------------------------------
-- Ejercicio 5: Disparador (trigger): antes de actualizar a un empleado compruebe que su aumento es mayor o igual que 500; si no
-- es as�, lanzar� una excepci�n 
-------------------------------------------------------------------------------------------------------------------------------
create or replace trigger check_aumento
    before update of aumento on empleados for each row
begin
    if (:new.aumento-500) >= :old.aumento then
        update empleados
        set aumento = :new.aumento
        where c�digo = :old.c�digo;
    else
        raise_application_error(-20093,'El nuevo aumento no es suficientemente alto');
    end if;       
end;
/

--Comprobacion
select c�digo,aumento
from empleados;

--Update : fallo
update empleados
set aumento = 900
where c�digo = 1;

--Update : correcto 
update empleados
set aumento = 1700
where c�digo = 3;