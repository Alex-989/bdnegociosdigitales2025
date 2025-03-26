--Realizar un pedido 
--Validar que el pedido no exista
--Validar que el cliente, empleado y producto exista
--Validar que la cantidad a vender tenga suficiente stock
--Insertar el pedido
--Calcular el importe (Multiplicando el precio * la cantidad vendida)
--Actualizar el stock del producto (Restando el stock menos la cantidad vendida)

SELECT * FROM Pedidos
SELECT * FROM Productos
SELECT * FROM Representantes
GO

CREATE OR ALTER PROCEDURE spu_Crear_Pedido
@numeroPedido int, @cliente int,
@repre int, @fab char(5),
@producto char(5), @cantidad int
AS
BEGIN
	if exists (select 1 from Pedidos where Num_Pedido = @numeroPedido)
		begin
			print('El pedido ya existe')
			return
		end
	
	if NOT exists (select 1 from Clientes where Num_Cli = @cliente) OR
	NOT exists (select 1 from Representantes where Num_Empl = @repre) OR
	NOT exists (select 1 from Productos where Id_fab = @fab and Id_producto = @producto)
		begin
			print('Los datos no son validos')
			return
		end

	if @cantidad <= 0
		begin
			print('La cantidad no puede ser 0 o negativo')
			return;
		end

	declare @stockValido int
	select @stockValido = Stock from Productos where Id_fab = @fab and Id_producto = @producto
		if @cantidad > @stockValido
			begin
				print('No hay suficiente stock')
				return
			end

	declare @precio money
	declare @importe money

	select @precio = Precio from Productos where Id_fab = @fab and Id_producto = @producto
	SET @importe = @cantidad * @precio
	

	BEGIN TRY
	-- Se inserto un pedido
	Insert into Pedidos
	values(@numeroPedido, getdate(), @cliente, @repre, @fab, @producto, @cantidad, @importe)
	
	UPDATE Productos
	SET Stock = Stock - @cantidad
	WHERE Id_fab = @fab AND Id_producto = @producto
		
	END TRY
	BEGIN CATCH
		PRINT 'Error al actualizar datos'
			RETURN;
	END CATCH

END;
GO

EXEC spu_Crear_Pedido @numeroPedido = 112961, @cliente = 2117,
@repre=106, @fab='RFI',
@Producto = '2A44L', @cantidad=20

EXEC spu_Crear_Pedido @numeroPedido = 11308, @cliente = 2117,
@repre=101, @fab='ACI',
@Producto = '4100X', @cantidad=5


SELECT * FROM Productos
WHERE Id_fab = 'ACI' AND Id_producto = '4100X'
GO


EXEC spu_Crear_Pedido 

SELECT * FROM Pedidos