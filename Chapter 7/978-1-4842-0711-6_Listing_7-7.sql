USE Chapter7
GO

--Create nonclustered index

CREATE NONCLUSTERED INDEX NCI_CustomerID ON OrdersDisc(CustomerID)
GO

--Drop cache

DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

--Turn on statistics capture

SET STATISTICS TIME ON
SET STATISTICS IO ON

--Run the benchmark
SELECT CustomerID, ProductID, Quantity
FROM [dbo].[OrdersDisc]
WHERE CustomerID = 88
