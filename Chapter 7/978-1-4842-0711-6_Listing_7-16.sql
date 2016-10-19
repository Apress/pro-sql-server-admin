--Create and populate temp table

SELECT * INTO ##OrdersMemHash
FROM OrdersMemHash

--Drop existing table

DROP TABLE OrdersMemHash

--Re-create the table with the new index

CREATE TABLE OrdersMemHash
(
	[OrderNumber] [int]		NOT NULL	IDENTITY	PRIMARY KEY	NONCLUSTERED HASH WITH(BUCKET_COUNT = 4000000),
	[OrderDate] [date]		NOT NULL	INDEX NCI_OrderDate NONCLUSTERED,
	[CustomerID] [int]		NOT NULL,
	[ProductID] [int]		NOT NULL,
	[Quantity] [int]		NOT NULL,
	[NetAmount] [money]		NOT NULL,
	[DeliveryDate] [date]	NULL,
) WITH(MEMORY_OPTIMIZED = ON, DURABILITY = SCHEMA_AND_DATA)
GO
--Allow values to be inserted into the identity column

SET IDENTITY_INSERT OrdersMemHash ON
GO
--Re-populate the table

INSERT INTO OrdersMemHash(OrderNumber,OrderDate,CustomerID,ProductID,Quantity,NetAmount,DeliveryDate)
SELECT *
FROM ##OrdersMemHash

--Stop further inserts to the identity column and clean-up temp table

SET IDENTITY_INSERT OrdersMemHash OFF

DROP TABLE ##OrdersMemHash
