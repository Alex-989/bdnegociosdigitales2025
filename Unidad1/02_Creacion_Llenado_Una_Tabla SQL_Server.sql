-- creacion de la base de datos

-- crea la base de datos
create database tienda1;

-- utilizar una base de datos
use tienda1;

-- SQL LDD
-- crear tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key(categoriaid),
constraint unico_nombre
unique(nombre)
);


-- SQL-LMD
-- Agregar registros a la tabla categoria

INSERT INTO categoria(categoriaid,nombre)
values (1,'Carnes Frias');

insert into categoria(categoriaid,nombre)
values (2,'Linea Blanca');

insert into categoria(nombre,categoriaid)
values ('Vinos y licores',3);

insert into categoria
values (4, 'Ropa'),
	   (5, 'Dulces'),
       (6, 'Lacteos');
       
insert into categoria(nombre,categoriaid)
values ('Panaderia',7),
	   ('Zapateria',8),
       ('Jugueteria',9);
       
       
INSERT INTO categoria
values(7,'Panaderia');
       
select * from categoria;



-- Tabla productos
create table producto1(
  productoid int not null,
  nombreProducto varchar(20) not null,
  descripcion varchar(80) null,
  precio decimal(10,2) not null,
  existencia int not null,
  categoriaid int null,
  constraint pk_producto1
  primary key (productoid),
  constraint unico_descripcion
  unique(nombreProducto),
  constraint chk_precio
  check(precio>0.0 and precio<=1000),
  constraint chk_existencia
  check(existencia>0 and existencia<=200),
  constraint fk_categoria_producto1
  foreign key (categoriaid)
  references categoria(categoriaid)
);

insert into producto1
values(1, 'Miguelito', 'Dulce sano para la lombriz', 34.5, 45, 5);

insert into producto1
values(2, 'tupsi pop', 'Dulce re-sano para el diente', 1000, 200, 5);

insert into producto1
values(3, 'Plancha', 'plancha facil el suit', 256.3, 134, 2);

select * from producto1
where categoriaid=5;

select * from categoria;


create table cliente(
clienteid int not null auto_increment,
codigocliente varchar(15) not null,
nombre varchar(30) not null,
direccion varchar(100) not null,
telefono varchar(19),
constraint pk_cliente
primary key(clienteid),
constraint unico_codigocliente
unique (codigocliente)
);


CREATE TABLE detalleorden(
ordenfk int not null,
productofk int not null,
preciocompra decimal(10,2) not null,
cantidad int not null,
constraint pk_detalleorden
primary key(ordenfk,productofk),
constraint chk_preciocompra
check(preciocompra>0.0 and preciocompra<=2000),
constraint chk_cantidad
check(cantidad>0),
constraint fk_detalleorden_producto
foreign key(productofk)
references producto1(productoid)
);



CREATE TABLE ordencompra (
ordenid int not null identity,
fechacompra date not null,
cliente int not null,
constraint pk_ordencompra
primary key(ordenid),
constraint fk_ordencompra_cliente
foreign key (cliente)
references cliente(clienteid)
);



ALTER TABLE detalleorden
add constraint fk_detalleorden_ordencompra
foreign key (ordenfk)
references ordencompra(ordenid)