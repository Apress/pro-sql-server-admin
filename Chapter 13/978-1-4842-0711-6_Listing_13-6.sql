DBCC FREEPROCCACHE
DBCC DROPCLEANBUFFERS

SET STATISTICS TIME ON

PRINT 'Begin asynchronous commit benchmark'

USE Chapter13App2Customers
GO

PRINT 'Build a nonclustered index'

CREATE NONCLUSTERED INDEX NIX_FirstName_LastName ON App2Customers(FirstName, LastName) ;

PRINT 'Delete from table'

DELETE FROM [dbo].[App2Customers] ;

PRINT 'Insert into table'

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
	WHERE Number < 100
)
INSERT INTO @Numbers
SELECT Number FROM CTE ;

DECLARE @Names TABLE
(
	FirstName	VARCHAR(30),
	LastName	VARCHAR(30)
) ;

INSERT INTO @Names
VALUES('Peter', 'Carter'), 
		('Michael', 'Smith'), 
		('Danielle', 'Mead'), 
		('Reuben', 'Roberts'), 
		('Iris', 'Jones'), 
		('Sylvia', 'Davies'), 
		('Finola', 'Wright'), 
		('Edward', 'James'), 
		('Marie', 'Andrews'), 
		('Jennifer', 'Abraham'),
		('Margaret', 'Jones')

INSERT INTO App2Customers(Firstname, LastName, CreditCardNumber)
SELECT  FirstName, LastName, CreditCardNumber FROM
	(SELECT 
		(SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName
		,(SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName
		,(SELECT CONVERT(VARBINARY(8000), (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()))) CreditCardNumber 
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c
) d ;
GO

PRINT 'Begin synchronous commit benchmark'

USE Chapter13App1Customers
GO

PRINT 'Build a nonclustered index'

CREATE NONCLUSTERED INDEX NIX_FirstName_LastName ON App1Customers(FirstName, LastName) ;

PRINT 'Delete from table'

DELETE FROM [dbo].[App1Customers] ;

PRINT 'Insert into table'

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
	WHERE Number < 100
)
INSERT INTO @Numbers
SELECT Number FROM CTE ;

DECLARE @Names TABLE
(
	FirstName	VARCHAR(30),
	LastName	VARCHAR(30)
) ;

INSERT INTO @Names
VALUES('Peter', 'Carter'), 
		('Michael', 'Smith'), 
		('Danielle', 'Mead'), 
		('Reuben', 'Roberts'), 
		('Iris', 'Jones'), 
		('Sylvia', 'Davies'), 
		('Finola', 'Wright'), 
		('Edward', 'James'), 
		('Marie', 'Andrews'), 
		('Jennifer', 'Abraham'),
		('Margaret', 'Jones') ;

INSERT INTO App1Customers(Firstname, LastName, CreditCardNumber)
SELECT  FirstName, LastName, CreditCardNumber FROM
	(SELECT 
		(SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName
		,(SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName
		,(SELECT CONVERT(VARBINARY(8000), (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()))) CreditCardNumber 
FROM @Numbers a
CROSS JOIN @Numbers b
CROSS JOIN @Numbers c
) d ;

GO

SET STATISTICS TIME OFF

GO
