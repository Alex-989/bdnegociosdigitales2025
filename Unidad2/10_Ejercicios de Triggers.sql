-- Triggers (Disparadores)
-- Es un tipo de SP

-- Solo se usa en los Insert, Update y delete

-- Son tablas magicas


-- Realizar un trigger cuando se inserte un pedido y modifique
-- el stock del producto vendido,
-- Verificar si hay suficiente stock,
-- si no se cancela el pedido.

CREATE OR ALTER TRIGGER tg_pedidos_insertar
ON pedidos
AFTER INSERT
AS
BEGIN
	declare @existencia

	l
END;