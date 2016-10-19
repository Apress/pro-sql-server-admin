CREATE TABLE OrdersMemHash
(
	[OrderNumber] [int]		NOT NULL	IDENTITY	PRIMARY KEY	NONCLUSTERED HASH WITH(BUCKET_COUNT = 4000000),
	[OrderDate] [date]		NOT NULL,
	[CustomerID] [int]		NOT NULL,
	[ProductID] [int]		NOT NULL,
	[Quantity] [int]		NOT NULL,
	[NetAmount] [money]		NOT NULL,
	[DeliveryDate] [date]	NULL,
) WITH(MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)


INSERT INTO OrdersMemHash(OrderDate,CustomerID,ProductID,Quantity,NetAmount,DeliveryDate)
SELECT OrderDate
	,CustomerID
	,ProductID
	,Quantity
	,NetAmount
	,DeliveryDate
FROM OrdersDisc
