-- Tareas de consultas simples
use Northwind


-- 1. Productos con categoría 1, 3 o 5
select * from Products

select ProductID as 'Número',
ProductName as 'Nombre', 
CategoryID as 'Categoria' 
from Products
where CategoryID IN (1,3,5)

-- 2. Clientes de México, Brasil o Argentina
select * from Customers

select CustomerID as 'Numero',
CompanyName as 'Compañia',
Country as 'País'
from Customers
where Country IN ('Mexico','Brazil','Argentina')


-- 3. Pedidos enviados por los transportistas 1, 2 o 3 y con flete mayor a 50
select * from Orders
select * from [Order Details]

select OrderID as [Orden], 
CustomerID as [Cliente],
ShipVia as [Transportista],
Freight as [Flete]
from Orders
where ShipVia IN (1,2,3) and Freight > 50

select OrderID as [Orden], 
CustomerID as [Cliente],
ShipVia as [Transportista],
Freight as [Flete]
from Orders
where EmployeeID IN (1,2,3) and Freight > 50


-- 4. Empleados que trabajan en Londres, Seattle o Buenos Aires
select * from Employees
select * from Orders

select EmployeeID as 'Numero',
(FirstName + ' ' + LastName) as [Nombre completo],
City as 'Ciudad'
from Employees
where City IN ('London','Seattle','Buenos Aires')

select EmployeeID,
ShipCity
from Orders
where ShipCity IN ('London','Seattle','Buenos Aires')


-- 5. Pedidos de clientes en Francia o Alemania, pero con un flete menor a 100
select * from Orders

select OrderID as 'Numero de orden',
CustomerID as 'Cliente',
ShipCountry as 'Pais',
Freight as 'Flete'
from Orders
where ShipCountry IN ('France','Germany') and 
Freight < 100

-- 6. Productos con categoría 2, 4 o 6 y que NO estén descontinuados
select * from Products

select ProductID,
ProductName,
CategoryID,
Discontinued
from Products
where CategoryID IN (2,4,6) and Discontinued = 0

-- 7. Clientes que NO son de Alemania, Reino Unido ni Canadá
select * from Customers

select CustomerID, 
CompanyName,
ContactName,
Country
from Customers
where NOT Country IN ('Germany','UK','Canada')

-- 8. Pedidos enviados por transportistas 2 o 3, pero que NO sean a USA ni Canadá
select * from Orders

select OrderID,
OrderDate,
ShipVia,
ShipCountry
from Orders
where ShipVia IN (2,3) and NOT ShipCountry IN ('USA','Canada')


-- 9. Empleados que trabajan en 'London' o 'Seattle' y fueron contratados después de 1995
SELECT * FROM Employees

SELECT EmployeeID,
FirstName,
City,
HireDate
FROM Employees
WHERE City IN ('London','Seattle') and year(HireDate) > 1995


-- 10. Productos de categorías 1, 3 o 5 con stock mayor a 50 y que NO están descontinuados
SELECT * FROM Products

SELECT ProductID, 
ProductName,
CategoryID,
UnitsInStock,
Discontinued
FROM Products
WHERE CategoryID IN (1,3,5) AND UnitsInStock > 50 AND Discontinued = 0