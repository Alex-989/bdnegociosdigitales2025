# Consultas simples
## Lenguaje de SQL-LMD (insert, update, delete, select - CRUD)

- Mostrar todos los clientes, provedores, categorias,´productos, ordenes, detalle de la orden empleados, con todas las columnas de datos de la empresa.
```sql
use Northwind

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
```

- Seleccionar o mostrar el numero de dempleado, su primer nombre, su cargo, ciudad y pais.
```sql
select * from Employees;

select EmployeeID, FirstName, Title, City, Country
from Employees;
```

- En base a la consulta enterior: 
- Visualizar es employeeid como numero empleado 
- Firstname como primerNombre
- Title como cargo
- City como ciudad 
- Country como pais
```sql
Select EmployeeID as 'Numero Empleado' , FirstName as primernombre
, Title as 'Cargo', City as ciudad, Country as pais
from Employees

Select EmployeeID as [Numero Empleado] , FirstName as primernombre
, Title as 'Cargo', City as ciudad, Country as pais
from Employees
```

## Campos calculados
- Seleccionar el importe de cada uno de los productos vendidos en una orden.
```sql
select *, (UnitPrice * Quantity) as importe 
from [Order Details];
```

- Seleccionar las fechas de orden, año, mes, dia, el cliente que las ordeno y el empleado que las realizo.
```sql
select OrderDate as Fecha_dela_orden
, year(OrderDate) as Año
, MONTH(OrderDate) as Mes
, day(OrderDate) as Dia
, CustomerID as Cliente,
EmployeeID as Empleado
from Orders;
```

## Clausula where
- Operadores relacionales (<, >, =, <=, >=, != o <>).
```sql
select CustomerID, CompanyName, City, Country
from Customers
where CustomerID = 'BOLID';
```

- Seleccionar los clientes mostrando su identificador, nombre de la empresa contacto, ciudad y pais de alemania.
```sql
select CustomerID as numero_de_clicnte,
CompanyName as Compañia,
ContactName as Contacto,
City as Ciuadad,
Country as Pais 
from Customers
where Country = 'Germany';
```

- Seleccionar todos los clientes que no sean de alemania.
```sql
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
```

- Seleccionar todos los productos mostrando su nombre, categoria existencia, precio pero solamente donde su precio sea mayor a 100 y mostrar su costo de inventario.
```sql
select ProductName, 
CategoryID, 
UnitsInStock, 
UnitPrice, (UnitPrice * UnitsInStock) as Costo_de_inventario 
from Products
where UnitPrice > 100;
```

- Seleccionar las ordenes de compra Mostrando la fecha de orden, la fecha de entrega, la fecha de envio, el cliente a quien se vendio de 1986.
```sql
select * from Orders;

select OrderDate, 
RequiredDate,
ShippedDate,
CustomerID
from Orders
where year(OrderDate) = '1986';
```

- Mostrar los paises en donde se tienen clientes, mostrando pais solamente.
```sql
select distinct Country from Customers
order by country;
```

- Mostrar todas las ordenes de compra donde la cantidad de productos comprados sea mayor a 5.
```sql
select OrderID, Quantity from [Order Details]
where Quantity >= 40;
```

- Mostrar el nombre completo del empleado, su numero de empleado.
- Fecha de nacimiento, ciudad y fecha de contratacion.
- Y esta debe ser de aquellos que fueron contratados despues de 1993.
- Los resultados en sus encabezados deben ser mostrados en español.
```sql
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
```

- Mostrar los empleados que no son dirigidos por el jefe 2.
```sql
select * from Employees

select EmployeeID, ReportsTo from Employees
where ReportsTo is null

select EmployeeID, ReportsTo from Employees
where ReportsTo != 2
```

## Operadores Logicos (or, and, not)
- Seleccionar los productos que tengan un precio de entre 10 y 50.
```sql
select * from Products

select ProductName as 'Nombre', UnitPrice as 'Precio', UnitsInStock as 'Existencia' from Products
where UnitPrice >= 10 and UnitPrice <= 50
```

- Mostrar todos los pedidos realizados por clientes que no son enviados de alemania.
```sql
select * from Orders

select * from Orders
where ShipCountry != 'Germany';

-- Con operdor logico
select * from Orders
where not ShipCountry = 'Germany';
```

- Seleccionar clientes de Mexico o USA.
```sql
select * from Customers

select * from Customers
where Country = 'Mexico' or Country = 'USA'
```

- Seleccionar Empleados que nacieron entre 1955 y 1958 y que viven en londres.
```sql
select * from Employees

select * from Employees
where year(BirthDate) >= 1955 and year(BirthDate) <= 1958
and City = 'London'
```

