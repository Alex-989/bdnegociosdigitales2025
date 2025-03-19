-- Store Procedure

-- Crea un store procedure para seleccionar todos los clientes
CREATE OR ALTER PROCEDURE spu_mostrar_clientes
AS
BEGIN
	SELECT * FROM Customers;
END


-- Ejecutar un store en transact
EXEC spu_mostrar_clientes;
GO


-- Se ejecuta este primero para que funcione
-- Crear un SP que muestre los clientes por pais
-- Parametros de entrada
CREATE OR ALTER PROC spu_CustomersPorPais
-- Parametros
@Pais NVARCHAR(15) -- Parametro de entrada
AS
BEGIN
	SELECT * FROM Customers
	WHERE Country = @Pais;
END;

-- Ejecuta el store
EXEC spu_CustomersPorPais 'Germany'
EXEC spu_CustomersPorPais 'Spain'
GO

-- Se ejecuta este para que funcione 
-- Para 2 paises
CREATE OR ALTER PROC spu_CustomersPorPais
-- Parametros
@Pais NVARCHAR(15), -- Parametro de entrada
@Pais2 NVARCHAR(15) -- Parametro de entrada
AS
BEGIN
	SELECT * FROM Customers
	WHERE Country IN (@PAIS, @Pais2)
END;

-- Ejecuta el store
EXEC spu_CustomersPorPais 'Germany', 'Spain'

-- Ejecuta el store procedure
DECLARE @P1 NVARCHAR(15) = 'Mexico';
DECLARE @P2 NVARCHAR(15) = 'Germany';

EXEC spu_CustomersPorPais @P1, @P2;
GO


-- Generar un reporte que permita visualizar los datos de compra de un determinado cliente
-- en un rango de fechas,
-- mostrando el monto total de compras por producto,
-- mediante SP
CREATE OR ALTER proc spu_informe_ventas_clientes
@nombre nvarchar (40) = 'Vins et alcools Chevalier',
@fechaInicial DateTime,
@fechaFinal DateTime
as
begin
Select ProductName, [Nombre del cliente], sum(Importe) AS 'Monto total'
from VistaOrdenesCompra
where [Nombre del cliente] = @nombre --parametro de entrada con valor por default
and [Fecha de orden] between @fechaInicial and @fechaFinal
group by ProductName, [Nombre del cliente];
end;

SELECT * FROM dbo.VistaOrdenesCompra
select * from Customers

--Ejecucion de un store procedure con parametros  de Entrada

exec spu_informe_ventas_clientes 'Vins et alcools Chevalier', 
								 '1996-01-01', '1997-01-01'

--Ejecucion de un store procedure con parametros en diferente posicion

exec spu_informe_ventas_clientes @fechaFinal = '1997-01-01',
								 @nombre ='Vins et alcools Chevalier',
								 @fechaInicial = '1996-01-01'

-- Ejecucion de un store procedure con parametros de entrada con un campo
-- que tiene un valor por default
exec spu_informe_ventas_clientes  
								 @fechaInicial = '1996-01-01', 
								 @fechaFinal = '1997-01-01'

GO


-- Crear un Store Preocedure que permita insertar un cliene

CREATE OR ALTER procedure spu_agregar_cliente
	@id nchar(5),
	@nombre nvarchar(40),
	@city nvarchar(15)  = 'San Miguel'
as
begin
	if exists (select 1 from Customers where CustomerID = @id)
	begin
		print ('El cliente ya existe')
		return 1
	end

	insert into Customers(CustomerID, CompanyName)
	values(@id, @nombre);
	print('Cliente insertado correctamente');
	return 0;
end;
go


-- STORE PROCEDURE CON TRY CATCH
SELECT * FROM Customers
exec spu_agregar_cliente 'ALFKI', 'Patito de hule'
exec spu_agregar_cliente 'ALFKC', 'Patito de hule'
GO

CREATE OR ALTER PROCEDURE spu_agregar_cliente_try_catch
	@id nchar(5),
	@nombre nvarchar(40),
	@city nvarchar(15)  = 'San Miguel'
	AS
BEGIN
	begin try
		insert into Customers(CustomerID, CompanyName)
		values(@id, @nombre);
		print('Cliente insertado correctamente');
	end try
	begin catch
		print('El cliente ya existe')
	end catch
end;
GO

exec spu_agregar_cliente 'ALFKD', 'Muñeca vieja'
GO

-- Manejo de ciclos con STORE PROCEDURES

-- Imprimir el numero de veces que indique el usuario

CREATE OR ALTER PROCEDURE spu_imprimir
	@numero int
	AS
BEGIN
	if @numero <= 0
	begin
		print('El numero no puede ser 0 o negativo')
		return
	end

		declare @i int
		set @i = 1
		while (@i <= @numero)
			BEGIN
			print concat('Numero' , @i)
			set @i = @i + 1
			end
END;
GO

EXEC spu_imprimir @numero = 10;
EXEC spu_imprimir @numero = -5;