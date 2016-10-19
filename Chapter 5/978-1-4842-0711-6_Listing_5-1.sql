USE Master 
GO

--Create a database with 3 files in the primary filegroup

CREATE DATABASE [Chapter5]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Chapter5', FILENAME = N'F:\MSSQL\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter5.mdf'),
( NAME = N'Chapter5_File2', FILENAME = N'F:\MSSQL\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter5_File2.ndf'),
( NAME = N'Chapter5_File3', FILENAME = N'F:\MSSQL\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter5_File3.ndf')  
 LOG ON 
( NAME = N'Chapter5_log', FILENAME = N'E:\MSSQL\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter5_log.ldf');
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [Chapter5] MODIFY FILEGROUP [PRIMARY] DEFAULT;
GO

USE Chapter5
GO

--Create a table in the new database. The tabe contains a wide, fixed length column, to increase the number of allocations

CREATE TABLE dbo.RoundRobinTable  
(
	ID		INT	IDENTITY	PRIMARY KEY,  
	DummyTxt	NCHAR(1000),
);
GO

--Create a Numbers table, that will be used to assit the population of the table

DECLARE @Numbers TABLE
(
	Number	INT
)

--Populate the Numbers table

;WITH CTE(Number)
AS
(
	SELECT 1 Number

	UNION ALL
	SELECT Number +1
	FROM CTE
	WHERE Number <= 99
)
INSERT INTO @Numbers
SELECT *
FROM CTE;

--Populate the example table with 100 rows of dummy text

INSERT INTO dbo.RoundRobinTable
SELECT 'DummyText'
FROM @Numbers a
CROSS JOIN @Numbers b;

--Select all the data from the table, plus the details of the rows physical location. Then group the row count 
--by file ID
SELECT b.file_id, COUNT(*)
FROM
(
	SELECT ID, DummyTxt, a.file_id
	FROM dbo.RoundRobinTable  
	CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%) a
) b
GROUP BY b.file_id;
