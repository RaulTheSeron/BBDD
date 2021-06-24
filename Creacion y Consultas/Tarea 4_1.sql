-- Ej 1: Nombre de todos los fabricantes.
select nombre
from fabricantes;

-- Ej 2: Nombre de todos los productos.
select nombre 
from productos;

-- Ej 3: Nombre y precio de todos los productos.
select nombre, precio
from productos;

-- Ej 4: Nombre de los productos con un precio menor o igual a 200 �.
select nombre
from productos
where precio <= 200;

-- Ej 5: Productos con un precio entre 60 � y 120 � (ambos incluidos).
select * 
from productos
where precio between 60 and 120;

-- Ej 6: Nombre y el precio en c�ntimos.
select nombre, precio * 100 "Precio en centimos"
from productos;

-- Ej 7: Precio promedio de todos los productos.
select avg(precio)
from productos;

-- Ej 8: Precio promedio de todos los productos con c�digo de fabricante igual a 2. 
select avg(precio)
from productos
where fabricante = 2;

-- Ej 9: Cantidad de productos con un precio mayor o igual a 180 �.
select count(*)
from productos
where precio >= 180;

-- Ej 10: C�digo del fabricante del producto 'Monitor'.
select c�digo
from fabricantes
where c�digo = (select fabricante
                from productos
                where nombre = 'Monitor');
                
-- Como sabemos el atributo fabricante de productos se refiere al c�digo del 
-- fabricante, podr�amos hacer m�s r�pido lo siguiente: 
select fabricante
from productos
where nombre = 'Monitor';
                
-- Ej 11: Nombre y el precio de todos los productos con un precio mayor o igual 
-- a 180 �, ordenados primero por precio en orden descendente y luego por nombre
-- en orden ascendente.
select nombre, precio
from productos
where precio >= 180
order by precio desc, nombre asc;

-- Ej 12: Datos de los productos, incluidos los datos del fabricante para cada producto.
select p.nombre "PRODUCTO",p.c�digo ,p.precio, f.nombre "FABRICANTE", p.fabricante "COD_FABRICANTE"
from productos p join fabricantes f
on p.fabricante = f.c�digo
order by p.nombre;


-- Ej 13: Nombre del producto, el precio y el nombre del fabricante de todos los productos.
select p.nombre "Producto", p.precio, f.nombre "Nombre fabricante"
from productos p join fabricantes f
on p.fabricante = f.c�digo;

-- Ej 14: Nombre del fabricante del producto con c�digo 7.
select nombre
from fabricantes
where c�digo = (select fabricante
                from productos
                where c�digo = 7);
                
-- Ej 15: Selecciona el nombre y el precio de los productos del fabricante 'Winchester'.
select nombre, precio
from productos
where fabricante = (select c�digo
                    from fabricantes
                    where nombre = 'Winchester');

-- Ej 16: Nombre y el precio del producto m�s barato.
select nombre, precio
from productos
where precio = (select min(precio)
                from productos);

-- Ej 17: Precio promedio de los productos de cada fabricante, mostrando solo el c�digo del fabricante.
select f.c�digo "C�digo fabricante", avg(p.precio) "Precio medio"
from fabricantes f join productos p
on f.c�digo = p.fabricante
group by f.c�digo
order by 1;

-- Ej 18: Precio promedio de los productos de cada fabricante, mostrando el nombre del fabricante.
select f.nombre "Fabricante", avg(p.precio) "Precio medio"
from fabricantes f join productos p
on f.c�digo = p.fabricante
group by f.nombre;

-- Ej 19: Nombres de los fabricantes cuyos productos tienen un precio promedio mayor o igual a 150 �.
select nombre
from fabricantes
where c�digo in (select fabricante
                from productos
                group by fabricante
                having avg(precio)>=150);


-- Ej 20: Selecciona el nombre de cada fabricante junto con el nombre y el precio de su producto m�s caro.
select f.nombre "Fabricante", p.nombre "Producto", p.precio
from fabricantes f join productos p
on f.c�digo = p.fabricante
and p.precio in (select max(precio)
                from productos
                group by fabricante)
order by f.c�digo;
