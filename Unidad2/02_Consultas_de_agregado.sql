-- Consultas de agregado
-- Nota: Solo devuelben un solo registro
-- sum, avg, count, count(*), max y min

USE Northwind

-- Cuantos clientes tengo
SELECT COUNT (*) AS 'Numero de clientes' FROM Customers

-- Cuantas regiones hay
SELECT COUNT (Region)
from Customers
WHERE Region IS NULL

SELECT COUNT (*)
from Customers
WHERE Region IS NULL

SELECT DISTINCT Region
from Customers
WHERE Region IS NOT NULL
ORDER BY Region ASC

SELECT COUNT(DISTINCT Region)
from Customers
WHERE Region IS NOT NULL


SELECT * FROM Orders
SELECT COUNT (*) FROM Orders
SELECT COUNT (ShipRegion) FROM Orders


-- Selecciona el precio mas bajo de los productos
SELECT MIN(UnitPrice) FROM Products

-- Seleccionar cuantos pedidos existen
SELECT * FROM Orders
SELECT COUNT (*) AS 'Total de pedidos' FROM Orders

-- Calcula el total de dinero vendido
SELECT SUM(UnitPrice * Quantity) AS 'Ganancias' FROM [Order Details]
SELECT SUM(UnitPrice * Quantity -
(UnitPrice * Quantity * Discount)) AS 'Ganancias' FROM [Order Details]

-- Calcula el total de unidades en stock de todos los productos
SELECT * FROM Products
SELECT SUM (UnitsInStock) AS 'Total de Stocks' FROM Products


-- Seleccionar el total de numero de productos por categoria
SELECT COUNT (CategoryID), COUNT (*) FROM Products
-- Opcion 2
SELECT CategoryID, COUNT (*) AS 'Total de productos' 
FROM Products
GROUP BY CategoryID 


SELECT * FROM 
Categories AS C
INNER JOIN Products AS P
ON C.CategoryID = P.CategoryID


SELECT Categories.CategoryName,
COUNT(*) AS 'Numero de productos'
FROM 
Categories 
INNER JOIN Products AS P
ON Categories.CategoryID = P.CategoryID
GROUP BY Categories.CategoryName


-- Calcular el precio promedio de los productos por cada categoria
SELECT * FROM Products
SELECT CategoryID, AVG(UnitPrice) AS 'Precio promedio'
FROM Products
GROUP BY CategoryID


-- Seleccionar el numero de pedidos realizados por cada empleado
-- por el ultimo trimestre de 1996
SELECT * FROM Orders

SELECT EmployeeID,COUNT(*) AS 'Total de pedidos'
FROM Orders
GROUP BY EmployeeID;


SELECT EmployeeID, COUNT(*) AS '1996: Trimestre Octubre-Diciembre' FROM Orders
WHERE OrderDate BETWEEN '1996-01-10' AND '1996-31-12'
GROUP BY EmployeeID


-- Seleccionar la suma total de unidades vendidas por cada producto
SELECT * FROM [Order Details]

SELECT SUM(Quantity) AS 'Unidades vendidas'
FROM [Order Details]

SELECT ProductID, SUM(Quantity) AS 'Unidades vendidas'
FROM [Order Details]
GROUP BY ProductID

SELECT TOP 5 ProductID, SUM(Quantity) AS 'Unidades vendidas'
FROM [Order Details]
GROUP BY ProductID
ORDER BY 2 ASC

SELECT ProductID, SUM(Quantity) AS 'Unidades vendidas'
FROM [Order Details]
GROUP BY ProductID
ORDER BY 1 ASC

SELECT OrderID, ProductID, SUM(Quantity) AS 'Unidades vendidas'
FROM [Order Details]
GROUP BY OrderID, ProductID
ORDER BY 2 ASC


-- Seleccionar el numero de productos por categoria, pero solo aquellos
-- que tengan mas de 10 productos
SELECT * FROM Products

-- Paso 1
SELECT DISTINCT CategoryID FROM Products

-- Paso 2
SELECT COUNT(UnitPrice) AS 'Total de productos'
FROM Products

-- Paso 3
SELECT CategoryID ,COUNT(UnitPrice) AS 'Total de productos'
FROM Products
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID

-- Paso 4
SELECT CategoryID ,COUNT(UnitPrice) AS 'Total de productos'
FROM Products
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID
HAVING COUNT(*) > 10




-- Paso 2
SELECT CategoryID, UnitsInStock 
FROM Products
WHERE CategoryID IN (2,4,8)
ORDER BY CategoryID

-- Paso 3
SELECT CategoryID, SUM(UnitsInStock) 
FROM Products
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID
ORDER BY CategoryID

-- Paso 4
SELECT CategoryID, SUM(UnitsInStock) 
FROM Products
WHERE CategoryID IN (2,4,8)
GROUP BY CategoryID
HAVING COUNT(*)>10
ORDER BY CategoryID


-- Listar las ordenes agrupadas por empleado, pero que solo muestre
-- aquellos que hayan gestionado mas de 10 pedidos
SELECT * FROM Orders

SELECT COUNT(*) AS 'Total de ordenes'
FROM Orders

SELECT EmployeeID ,COUNT(*) AS 'Total de ordenes'
FROM Orders
WHERE COUNT(*) > 10
GROUP BY EmployeeID
