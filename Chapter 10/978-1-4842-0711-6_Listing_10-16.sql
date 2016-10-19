--Drop the cache to ensure a fair results

DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE

USE Chapter10CellEncrypted
GO

--Open the CreditCardKey

OPEN SYMMETRIC KEY CreditCardKey
    DECRYPTION BY CERTIFICATE CreditCardCert;

--Turn on Ttime Statistics

SET STATISTICS TIME ON

--Run SELECT benchmark

SELECT 
	ID
	,FirstName
	,LastName
	,CONVERT(VARCHAR(30), DECRYPTBYKEY(CreditCardNumber)) CreditCardNumber
FROM dbo.SensitiveData ;

--Run INSERT benchmark

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
SELECT Number FROM CTE

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

INSERT INTO dbo.SensitiveData(Firstname, LastName, CreditCardNumber)
SELECT  FirstName, LastName, ENCRYPTBYKEY(KEY_GUID('CreditCardKey'), CreditCardNumber) FROM
	(SELECT 
		(SELECT TOP 1 FirstName FROM @Names ORDER BY NEWID()) FirstName
		,(SELECT TOP 1 LastName FROM @Names ORDER BY NEWID()) LastName
		,(SELECT CONVERT(VARBINARY(8000), (SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()) + '-' +
			(SELECT TOP 1 CAST(Number * 100 AS CHAR(4)) FROM @Numbers WHERE Number BETWEEN 10 AND 99 ORDER BY NEWID()))) CreditCardNumber 
FROM @Numbers a
CROSS JOIN @Numbers b
) d ;

--Clean-up Inserted Data

DELETE FROM dbo.SensitiveData
WHERE ID > 1000000 ;

CLOSE SYMMETRIC KEY CreditCardKey ;