- Seleccionar los pedidos con flete(Freight) mayor a $100 y enviados a Francia o España.
```sql
select * from Orders

select OrderID,OrderDate,ShipCountry,Freight from Orders
where Freight > 100 and (ShipCountry = 'France' or ShipCountry = 'Spain')
```

- Seleccionar las ordenes de compra top 5.
```sql
select * from Orders

select top 5* from Orders
```

- Seleccionar los productos con precio entre $10 y $50, que no esten descontinuados y tengan mas de 20 unidades en stock.
```sql
select * from Products

select * from Products
where (UnitPrice >= 10 and UnitPrice <= 50) and Discontinued = 0 and UnitsInStock >20
```

- Clientes que no sean de Mexico o USA y que tengan fax registrado.
```sql
select * from Customers

select CompanyName, Country, City, Fax from Customers
where (Country != 'Mexico' and Country != 'Usa') and Fax is not null

select CompanyName, Country, City, Fax from Customers
where not(Country = 'Mexico' or Country = 'Usa') and Fax is not null
```

- Pedidos enviados a Francia o Alemania, pero con un flete menor a 50.
```sql
select * from Orders

select OrderID, ShipCountry, Freight from Orders
where (ShipCountry = 'France' or ShipCountry = 'Germany') and Freight < 50
```

## Resolver
- Seleccionar pedidos con un flete mayor a $100.
- Enviados a Brasil o Argentina.
- Pero no enviados por el transportista 1.
```sql
select * from Orders

select * from Orders
where Freight > 100 and ShipCountry = 'Brazil'
```

- Seleccionr empleados que no viven en Londres o Seattle y que fueron contratados despues de 1995.
```sql
select concat(FirstName, ' ' , LastName) as 'Nombre Completo', HireDate,
City, Country 
from Employees
where NOT(city = 'London' or City = 'Seattle') and year(HireDate) >= 1992


select concat(FirstName, ' ' , LastName) as 'Nombre Completo', HireDate,
City, Country 
from Employees
where City <> 'London' and City <> 'Seattle' and year(HireDate) >= 1992
```

## Clausula IN (or)
-Seleccionar los productos con categora de 1, 3 0 5.
```sql
select ProductName, CategoryID, UnitPrice from Products
where CategoryID = 1 or CategoryID = 3 or CategoryID = 5

select ProductName, CategoryID, UnitPrice from Products
where CategoryID in (1,3,5)
```

- Seleccionar todas las ordenes de la region RJ, Tachira y que no tengan region asignada.
```sql
select OrderID, ShipRegion from Orders
where ShipRegion in ('RJ','Táchira') or ShipRegion is null
```

- Seleccionar lar ordenes que tengan cantidades de 12, 9 o 40 y descuento de 0.15 o 0.05.
```sql
select * from [Order Details]

select * from [Order Details]
where Quantity in (12, 9, 40) and Discount in (0.15, 0.05)
```

## Clausula Between (Siempre va en el where)

### Sintaxis --> between valor inicial and valorfinal

- Mostrar los productos con precio entre 10 y 50.
```sql
SELECT * FROM Products
WHERE UnitPrice >= 10 AND UnitPrice<=50

SELECT * FROM Products
WHERE UnitPrice BETWEEN 10 AND 50
```

- SELECCIONAR TODOS LOS PEDIDOS REALIZADOS ENTRE EL PRIMERO DE ENERO Y EL 30 DE JUNIO DE 1997.
```sql
SELECT * FROM Orders

SELECT OrderID AS 'Numero', 
CustomerID AS 'Cliente', 
OrderDate AS [Fecha del pedido]
FROM Orders
WHERE (MONTH(OrderDate) BETWEEN 01 AND 06) AND DAY(OrderDate) BETWEEN 01 AND 30
AND YEAR(OrderDate) = 1997

SELECT OrderID AS 'Numero', 
CustomerID AS 'Cliente', 
OrderDate AS [Fecha del pedido]
FROM Orders
WHERE OrderDate BETWEEN '1997-01-01' AND '1997-30-06'
```

- SELECCIONAR TODOS LOS EMPLEADOS CONTRATADOS ENTRE 1992 Y 1994 QUE TRABAJAN EN LONDRES.
```sql
SELECT * FROM Employees

SELECT EmployeeID AS 'Numero', 
FirstName AS 'Nombre',
HireDate AS 'Contratacion',
City AS 'Ciudad'
FROM Employees
WHERE (YEAR(HireDate) BETWEEN 1992 AND 1994) AND City = 'London'
```

