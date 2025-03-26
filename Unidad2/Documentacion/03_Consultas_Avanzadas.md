# Ejercicios de consultas avanzadas

```sql
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
```

- Seleccionar los productos de las categorias beverages y condiments donde la existencia este entre 18 y 30.
```sql
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
```

- Seleccionar los productos y sus importes realizados de marzo a junio de 1996, mostrando la fecha de la orden, el id del del producto y el importe
```sql
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
```

- Mostrar el importe total de ventas de la consulta anterior.
```sql
SELECT CONCAT('$',' ',SUM(OD.Quantity * OD.UnitPrice)) AS Importe
FROM
Orders AS O
INNER JOIN [Order Details] AS OD
ON OD.OrderID = O.OrderID
WHERE O.OrderDate BETWEEN '1996-01-07' AND '1996-30-10'
```

## Consultas basicas con INER JOIN
- 1. Obtener los nombres de los clientes y los paises a los que enviaron sus pedidos.
```sql
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
```

- 2. Obtener los productos y sus respectivos proveedores.
```sql
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
```

- 3. Obtener los pedidos y los empleados que los gestionaron.
```sql
SELECT *
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID
```

- 4. Listar los productos juntos con sus precios y la categoria a la que pertenecen.
```sql
SELECT ProductName, UnitPrice, CategoryID
FROM
Products

SELECT ProductName, UnitPrice, CategoryName
FROM 
Products AS PRO
INNER JOIN
Categories AS CAT
ON CAT.CategoryID = PRO.CategoryID
```

- 5. Obtener el nombre del cliente, el numero de orden y fecha de orden.
```sql
SELECT CUS.CompanyName, ORD.OrderID, OrderDate
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
```

- 6. Listar las ordenes mostrando el numero de orden, el nombre del producto y la cantidad que se vendio.
```sql
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
```

- 7. Obtener los empleados y sus respectivos jefes.
```sql
SELECT CONCAT(E1.FirstName, ' ', E1.LastName) AS [Empleado],
CONCAT(J1.FirstName, ' ', J1.LastName) AS [Jefe]
FROM Employees AS E1
INNER JOIN Employees AS J1
ON E1.ReportsTo = J1.EmployeeID

SELECT FirstName, ReportsTo FROM Employees
```

- 8. Listar los pedidos y el nombre de la empresa de transporte utilizada.
```sql
SELECT * FROM Orders
SELECT * FROM Shippers

SELECT OrderID, SHI.CompanyName AS Transportista
FROM
Orders AS ORD
INNER JOIN Shippers AS SHI
ON SHI.ShipperID = ORD.ShipVia
ORDER BY 1 ASC
```

## Consultas INNER JOIN INTERMEDIAS

- 9. Obtener la cantidad total de productos vendidos por categoria.
```sql
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
```

- 10. Obtener el total de ventas por empleado.
```sql
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
```

- 11. Listar los clientes y la cantidad de pedidos que han realizado.
```sql
SELECT * FROM Orders -- = 830
SELECT * FROM Customers -- = 91

SELECT CUS.CompanyName,COUNT(*) AS 'Pedidos realizados'
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
GROUP BY CUS.CompanyName
ORDER BY 'Pedidos realizados' 

SELECT CUS.CompanyName,COUNT(*) AS 'Pedidos realizados'
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
GROUP BY CUS.CompanyName
ORDER BY 2 

SELECT CUS.CompanyName,COUNT(*) AS 'Pedidos realizados'
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
GROUP BY CUS.CompanyName
ORDER BY COUNT(*)
```

- 12. Obtener los empldeados que han gestionado pedidos enviados a alemania.
```sql
SELECT * FROM Employees
SELECT * FROM Orders

SELECT EM.EmployeeID, CONCAT(EM.FirstName, ' ', EM.LastName) AS 'Nombre', ShipCountry 
FROM
Orders AS ORD
INNER JOIN Employees EM
ON ORD.EmployeeID = EM.EmployeeID
WHERE ShipCountry = 'Germany'

SELECT DISTINCT EM.EmployeeID, CONCAT(EM.FirstName, ' ', EM.LastName) AS 'Nombre', ShipCountry 
FROM
Orders AS ORD
INNER JOIN Employees EM
ON ORD.EmployeeID = EM.EmployeeID
WHERE ShipCountry = 'Germany'
```

