CREATE TABLE OrdersMemNonClust
(
	[OrderNumber] [int]		NOT NULL	IDENTITY	PRIMARY KEY	NONCLUSTERED,
	[OrderDate] [date]		NOT NULL,
	[CustomerID] [int]		NOT NULL,
	[ProductID] [int]		NOT NULL,
	[Quantity] [int]		NOT NULL,
	[NetAmount] [money]		NOT NULL,
	[DeliveryDate] [date]	NULL,
) WITH(MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO

INSERT INTO OrdersMemNonClust(OrderDate,CustomerID,ProductID,Quantity,NetAmount,DeliveryDate)
SELECT OrderDate
	,CustomerID
	,ProductID
	,Quantity
	,NetAmount
	,DeliveryDate
FROM OrdersDisc
GO

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SET STATISTICS TIME ON
SET STATISTICS IO ON

SELECT OrderNumber
FROM OrdersMemHash
WHERE OrderNumber  IN(78,88,98)

SELECT OrderNumber
FROM OrdersMemNonClust
WHERE OrderNumber IN(78,88,98)

SELECT OrderNumber
FROM OrdersDisc
WHERE OrderNumber  IN(78,88,98)
