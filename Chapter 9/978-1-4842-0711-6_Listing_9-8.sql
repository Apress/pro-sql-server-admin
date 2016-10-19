--Create Chapter9 database

CREATE DATABASE Chapter9 ;
GO

USE Chapter9
GO

--Create SensitiveData table

CREATE TABLE dbo.SensitiveData
(
ID		INT		PRIMARY KEY		IDENTITY,
SensitiveText	NVARCHAR(100)
) ;

--Populate SensitiveData table

DECLARE @Numbers TABLE
(
ID	INT
)

;WITH CTE(Num)
AS
(
SELECT 1 AS Num
UNION ALL
SELECT Num + 1
FROM CTE
WHERE Num < 100
) 

INSERT INTO @Numbers
SELECT Num
FROM CTE ;

INSERT INTO dbo.SensitiveData
SELECT 'SampleData'
FROM @Numbers ;

--Setup the Role

CREATE ROLE db_ReadOnlyUsers AUTHORIZATION dbo ;
GO

ALTER ROLE db_ReadOnlyUsers ADD MEMBER Danielle ;

GRANT SELECT ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY DELETE ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY INSERT ON dbo.SensitiveData TO db_ReadOnlyUsers ;

DENY UPDATE ON dbo.SensitiveData TO db_ReadOnlyUsers ;
GO
