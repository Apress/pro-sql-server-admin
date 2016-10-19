CREATE NONCLUSTERED INDEX NonDeliveredItems ON OrdersDisc(DeliveryDate) 
	WHERE DeliveryDate IS NULL
