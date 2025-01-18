# creacion de la base de datos

# crea la base de datos
create database tienda1;

# utilizar una base de datos
use tienda1;

# SQL LDD
# crear tabla categoria
create table categoria(
categoriaid int not null,
nombre varchar(20) not null,
constraint pk_categoria
primary key(categoriaid),
constraint unico_nombre
unique(nombre)
);


# SQL-LMD
# Agregar registros a la tabla categoria

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