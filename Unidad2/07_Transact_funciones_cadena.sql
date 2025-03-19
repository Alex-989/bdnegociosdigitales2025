-- Funciones de cadena

-- Las funciones de cadena permite manipular tipos de datos
-- como varchar, nvarchar, char, nchar

-- Funcion Len -> Devuelve la longitud de una cadena

-- Declaracion de una variable
DECLARE @Numero INT;
SET @Numero = 10;
PRINT @Numero;

-- Obtener el tamaño de la cadena almacenada en la varible texto
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT LEN(@Texto) AS 'Longitud'
GO

-- EJEMPLO 1 LEN
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CompanyName ,LEN(CompanyName) AS 'Longitud' FROM Customers
GO

DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CompanyName ,LEN(CompanyName) AS 'Longitud' FROM Customers
ORDER BY 2 DESC
GO

-- LEFT Extrae un determinado numero de caracteres desde el inicio 
-- de la cadena
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT LEFT(@Texto, 4) AS 'Inicio'
GO

-- RIGHT Extrae un determinado numero de caracteres del final de la cadena
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT RIGHT(@Texto, 6) AS 'Final'

-- EJEMPLO 2 LEN, LEFT, RIGHT
SELECT CompanyName, LEN(CompanyName) AS 'Numero de caracteres',
LEFT(CompanyName, 4) AS 'Inicio',
RIGHT(CompanyName, 6) AS 'Final'
FROM Customers
GO

-- SUBSTRING Extrae una parte de la cadena donde el segundo parametro es la
-- posicion inicial y el tercer parametro el recorrido

-- (7) Desde donde inicia, (5) el recorrido que va a tomar
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT SUBSTRING(@Texto, 7, 5)
GO

-- EJEMPLO 2 LEN, LEFT, RIGHT, SUBSTRING
SELECT CompanyName, LEN(CompanyName) AS 'Numero de caracteres',
LEFT(CompanyName, 4) AS 'Inicio',
RIGHT(CompanyName, 6) AS 'Final',
SUBSTRING(CompanyName, 7, 4) AS 'Subcadena'
FROM Customers
GO

-- REPLACE Remplaza una subcadena por otra
-- Sintaxis (Nombre de la variable, Palabra a remplazar, Palabra nueva
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT REPLACE(@Texto, 'Mundo', 'Amigo')
GO

-- Ejemplo mio 1 
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT @Texto AS 'Texto original' ,REPLACE(@Texto, 'Mundo', 'Amigo') AS 'Remplazo'
GO

-- CHARINDEX
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CHARINDEX('Mundo', @Texto) AS 'Posicion en la que inicia'
GO

DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CHARINDEX('la', @Texto) AS 'Posicion en la que inicia'
GO

DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CHARINDEX('Hola', @Texto) AS 'Posicion en la que inicia'
GO


-- UPPER Convierte una cadena en mayusculas
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT UPPER(@Texto) AS 'Mayusculas'
GO

-- Prcticas
DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT REPLACE(@Texto, 'Mundo', 'MUNDO') as 'Mayusculas solo mundo'
GO

DECLARE @Texto VARCHAR(50) = 'Hola, Mundo!';
SELECT CONCAT(
				LEFT(@Texto, 5), 
				UPPER(SUBSTRING(@Texto, 7, 5)),
				RIGHT(@Texto, 1)
			 )
				AS 'Mundo en Mayusculas'
GO

-- Ejercicio 1 Cambiar los nombres de todos los clientes en mayusculas
SELECT *, REPLACE(UPPER(CompanyName))
FROM Customers

--
UPDATE Customers
SET CompanyName = UPPER(CompanyName)
WHERE Country IN ('Mexico', 'Germany')

SELECT * FROM Customers


-- TRIM Quita espacios en blanco de una cadena (Solo quita los espacios en blanco de los lados)
SELECT TRIM('   TEST     ') AS 'Result'
GO