--**********************Borrado de tablas****************************

drop table Pedido;
drop table Cliente;
drop table PedidoArticulo;
drop table ArticuloAlmacen;
drop table Almacen;
drop table Familia;
drop table Articulo;
drop table Proveedor;
drop table ArticuloProveedor;

--**********************Creacion de tablas***************************
create table Cliente(
dni char(9) primary key,
nombre varchar2(25) not null,
apellidos varchar2(25) not null,
direccion varchar2(50) not null,
codigoPostal char(5) not null,
poblacion varchar2(25) not null,
pais varchar2(25) not null,
telefono char(9) not null,
email varchar2(25),
comentarios varchar2(50),
descuento int);

create table Pedido(
codigoPedido int primary key,
codigoCliente char(9) not null,
descripcion varchar2(50) not null,
comentarios varchar2(50),
fechaEntregaEstimada date,
fechaPedido date not null,
constraint FK_Pedido_codigoCliente foreign key(codigoCliente) references Cliente(dni));

create table Proveedor(
cif char(9) primary key,
nombre varchar2(25) not null,
direccion varchar2(50) not null,
codigoPostal char(5) not null,
poblacion varchar2(25) not null,
pais varchar2(25) not null,
telefono char(9) not null,
email varchar2(25),
contacto char(9) not null,
cargo varchar(25) not null,
comentarios varchar2(50));

create table Familia(
codigoFamilia char(10) primary key,
descripcion varchar2(25) not null,
comentarios varchar2(50));

create table Almacen(
codigoAlmacen char(10) primary key,
descipcion varchar2(25) not null);

create table Articulo(
codigoArticulo char(10) primary key,
nombre varchar2(25) not null,
descripcion varchar2(25) not null,
codigoFamilia char(10) not null,
fechaCreacion date not null,
comentarios varchar2(50),
precioVenta float(5),
PrecioMedioCompra float(5),
constraint FK_Articulo_CodigoFamilia foreign key(codigoFamilia) references Familia(codigoFamilia));

create table PedidoArticulo(
codigoPedido int,
codigoArticulo char(10),
cantidad int not null,
constraint PK_PedidoArticulo_PA primary key (codigoPedido,codigoArticulo),
constraint FK_PedArticulo_codPedido foreign key(codigoPedido) references Pedido(codigoPedido),
constraint FK_PedArticulo_codArticulo foreign key(codigoArticulo) references Articulo(codigoArticulo));

create table ArticuloAlmacen(
codigoArticulo char(10),
codigoAlmacen char(10),
lote char(10),
existencia int,
ubicacion varchar(25),
constraint PK_ArticuloAlmacen_ArAlLot primary key(codigoArticulo,codigoAlmacen,lote),
constraint FK_ArticuloAlmacen_codArticulo foreign key(codigoArticulo) references Articulo(codigoArticulo),
constraint FK_ArticuloAlmacen_codAlmacen foreign key(codigoAlmacen) references Almacen(codigoAlmacen));

create table ArticuloProveedor(
codigoArticulo char(10),
codigoProveedor char(10),
fechaCompra date not null,
precioCompra float(5) not null,
constraint PK_ArticuloProv_codA_codP primary key (codigoArticulo,codigoProveedor),
constraint FK_ArticuloProv_codArt foreign key(codigoArticulo) references Articulo(codigoArticulo),
constraint FK_ArticuloProv_codProv foreign key(codigoProveedor) references Proveedor(cif));


--******************************************** Inserción de valores *********************************************************

insert into Cliente values ('11111111A','Juan','Torres','calle1','28001','Madrid','España','601225485','','',60);
insert into Cliente values ('22222222B','Blas','Marquez','calle6','14400','Pozoblanco','España','671225422','','',20);
insert into Cliente values ('33333333C','Ruben','Jurado','calle10','41000','Sevilla','España','648225413','','',30);
insert into Cliente values ('44444444D','Marta','Torres','calle13','28001','Madrid','España','685225608','','',30);
insert into Cliente values ('55555555E','Lucia','Perez','calle7','14001','Cordoba','España','603225755','','',50);
insert into Cliente values ('66666666F','Super Plus','Hernandez','calle8','14005','Cordoba','España','603225755','','',50);

insert into Pedido values(44556622,'11111111A','N','','',sysdate);
insert into Pedido values(41346617,'11111111A','P','','',sysdate);
insert into Pedido values(43016698,'22222222B','M','','',sysdate);
insert into Pedido values(42026608,'33333333C','T','','',sysdate);
insert into Pedido values(44556618,'33333333C','P','','',sysdate);