- PEDIDOS CON FLETE (FREIGHT) ENTRE 50 Y 200 ENVIADOS A ALEMANIA Y A FRANCIA.
```sql
SELECT OrderID AS 'Numero de orden',
OrderDate AS 'Fecha de orden',
RequiredDate AS 'Fecha de entrega',
Freight AS 'Peso',
ShipCountry AS 'Pais de entrega'
FROM Orders
WHERE Freight BETWEEN 50 AND 200
AND ShipCountry IN ('France','Gernamy')
```

- Seleccionar todos los productos que tengan un precio de entre 5 y 20 dolares y que sean de la categoria 1,2 o 3.
```sql
SELECT * FROM Products

SELECT ProductID AS 'Numero de producto',
ProductName AS 'Nombre del producto',
UnitPrice AS 'Precio por unidad',
CategoryID AS 'Categoria'
FROM Products
WHERE UnitPrice BETWEEN 5 AND 20 AND CategoryID IN (1,2,3)
```

- Selecciona los empleados con el numero de trabajador entre 3 y 7 que no trabajan en londres ni seattle.
```sql
SELECT * FROM Employees

SELECT EmployeeID AS 'Numero de empleado',
(FirstName + ' ' + LastName) AS 'Nombre completo',
City AS 'Ciudad'
FROM Employees
WHERE (EmployeeID BETWEEN 3 AND 7) AND NOT City IN ('London','Seattle')
```

## Clausula Like
### Patrones:
	-- 1) % (Porcentaje) -> Representa cero o mas caracteres en el patron de busqueda.
	-- 2) _ (Guin bajo) -> Representa exactamente un caracter en el patron de busqueda.
	-- 3) [] (Corchetes) -> Se utiliza para definir un conjunto de caracteres, buscando
	-- cualquiera de ellos en la posicion especifica.
	-- 4) ^ (Potencia) -> Se utiliza para buscar caracteres que no estan dentro del 
	-- conjunto especifico.


- Buscar los productos que comienzan con C.
```sql
SELECT * FROM Products
WHERE ProductName LIKE 'C%'

SELECT * FROM Products
WHERE ProductName LIKE 'Cha%'
AND UnitPrice = 18
```

- Buscar todos los productos que terminen con E.
```sql
SELECT * FROM Products
WHERE ProductName LIKE '%E'
```

- Seleccionar todos los clientes cuyo nombre de empresa contiene las palabra "CO" en cualquier parte.
```sql
SELECT * FROM Customers
WHERE CompanyName LIKE '%CO%'
```

- Seleccionar los empleados cuyo nombre comience con "A" y tenga exactamente 5 caracteres.
```sql
SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'A_____'
```

- Seleccionar los productos que comiencen con A o B.
```sql
SELECT * FROM Products
where ProductName like '[ABC]%'

-- Rango de A hacia M
SELECT * FROM Products
where ProductName like '[A-M]%'
```

- Seleccionar todos los productos que no comiencen con A o B.
```sql
SELECT * FROM Products
where ProductName like '[^AB]%'
```

- Seleccionar todos los productos donde el nombre comience con A pero que no contenga la E.
```sql
SELECT * FROM Products
WHERE ProductName LIKE 'A[^E]%'
```

## Clausula Order by (Acendente)
```sql
SELECT ProductID, ProductName, UnitPrice, UnitsInStock 
FROM Products
ORDER BY UnitPrice ASC


-- Descendente
SELECT ProductID, ProductName, UnitPrice, UnitsInStock 
FROM Products
ORDER BY UnitPrice DESC


SELECT ProductID, ProductName, UnitPrice, UnitsInStock 
FROM Products
ORDER BY 3 DESC


SELECT ProductID, ProductName, UnitPrice AS 'Precio', UnitsInStock 
FROM Products
ORDER BY 'Precio' DESC
```

- Seleccionar los clientes ordenados por el pais y dentro por ciudad.
```sql
SELECT * FROM Customers

SELECT CustomerID, Country, City FROM Customers
ORDER BY Country ASC, City ASC

SELECT CustomerID, Country, City FROM Customers
ORDER BY Country ASC, City DESC

SELECT CustomerID, Country, City 
FROM Customers
WHERE Country IN ('Brazil')
ORDER BY Country ASC, City DESC

SELECT CustomerID, Country, City 
FROM Customers
WHERE Country IN ('Brazil', 'Germany')
ORDER BY Country ASC, City DESC

SELECT CustomerID, Country, City 
FROM Customers
WHERE (Country = 'Brazil' OR Country = 'Germany')
AND region is NOT NULL
ORDER BY Country ASC, City DESC
```