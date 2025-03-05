-- Ejemplo de left join aplicado

USE Northwind

SELECT * FROM Products_new

-- Crear una tabla antes de una consulta
SELECT PRO.productid, PRO.productName,
CUS.CompanyName,
CAT.CategoryName,
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'insert_date'
INTO Products_new
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID


-- Crea la tabla solo la estructura.
SELECT TOP 0 PRO.productid, PRO.productName,
CUS.CompanyName,
CAT.CategoryName,
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'insert_date'
INTO Products_new
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID


-- Con alias
SELECT TOP 0 0 AS [productbk], PRO.productid, PRO.productName AS 'producto',
CUS.CompanyName AS 'Customer',
CAT.CategoryName AS 'Category',
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'insert_date'
INTO Products_new
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID


-- Carga full
-- Importa el orden de como se ponen los campos

INSERT INTO Products_new

SELECT PRO.productid, PRO.productName,
CUS.CompanyName,
CAT.CategoryName,
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'Fecha actual'
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID

select * from Products_new

SELECT * FROM Products_new

-- Eliminar tablas 
DROP TABLE Products_new

ALTER TABLE Products_new
ADD CONSTRAINT pk_Products_new
primary key ()


-- Crear tabla
SELECT TOP 0 PRO.productid, PRO.productName AS 'producto',
CUS.CompanyName AS 'Customer',
CAT.CategoryName AS 'Category',
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'insert_date'
INTO Products_new
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID

alter table Products_new
ADD productbk INT NOT NULL IDENTITY (1,1)

ALTER TABLE Products_new
ADD CONSTRAINT pk_Products_new
PRIMARY KEY (productbk)
GO


-- Carga Full 2
INSERT INTO Products_new (ProductID, producto, Customer, Category,
UnitPrice, Discontinued, insert_date)

SELECT PRO.productid, PRO.productName,
CUS.CompanyName,
CAT.CategoryName,
OD.UnitPrice,PRO.Discontinued,
GETDATE()
FROM 
Products AS PRO
INNER JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID



--Z
SELECT PN.ProductID, PN.producto, PN.Customer, PN.Category,
PN.UnitPrice, PN.Discontinued, PN.insert_date,
P.ProductID, P.ProductName
FROM
Products AS P
LEFT JOIN Products_new AS PN
ON P.ProductID = PN.ProductID
WHERE PN.ProductID IS NULL

SELECT PN.ProductID, PN.producto, PN.Customer, PN.Category,
PN.UnitPrice, PN.Discontinued, PN.insert_date,
P.ProductID, P.ProductName
FROM
Products AS P
LEFT JOIN Products_new AS PN
ON P.ProductID = PN.ProductID


-- Carga delta
INSERT INTO Products_new (ProductID, producto, Customer, Category,
UnitPrice, Discontinued, insert_date)
SELECT PRO.productid, PRO.productName,
CUS.CompanyName,
CAT.CategoryName,
OD.UnitPrice,PRO.Discontinued,
GETDATE() AS 'insert_date',
PN.ProductID
FROM 
Products AS PRO
LEFT JOIN Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
LEFT JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
LEFT JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
LEFT JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID
LEFT JOIN Products_new AS PN
ON PN.ProductID = PRO.ProductID
WHERE PN.ProductID IS NULL


insert into products_new (ProductID,producto,Customer,
Category,UnitPrice,Discontinued, insert_date)
select p.ProductID, p.ProductName
,[cu].CompanyName, 
c.CategoryName, od.UnitPrice, 
p.Discontinued, GETDATE() as 'inserted_date'
from Products as p 
left join 
Categories as c 
on p.CategoryID = c.CategoryID
left join [Order Details] as od
on od.ProductID = p.ProductID
left join Orders as o
on o.OrderID = od.OrderID
left join Customers as [cu]
on [cu].CustomerID = o.CustomerID
left join products_new as pn
on pn.ProductID = p.ProductID
where pn.ProductID is null


SELECT * FROM Products