insert into Proveedor values('12345678H','Plantaciones Retuerta','C/Encrucijada nº14','14400','Pozoblanco','España','927773202','','615005678','Productor','');
insert into Proveedor values('14445678P','El cano','C/Falsa nº123','14400','Pozoblanco','España','957773302','','615005658','Transportista','');
insert into Proveedor values('13345678Z','Valenzuela','Av.Carlos 3º nº30','14405','Cordoba','España','955773202','','615005696','Productor','');
insert into Proveedor values('15545678C','Frutas Vasquez','C/ Larga nº300','28001','Madrid','España','912772202','','615005122','Productor','');

insert into Familia values('1234567890','Original','');
insert into Familia values('6666666666','Soprano','');
insert into Familia values('4568129784','Serrano','');

insert into Almacen values('1112223334','A');
insert into Almacen values('2223334445','B');
insert into Almacen values('3334445556','C');

insert into Articulo values('2020-15000','Manzanas','M','1234567890',sysdate,'',2.5,3.6);
insert into Articulo values('2020-15111','Peras','P','1234567890',sysdate,'',2.6,4);
insert into Articulo values('2020-15222','Platanos','PP','6666666666',sysdate,'',1.5,1.8);
insert into Articulo values('2020-15333','Naranjas','N','6666666666',sysdate,'',2,3.2);
insert into Articulo values('2020-15444','kiwis','K','1234567890',sysdate,'',4,5.5);

insert into PedidoArticulo values(44556622,'2020-15333',200);
insert into PedidoArticulo values(41346617,'2020-15111',250);
insert into PedidoArticulo values(43016698,'2020-15000',180);

insert into ArticuloAlmacen values('2020-15000','1112223334','456464',1000,'101211');
insert into ArticuloAlmacen values('2020-15111','2223334445','456764',200,'101211');
insert into ArticuloAlmacen values('2020-15222','1112223334','456456',400,'101211');
insert into ArticuloAlmacen values('2020-15333','3334445556','455050',0,'101211');
insert into ArticuloAlmacen values('2020-15444','3334445556','665066',500,'101211');

insert into ArticuloProveedor values('2020-15000','14445678P',sysdate,1500);
insert into ArticuloProveedor values('2020-15111','14445678P',sysdate,1500);
insert into ArticuloProveedor values('2020-15222','13345678Z',sysdate,1500);
insert into ArticuloProveedor values('2020-15333','12345678H',sysdate,1500);
insert into ArticuloProveedor values('2020-15444','15545678C',sysdate,1500);

--*************** Modificaciones en tablas ****************************************

-- Ejercicio 1. Borrar artículos que no estén en pedidos y que no tengan existencias.
delete from Articulo
where codigoArticulo not in (select codigoArticulo
                            from PedidoArticulo)
and codigoArticulo = (select codigoArticulo
                      from ArticuloAlmacen
                      where existencia = 0);

-- Borramos de ArticuloAlmacen las tuplas cuyo articulo ha sido borrado.                       
delete from ArticuloAlmacen
where codigoArticulo not in (select codigoArticulo
                            from Articulo);

--Ejercicio 2. Modificar descuento
update cliente
set descuento = 1
where dni in (select codigoCliente
              from pedido
              where codigoPedido = (select codigoPedido
                                    from PedidoArticulo p
                                    where cantidad * (select precioVenta 
                                                      from Articulo a
                                                      where a.codigoarticulo = p.codigoArticulo) between 1000 and 2000));
update cliente
set descuento = 1
where dni in (select codigoCliente
              from pedido
              where codigoPedido = (select codigoPedido
                                    from PedidoArticulo p
                                    where cantidad * (select precioVenta 
                                                      from Articulo a
                                                      where a.codigoarticulo = p.codigoArticulo) between 2000 and 4000));                                                
update cliente
set descuento = 1
where dni in (select codigoCliente
              from pedido
              where codigoPedido = (select codigoPedido
                                    from PedidoArticulo p
                                    where cantidad * (select precioVenta 
                                                      from Articulo a
                                                      where a.codigoarticulo = p.codigoArticulo) > 4000));      


-- Ejercicio 3. Dar de alta a un nuevo pedido que nos hace hoy el cliente Super Plus y que se estima que se
--entregará dentro de 2 días. El código del pedido se obtendrá incrementando en 1 el mayor código de pedido existente.
insert into Pedido values ((select max(codigoPedido)+1
                            from Pedido),
                            (select dni
                            from Cliente
                            where nombre = 'Super Plus'),
                            'descripcion','','',sysdate+2);
                            

-- Ejercicio 4
delete from Producto

delete from ArticuloAlmacen
where lote in  ('456464','456764','476456');