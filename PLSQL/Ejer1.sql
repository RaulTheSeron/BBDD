--Ejercicio 1-------------------------------------------------------------------
create or replace function letradni (numero in integer) return char is
 letras char(23) := 'TRWAGMYFPDXBNJZSQVHLCKE';
 letra char;
BEGIN
 letra := SUBSTR(letras, (numero mod 23)+1, 1);
 RETURN letra;
END letradni;
/
--Ejemplos
--Mi dni: debería salir N.
select letradni(80166328) from dual;
--Deberia salir Z.
select letradni(12345678) from dual;
