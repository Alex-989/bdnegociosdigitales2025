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
