--Create the OrdersHeap table

CREATE TABLE ##OrdersHeap
	(
	OrderNumber int         IDENTITY	NOT NULL,
	OrderDate date           NOT NULL,
	CustomerID int            NOT NULL,
	ProductID int               NOT NULL,
	Quantity int                  NOT NULL,
	NetAmount money      NOT NULL,
	TaxAmount money      NOT NULL,
	InvoiceAddressID int   NOT NULL,
	DeliveryAddressID int  NOT NULL,
	DeliveryDate date        NULL
	)  ON [PRIMARY]
GO

--Build a numbers table for the data population

DECLARE @Numbers TABLE
(
	Number	INT
)

;WITH CTE(Number)
AS
(
	SELECT 1 Number
	UNION ALL
	SELECT Number + 1
	FROM CTE
	WHERE Number < 20
)
INSERT INTO @Numbers

SELECT Number FROM CTE

--Populate OrdersHeap with data

INSERT INTO ##OrdersHeap
SELECT
	(SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),getdate())as DATE)),
	(SELECT TOP 1 Number -10 FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	500,
	100,
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number - 10 FROM @Numbers ORDER BY NEWID()),getdate()) as DATE))
FROM @Numbers a
CROSS JOIN @Numbers b

--Create the OrdersCI table

CREATE TABLE ##OrdersCI
	(
	OrderNumber int         IDENTITY	NOT NULL,
	OrderDate date           NOT NULL,
	CustomerID int            NOT NULL,
	ProductID int               NOT NULL,
	Quantity int                  NOT NULL,
	NetAmount money      NOT NULL,
	TaxAmount money      NOT NULL,
	InvoiceAddressID int   NOT NULL,
	DeliveryAddressID int  NOT NULL,
	DeliveryDate date        NULL
	)  ON [PRIMARY]

--Populate OrdersCI with data

INSERT INTO ##OrdersCI
SELECT
	(SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),getdate())as DATE)),
	(SELECT TOP 1 Number -10 FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	500,
	100,
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT TOP 1 Number FROM @Numbers ORDER BY NEWID()),
	(SELECT CAST(DATEADD(dd,(SELECT TOP 1 Number - 10 FROM @Numbers ORDER BY NEWID()),getdate()) as DATE))
FROM @Numbers a
CROSS JOIN @Numbers b

--Run Benchmarks

SET STATISTICS TIME ON

SELECT * FROM ##OrdersHeap

SELECT * FROM ##OrdersCI
