--Create partition function

CREATE PARTITION FUNCTION OrdersPartFunc(int)
AS RANGE LEFT
FOR VALUES(250000,500000,750000)
GO

--Create partition scheme

CREATE PARTITION SCHEME OrdersPartScheme
AS PARTITION OrdersPartFunc
ALL TO([PRIMARY])
GO

--Partition OrdersDisc table

ALTER TABLE OrdersDisc DROP CONSTRAINT PK__OrdersDi__CAC5E7420B016A9F
GO

ALTER TABLE OrdersDisc ADD PRIMARY KEY CLUSTERED(OrderNumber) ON OrdersPartScheme(OrderNumber)
GO

--Craete partition aligned nonclustered index

CREATE NONCLUSTERED INDEX NCI_Part_CustID ON OrdersDisc(CustomerID, OrderNumber) ON OrdersPartScheme(OrderNumber)
