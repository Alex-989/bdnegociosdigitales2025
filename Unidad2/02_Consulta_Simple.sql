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



-- Mostrar los paises en donde se tienen clientes, mostrando
-- pais solamente

select distinct Country from Customers
order by country;


-- Mostrar todas las ordenes de compra donde la cantidad de 
--productos comprados sea mayor a 5.

select OrderID, Quantity from [Order Details]
where Quantity >= 40;


-- Mostrar el nombre completo del empleado, su numero de 
-- empleado, fecha de nacimiento, ciudad y fecha de contratacion
-- y esta debe ser de aquellos que fueron contratados despues de
-- 1993.
-- Los resultados en sus encabezados deben ser mostrados en
-- español.
select 
FirstName as Nombre,
LastName as Apellido, 
EmployeeID as [Numero de empleado], 
BirthDate as [Fecha de nacimiento],
City as Ciudad, 
HireDate as [Fecha de contratacion] 
from Employees
where year(HireDate)>1993;


-- Concatenacion
select 
(FirstName +  '  '  + LastName) as [Nombre completo] , 
EmployeeID as [Numero de empleado], 
BirthDate as [Fecha de nacimiento],
City as Ciudad, 
HireDate as [Fecha de contratacion] 
from Employees
where year(HireDate)>1993;

-- Segunda forma.
select 
concat(FirstName,   '',  + LastName, '  ' ) as [Nombre completo] , 
EmployeeID as [Numero de empleado], 
BirthDate as [Fecha de nacimiento],
City as Ciudad, 
HireDate as [Fecha de contratacion] 
from Employees
where year(HireDate)>1993;



-- Mostrar los empleados que no son dirigidos por el jefe 2.
select * from Employees

select EmployeeID, ReportsTo from Employees
where ReportsTo is null

select EmployeeID, ReportsTo from Employees
where ReportsTo != 2



-- Operadores Logicos (or, and, not)
-- Seleccionar los productos que tengan un precio de entre 10 y 50
select * from Products

select ProductName as 'Nombre', UnitPrice as 'Precio', UnitsInStock as 'Existencia' from Products
where UnitPrice >= 10 and UnitPrice <= 50


-- Mostrar todos los pedidos realizados por clientes 
-- que no son enviados de alemania.
select * from Orders

select * from Orders
where ShipCountry != 'Germany';

-- Con operdor logico
select * from Orders
where not ShipCountry = 'Germany';



-- Seleccionar cliented de Mexico o USA
select * from Customers

select * from Customers
where Country = 'Mexico' or Country = 'USA'



-- Seleccionar Empleados que nacieron entre 1955 y 1958 y
-- que viven en londres
select * from Employees

select * from Employees
where year(BirthDate) >= 1955 and year(BirthDate) <= 1958
and City = 'London'


-- Seleccionar los pedidos con flete(Freight) mayor a $100
-- y enviados a Francia o España
select * from Orders

select OrderID,OrderDate,ShipCountry,Freight from Orders
where Freight > 100 and (ShipCountry = 'France' or ShipCountry = 'Spain')



-- Seleccionar las ordenes de compra top 5
select * from Orders

select top 5* from Orders



-- Seleccionar los productos con precio entre $10 y $50,
-- que no esten descontinuados y tengan mas de 20 unidades en stock
select * from Products

select * from Products
where (UnitPrice >= 10 and UnitPrice <= 50) and Discontinued = 0 and UnitsInStock >20



-- Clientes que no sean de Mexico o USA y que tengan fax registrado
select * from Customers

select CompanyName, Country, City, Fax from Customers
where (Country != 'Mexico' and Country != 'Usa') and Fax is not null

select CompanyName, Country, City, Fax from Customers
where not(Country = 'Mexico' or Country = 'Usa') and Fax is not null



-- Pedidos enviados a Francia o Alemania,
-- pero con un flete menor a 50
select * from Orders

select OrderID, ShipCountry, Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight < 50



-- Resolver
-- Seleccionar pedidos con un flete mayor a $100,
-- enviados a Brasil o Argentina,
-- pero no enviados por el transportista 1
select * from Orders

select * from Orders
where Freight > 100 and ShipCountry = 'Brazil'



-- Seleccionr empleados que no viven en Londres o Seattle
-- y que fueron contratados despues de 1995

select concat(FirstName, ' ' , LastName) as 'Nombre Completo', HireDate,
City, Country 
from Employees
where NOT(city = 'London' or City = 'Seattle') and year(HireDate) >= 1992


select concat(FirstName, ' ' , LastName) as 'Nombre Completo', HireDate,
City, Country 
from Employees
where City <> 'London' and City <> 'Seattle' and year(HireDate) >= 1992



-- Clausula IN (or)
--Seleccionar los productos con categora de 1, 3 0 5
select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5

select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1,3,5)


-- Seleccionar todas las ordenes de la region RJ, Tachira y que
-- no tengan region asignada
select OrderID, ShipRegion from Orders
where ShipRegion in ('RJ','Táchira') or ShipRegion is null


-- Seleccionar lar ordenes que tengan cantidades de 12, 9 o 40
-- y descuento de 0.15 o 0.05.
select * from [Order Details]

select * from [Order Details]
where Quantity in (12, 9, 40) and Discount in (0.15, 0.05)


-- Clausula Between