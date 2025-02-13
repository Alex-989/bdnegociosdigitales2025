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