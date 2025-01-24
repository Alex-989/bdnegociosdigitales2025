-- Lenguaje de SQL-LMD (insert, update, delete, select - CRUD)
-- Consultas Simples

use Northwind

-- Mostrar todos los clientes, provedores, categorias,´productos, ordenes, detalle de la orden
-- empleados, con todas las columnas de datos de la empresa.

select * from Customers;
select * from Employees;
select * from Orders;
select * from Suppliers;
select * from Products;
select * from Shippers;
select * from Categories;
select * from [Order Details];


-- Proyeccion
select ProductID, ProductName, UnitPrice, UnitsInStock
from Products

-- Seleccionar o mostrar el numero de dempleado, su primer nombre,
-- su cargo, ciudad y pais.
select * from Employees;

select EmployeeID, FirstName, Title, City, Country
from Employees;


-- En base a la consulta enterior, visualizar es employeeid
-- como numero empleado, firstname como primerNombre, 
-- Title como cargo, city como ciudad, country como pais.
Select EmployeeID as 'Numero Empleado' , FirstName as primernombre
, Title as 'Cargo', City as ciudad, Country as pais
from Employees

Select EmployeeID as [Numero Empleado] , FirstName as primernombre
, Title as 'Cargo', City as ciudad, Country as pais
from Employees


-- Campos calculados
-- Seleccionar el importe de cada uno de los productos
-- vendidos en una orden
select *, (UnitPrice * Quantity) as importe 
from [Order Details];


-- Seleccionar las fechas de orden, año, mes, dia,
-- el cliente que las ordeno y el empleado que las realizo.
select OrderDate as Fecha_dela_orden
, year(OrderDate) as Año
, MONTH(OrderDate) as Mes
, day(OrderDate) as Dia
, CustomerID as Cliente,
EmployeeID as Empleado
from Orders;


-- Clausula where
-- Operadores relacionales (<, >, =, <=, >=, != o <>).
select CustomerID, CompanyName, City, Country
from Customers
where CustomerID = 'BOLID';


-- Seleccionar los clientes mostrando su identificador, nombre de la empresa,
-- contacto, ciudad y pais de alemania.

select CustomerID as numero_de_clicnte,
CompanyName as Compañia,
ContactName as Contacto,
City as Ciuadad,
Country as Pais 
from Customers
where Country = 'Germany';


-- Seleccionar todos los clientes que no sean de alemania
select CustomerID as numero_de_clicnte,
CompanyName as Compañia,
ContactName as Contacto,
City as Ciuadad,
Country as Pais 
from Customers
where Country != 'Germany';

select CustomerID as numero_de_clicnte,
CompanyName as Compañia,
ContactName as Contacto,
City as Ciuadad,
Country as Pais 
from Customers
where Country <> 'Germany';


-- Seleccionar todos los productos mostrando su nombre, categoria,
-- existencia, precio pero solamente donde su precio sea mayor a 100
-- y mostrar su costo de inventario.

select ProductName, 
CategoryID, 
UnitsInStock, 
UnitPrice, (UnitPrice * UnitsInStock) as Costo_de_inventario 
from Products
where UnitPrice > 100;


-- Seleccionar las ordenes de compra
-- Mostrando la fecha de orden, la fecha de entrega,
-- la fecha de envio, el cliente a quien se vendio de 1986.

select * from Orders;

select OrderDate, 
RequiredDate,
ShippedDate,
CustomerID
from Orders
where year(OrderDate) = '1986';
