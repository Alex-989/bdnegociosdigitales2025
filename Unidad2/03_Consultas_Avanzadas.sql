use Northwind

-- Seleccionar todas las categorias y productos

SELECT * FROM
Categories 
INNER JOIN
Products
ON categories.CategoryID = products.CategoryID;

SELECT categories.CategoryID,CategoryName, ProductName, UnitsInStock, UnitPrice FROM
Categories 
INNER JOIN
Products
ON categories.CategoryID = products.CategoryID;


SELECT C.CategoryID AS [Numero de categoria],
CategoryName AS 'Nombre de categoria',
ProductName AS 'Nombre de producto',
UnitsInStock AS 'Existencia',
UnitPrice AS Precio
FROM
Categories AS C
INNER JOIN
Products AS P
ON C.CategoryID = P.CategoryID;


-- Seleccionar los productos de las categorias beverages y condiments donde
-- la existencia este entre 18 y 30.
SELECT *
FROM
Products AS P
JOIN Categories AS CA
ON P.CategoryID = CA.CategoryID
WHERE CA.CategoryName IN ('beverages','condiments')

SELECT *
FROM
Products AS P
JOIN Categories AS CA
ON P.CategoryID = CA.CategoryID
WHERE CA.CategoryName = 'beverages' OR CA.CategoryName = 'condiments'

SELECT *
FROM
Products AS P
JOIN Categories AS CA
ON P.CategoryID = CA.CategoryID
WHERE (CA.CategoryName = 'beverages' OR CA.CategoryName = 'condiments')
AND P.UnitsInStock>=18 AND P.UnitsInStock<=30


SELECT *
FROM
Products AS P
JOIN Categories AS CA
ON P.CategoryID = CA.CategoryID
WHERE (CA.CategoryName = 'beverages' OR CA.CategoryName = 'condiments')
AND P.UnitsInStock BETWEEN 18 AND 30


-- Seleccionar los productos y sus importes realizados de marzo a junio de
-- 1996, mostrando la fecha de la orden, el id del del producto y el importe
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT O.OrderID, 
O.OrderDate, 
OD.ProductID,
(OD.UnitPrice * OD.Quantity) AS IMPORTE
FROM
Orders AS O
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
WHERE O.OrderDate BETWEEN '1996-01-07' AND '1996-30-10'


-- Mostrar el importe total de ventas de la consulta anterior.
SELECT CONCAT('$',' ',SUM(OD.Quantity * OD.UnitPrice)) AS Importe
FROM
Orders AS O
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
WHERE O.OrderDate BETWEEN '1996-01-07' AND '1996-30-10'


-- Consultas basicas con INER JOIN
-- 1. Obtener los nombres de los clientes y los paises a los que enviaron sus pedidos
SELECT ORD.CustomerID, ORD.ShipCountry
FROM
Orders AS ORD

SELECT ORD.CustomerID, ORD.ShipCountry
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID

SELECT ORD.CustomerID, ORD.ShipCountry
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID
ORDER BY 2 DESC

SELECT ORD.CustomerID, ORD.ShipCountry
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID
ORDER BY ORD.ShipCountry DESC

SELECT ORD.CustomerID, ORD.ShipCountry
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID
ORDER BY 2 DESC


-- 2. Obtener los productos y sus respectivos proveedores
SELECT ProductName, SUP.SupplierID
FROM
Products AS PRO
INNER JOIN Suppliers AS SUP
ON PRO.SupplierID = SUP.SupplierID

SELECT ProductName, SUP.SupplierID
FROM
Suppliers AS SUP
INNER JOIN Products AS PRO
ON PRO.SupplierID = SUP.SupplierID

-- 3. Obtener los pedidos y los empleados que los gestionaron
SELECT *
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID

-- 4. Listar los productos juntos con sus precios y la categoria a la que pertenecen.
SELECT ProductName, UnitPrice, CategoryID
FROM
Products

SELECT ProductName, UnitPrice, CategoryName
FROM 
Products AS PRO
INNER JOIN
Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID


-- 5. Obtener el nombre del cliente, el numero de orden y fecha de orden.
SELECT CUS.CompanyName, ORD.OrderID, OrderDate
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID

--6. Listar las ordenes mostrando el numero de orden, el nombre del producto y
-- la cantidad que se vendio.
SELECT ORDE.OrderID, PRO.ProductName, ORDE.Quantity
FROM 
Products AS PRO
INNER JOIN [Order Details] AS ORDE
ON PRO.ProductID = ORDE.ProductID

SELECT ORDE.OrderID, PRO.ProductName, ORDE.Quantity
FROM 
Products AS PRO
INNER JOIN [Order Details] AS ORDE
ON PRO.ProductID = ORDE.ProductID
ORDER BY ORDE.Quantity DESC

SELECT ORDE.OrderID, PRO.ProductName, ORDE.Quantity
FROM 
Products AS PRO
INNER JOIN [Order Details] AS ORDE
ON PRO.ProductID = ORDE.ProductID
WHERE ORDE.OrderID = 11031
ORDER BY ORDE.Quantity DESC


SELECT OD.OrderID
FROM 
[Order Details] AS OD
INNER JOIN Products AS P
ON OD.ProductID = P.ProductID
GROUP BY OD.OrderID
ORDER BY OD.OrderID DESC


-- 7. Obtener los empleados y sus respectivos jefes
SELECT CONCAT(E1.FirstName, ' ', E1.LastName) AS [Empleado],
CONCAT(J1.FirstName, ' ', J1.LastName) AS [Jefe]
FROM Employees AS E1
INNER JOIN Employees AS J1
ON E1.ReportsTo = J1.EmployeeID

SELECT FirstName, ReportsTo FROM Employees

-- 8. Listar los pedidos y el nombre de la empresa de transporte utilizada
SELECT * FROM Orders
SELECT * FROM Shippers

SELECT OrderID, SHI.CompanyName AS Transportista
FROM
Orders AS ORD
INNER JOIN Shippers AS SHI
ON SHI.ShipperID = ORD.ShipVia
ORDER BY 1 ASC



-- Consultas INNER JOIN INTERMEDIAS

-- 9. Obtener la cantidad total de productos vendidos por categoria
SELECT SUM(Quantity) 
FROM 
[Order Details]

SELECT CAT.CategoryName AS 'Nombre de categoria', SUM(Quantity) AS 'Productos vendidos'
FROM
Categories AS CAT
INNER JOIN Products AS PRO
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
GROUP BY CAT.CategoryName
ORDER BY CAT.CategoryName


-- 10. Obtener el total de ventas por empleado.
SELECT * FROM Employees
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT EM.EmployeeID ,COUNT(OrderID) AS 'Total de ventas'
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID
GROUP BY EM.EmployeeID


SELECT CONCAT(E.FirstName, ' ', E.LastName) AS Nombre,
CONCAT('$',' ',SUM((OD.Quantity * OD.UnitPrice) - (OD.Quantity * OD.UnitPrice) * OD.Discount)) AS TOTAL
FROM
Orders AS O
INNER JOIN Employees AS E
ON O.EmployeeID = E.EmployeeID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
GROUP BY E.FirstName, E.LastName