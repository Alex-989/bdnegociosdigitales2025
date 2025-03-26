# Views 
### - (Sirve para encapsular una consulta muy grande)
### - No se puede poner un ORDER BY en las vistas, solo despues de crearlas

# - Sintaxis

```SQL
CREATE VIEW nombreVista
AS
SELECT columnas
FROM tabla
WHERE condicion
GO ()
```

## Eliminar vista
```sql
DROP VIEW VistaClientesLatinos;
```

## Alterar una VISTA
```sql
ALTER VIEW VistaCategoriasTodas
GO
```

## Ejemplo creacion de una vista

```sql
USE Northwind;
GO

CREATE VIEW VistaCategoriasTodas
AS
SELECT CategoryID, CategoryName, [Description],
Picture FROM Categories;
GO
```

### Se ejecuta como una tabla.

```sql
SELECT * FROM VistaCategoriasTodas;
GO
```

## Ejemplo 2 creación de una vista

- Crear una vista que permita visualizar solamente clientes de Mexico y Brasil.

```sql
SELECT * FROM Customers;
GO

CREATE VIEW VistaClientesLatinos
AS
SELECT *
FROM Customers
WHERE Country IN('Mexico','Brazil');
GO

SELECT * FROM VistaClientesLatinos
GO
```

## Combinando Create con Alter

```sql
CREATE OR ALTER VIEW VistaClientesLatinos
AS
SELECT *
FROM Customers
WHERE Country IN('Mexico','Brazil');
GO
```

## Consulta de view con Inner Join

```sql
SELECT * 
FROM 
Orders AS ORD
INNER JOIN VistaClientesLatinos AS VCL
ON VCL.CustomerID = ORD.CustomerID
GO
```

## Ejemplo 3 creación de una vista

- Crear una vista que contenga los datos de: 
- Todas las ordenes
- Los productos 
- Empleados
- Categorias y clientes 
- En la orden calcular el importe

```sql
CREATE OR ALTER VIEW [dbo].[VistaOrdenesCompra]
AS
SELECT ORD.OrderID AS 'Numero Orden',
ORD.OrderDate AS 'Fecha de orden',
ORD.RequiredDate AS 'Fecha de Requisicion',
CONCAT(EM.FirstName, ' ', EM.LastName) AS 'Nombre del empleado',
CUS.CompanyName AS 'Nombre del cliente',
PRO.ProductName,
CAT.CategoryName AS 'Nombre de la categoria',
OD.UnitPrice AS 'Precio de venta',
OD.Quantity AS 'Cantidad vendida',
(OD.Quantity * OD.UnitPrice) AS 'Importe'
FROM 
Categories AS CAT
INNER JOIN Products AS PRO
ON CAT.CategoryID = PRO.CategoryID
INNER JOIN [Order Details] AS OD
ON OD.ProductID = PRO.ProductID
INNER JOIN Orders AS ORD
ON ORD.OrderID = OD.OrderID
INNER JOIN Customers AS CUS
ON CUS.CustomerID = ORD.CustomerID
INNER JOIN Employees AS EM
ON EM.EmployeeID = ORD.EmployeeID
GO

SELECT * FROM dbo.VistaOrdenesCompra

SELECT * FROM [Order Details]
```

## Creación de una vista en una vista

### Paso 1

```sql
SELECT CONCAT('$ ' , SUM(Importe)) AS 'Importe total'
FROM VistaOrdenesCompra
WHERE YEAR([Fecha de orden]) BETWEEN '1995' AND '1996' 
GO
```

## Paso 2

```sql
SELECT CONCAT('$ ' , SUM(Importe)) AS 'Importe total'
FROM VistaOrdenesCompra
WHERE YEAR([Fecha de orden]) BETWEEN '1995' AND '1996' 
GROUP BY [Nombre del cliente]
GO
```

## Paso 3

```sql
SELECT CONCAT('$ ' , SUM(Importe)) AS 'Importe total'
FROM VistaOrdenesCompra
WHERE YEAR([Fecha de orden]) BETWEEN '1995' AND '1996' 
GROUP BY [Nombre del cliente]
HAVING COUNT(*)>2;
GO
```

## Paso 4

```sql
CREATE OR ALTER VIEW VISTA_ORDENES_1995_1996
AS
SELECT CONCAT('$ ' , SUM(Importe)) AS 'Importe total'
FROM VistaOrdenesCompra
WHERE YEAR([Fecha de orden]) BETWEEN '1995' AND '1996' 
GROUP BY [Nombre del cliente]
HAVING COUNT(*)>2;
GO
```

## Creación de un SCHEMA

### Primero

```sql
CREATE SCHEMA rh
```

### Segundo

```sql
CREATE TABLE rh.tablarh(
id INT PRIMARY KEY,
nombre NVARCHAR(50)
)
```

## Vista horizontal

```sql
CREATE OR ALTER VIEW rh.ViewCategoriasproductos
AS
SELECT CAT.CategoryID, 
CategoryName, 
PRO.ProductID, 
PRO.ProductName 
FROM
Categories AS CAT
INNER JOIN Products AS PRO
ON CAT.CategoryID = PRO.CategoryID;
GO

SELECT * FROM rh.ViewCategoriasproductos
```

-- Vista Vertical