- 13. Listar los productos junto con el nombre del proveedor y el pais de origen.
```sql
SELECT * FROM Products
SELECT * FROM Suppliers
SELECT * FROM Orders

SELECT ProductID, ProductName, SUP.SupplierID, SUP.Country
FROM
Products AS PRO
INNER JOIN Suppliers AS SUP
ON PRO.SupplierID = SUP.SupplierID
```

- 14. Obtener los pedidos agrupados por pais de envio.
```sql
SELECT * FROM Orders
SELECT * FROM Shippers

SELECT OrderID, ShipCountry
FROM 
Orders AS ORD
ORDER BY ShipCountry

SELECT ORD.OrderID, ShipCountry
FROM 
Orders AS ORD
GROUP BY ORD.ShipCountry, ORD.OrderID

SELECT  COUNT(ORD.OrderID) AS 'Pedidos', ShipCountry
FROM 
Orders AS ORD
GROUP BY ORD.ShipCountry
ORDER BY ShipCountry
```

- 15. Obtener los empldeados y la cantidad de territorios en los que trabaja.
```sql
SELECT * FROM Employees
SELECT * FROM EmployeeTerritories

SELECT CONCAT(EM.FirstName,' ', EM.LastName) AS 'Nombre del empleado' ,
COUNT(EMTE.TerritoryID) AS 'Territorios en los que trabaja' 
FROM
EmployeeTerritories AS EMTE
INNER JOIN Employees AS EM
ON EMTE.EmployeeID = EM.EmployeeID
GROUP BY EM.FirstName, EM.LastName

SELECT CONCAT(EM.FirstName,' ', EM.LastName) AS 'Nombre del empleado' ,
COUNT(EMTE.TerritoryID) AS 'Territorios en los que trabaja',
TE.TerritoryDescription
FROM
EmployeeTerritories AS EMTE
INNER JOIN Employees AS EM
ON EMTE.EmployeeID = EM.EmployeeID
INNER JOIN Territories AS TE
ON TE.TerritoryID = EMTE.TerritoryID
GROUP BY EM.FirstName, EM.LastName, TE.TerritoryDescription
ORDER BY 'Nombre del empleado', TE.TerritoryDescription DESC
```

- 16. Listar las categorias y la cantidad de productos que contienen.
```sql
SELECT * FROM Categories
SELECT * FROM Products

SELECT CAT.CategoryName, COUNT(PRO.ProductID) AS 'Productos totales'
FROM
Products AS PRO
INNER JOIN Categories AS CAT
ON PRO.CategoryID = CAT.CategoryID
GROUP BY CAT.CategoryName
```

- 17. Obtener la cantidad total de productos vendidos por proveedor.
```sql
SELECT * FROM Products
SELECT * FROM Suppliers
SELECT * FROM [Order Details]
SELECT * FROM Orders

SELECT SUP.CompanyName AS 'PROVEDOR',
SUM(OD.Quantity) AS 'Total de productos vendidos'
FROM
Suppliers AS SUP
INNER JOIN Products AS PRO
ON PRO.SupplierID = SUP.SupplierID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
GROUP BY SUP.CompanyName
ORDER BY 2 DESC
```

- 18. Obtener la cantidad de pedidos enviados por cada empresa de transporte.
```sql
SELECT SHI.CompanyName AS 'Transportista', COUNT(*) AS 'Total de pedidos'
FROM 
Orders AS ORD
INNER JOIN Shippers AS SHI
ON ORD.ShipVia = SHI.ShipperID
GROUP BY SHI.CompanyName

SELECT * FROM Orders

SELECT COUNT(*) FROM Orders

SELECT COUNT(OrderID) FROM Orders

SELECT COUNT(ShipRegion) FROM Orders
```

- 19. Obtener los clientes que han realizado pedidos con mas de un producto.
```sql
SELECT CUS.CompanyName, COUNT(ProductID) AS 'Numero de productos'
FROM
Customers AS CUS
INNER JOIN Orders AS ORD
ON CUS.CustomerID = ORD.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = ORD.OrderID
GROUP BY CUS.CompanyName

SELECT CUS.CompanyName, COUNT(ProductID) AS 'Numero de productos'
FROM
Customers AS CUS
INNER JOIN Orders AS ORD
ON CUS.CustomerID = ORD.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = ORD.OrderID
GROUP BY CUS.CompanyName
ORDER BY 2 DESC

SELECT CUS.CompanyName, COUNT(DISTINCT ProductID) AS 'Numero de productos'
FROM
Customers AS CUS
INNER JOIN Orders AS ORD
ON CUS.CustomerID = ORD.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = ORD.OrderID
GROUP BY CUS.CompanyName
ORDER BY 2 DESC
```

- 20. Listar los empleados con la cantidad total de pedidos que han gestionado y a que clientes les han vendido, agrupandolos por nombre completo.
- Y dentro de este nombre por cliente
- Ordenandolos por la cantidad de mayor pedidos.
```sql
SELECT  EM.EmployeeID, COUNT(*) AS 'Numero de pedidos'
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID
GROUP BY EM.EmployeeID

SELECT EM.EmployeeID, CONCAT(EM.FirstName, ' ', EM.LastName) AS 'Nombre completo',
COUNT(*) AS 'Numero de pedidos'
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID
GROUP BY EM.FirstName, EM.LastName, EM.EmployeeID

SELECT CONCAT(EM.FirstName, ' ', EM.LastName) AS 'Nombre completo',
CUS.CompanyName AS 'Cliente',
COUNT(OrderID) AS 'Numero de pedidos'
FROM
Orders AS ORD
INNER JOIN Employees AS EM
ON ORD.EmployeeID = EM.EmployeeID
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
GROUP BY EM.FirstName, EM.LastName, CUS.CompanyName
ORDER BY 'Nombre completo' ASC, 'Cliente'
```

- 21. Listar las categorias con el total de ingresos generados por sus productos.
```sql
SELECT * FROM Products
SELECT * FROM Categories
SELECT * FROM [Order Details]

SELECT  CAT.CategoryName, SUM(UnitsInStock * Quantity) AS 'Ingresos generados'
FROM
[Order Details] AS OD
INNER JOIN Products AS PRO
ON OD.ProductID = PRO.ProductID
INNER JOIN Categories AS CAT
ON PRO.CategoryID = CAT.CategoryID
GROUP BY CAT.CategoryName


SELECT  CAT.CategoryName, CONCAT('$ ',SUM(OD.UnitPrice * Quantity)) AS 'Ingresos generados'
FROM
[Order Details] AS OD
INNER JOIN Products AS PRO
ON OD.ProductID = PRO.ProductID
INNER JOIN Categories AS CAT
ON PRO.CategoryID = CAT.CategoryID
GROUP BY CAT.CategoryName

SELECT  CAT.CategoryName, PRO.ProductName, CONCAT('$ ',SUM(OD.UnitPrice * Quantity)) AS 'Ingresos generados'
FROM
[Order Details] AS OD
INNER JOIN Products AS PRO
ON OD.ProductID = PRO.ProductID
INNER JOIN Categories AS CAT
ON PRO.CategoryID = CAT.CategoryID
GROUP BY CAT.CategoryName, PRO.ProductName
ORDER BY CAT.CategoryName
```

- 22. Listar los clientes con el total ($) gastado por pedidos.
```sql
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT CUS.CompanyName, SUM(UnitPrice * Quantity) AS 'Gastado por pedidos'
FROM Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = ORD.OrderID
GROUP BY CUS.CompanyName
```

- 23. Listar los pedidos realizados entre 1 de enero de 1997 y el 30 de junio de 1997 y mostrar el total de dinero.
```sql
SELECT COUNT(*) FROM Orders
WHERE OrderDate BETWEEN '01-01-1997' AND '30-06-1997'

SELECT OrderID, OrderDate, Freight FROM Orders
WHERE OrderDate BETWEEN '01-01-1997' AND '30-06-1997'

SELECT ORD.OrderID, OrderDate, SUM(OD.Quantity * OD.UnitPrice) AS 'Total de dinero' FROM Orders AS ORD
INNER JOIN [Order Details] AS OD
ON ORD.OrderID = OD.OrderID
WHERE OrderDate BETWEEN '01-01-1997' AND '30-06-1997'
GROUP BY ORD.OrderID, OrderDate

SELECT ORD.OrderID, OrderDate, CONCAT('$ ',SUM(OD.Quantity * OD.UnitPrice)) AS 'Total de dinero' FROM Orders AS ORD
INNER JOIN [Order Details] AS OD
ON ORD.OrderID = OD.OrderID
WHERE OrderDate BETWEEN '01-01-1997' AND '30-06-1997'
GROUP BY ORD.OrderID, OrderDate
```

- 24. Listar los productos con las categorias Beverages, seafood, confections.
```sql
SELECT * FROM Products
SELECT * FROM Categories

SELECT ProductName, CategoryName
FROM
Products AS PRO
INNER JOIN Categories AS CAT
ON PRO.CategoryID = CAT.CategoryID
WHERE CategoryName IN ('Beverages', 'Seafood', 'Confections')
```

- 25. Listar los clientes ubicados en Alemania y que hayan realizado pedidos entes del 1 de enero de 1997.
```sql
SELECT * FROM Customers
SELECT * FROM Orders

SELECT * FROM Customers
WHERE Country = 'Germany'

SELECT*
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
WHERE (CUS.Country = 'Germany') AND OrderDate < '01-01-1997'
```

- 26. Listar los clientes que han realizado pedidos con un total entre $500 y $2000.
```sql
SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM [Order Details]

SELECT CUS.CompanyName, SUM(OD.Quantity * OD.UnitPrice) AS 'Total'
FROM
Orders AS ORD
INNER JOIN Customers AS CUS
ON ORD.CustomerID = CUS.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID = ORD.OrderID
GROUP BY CUS.CompanyName
HAVING SUM(OD.Quantity * OD.UnitPrice) BETWEEN 500 AND 2000
```

# Left join, right, full y cross

## Left Join

- 1. Listar los empleados y los pedidos que han gestionado (incluyendo los empleados que no han 
-- echo pedidos).
```sql
SELECT * FROM Employees
SELECT * FROM Orders

SELECT FirstName ,EM.EmployeeID, COUNT(ORD.OrderID) AS 'Ordenes gestionadas'
FROM
Employees AS EM
INNER JOIN Orders AS ORD
ON EM.EmployeeID = ORD.EmployeeID
GROUP BY EM.EmployeeID, FirstName

SELECT FirstName ,EM.EmployeeID, COUNT(ORD.OrderID) AS 'Ordenes gestionadas'
FROM
Employees AS EM
LEFT JOIN Orders AS ORD
ON EM.EmployeeID = ORD.EmployeeID
GROUP BY EM.EmployeeID, FirstName
```

- Listar los productos que no tienen una categoria.
```sql
SELECT * FROM Products
SELECT * FROM Categories

SELECT *
FROM
Products
WHERE CategoryID is NULL

SELECT ProductName, CAT.CategoryName
FROM
Categories AS CAT
LEFT JOIN Products AS PRO
ON CAT.CategoryID = PRO.CategoryID

SELECT *
FROM
Categories AS CAT
LEFT JOIN Products AS PRO
ON CAT.CategoryID = PRO.CategoryID
WHERE ProductName IS NULL

### Practica de utilizacion de LEFT JOIN

-- Seleccionar los datos que se van a utilizar para insertar en la tabla products_new

-- product_id, productName, Customer, Category, unitPrice, discontinued, inserted_date

-- Consultas Avanzadas
DELETE Products
WHERE CategoryID = 9
```