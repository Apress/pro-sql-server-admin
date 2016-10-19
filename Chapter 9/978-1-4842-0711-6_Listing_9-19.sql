USE Chapter9
GO

CREATE TABLE dbo.ownershipChain
(
	OwnershipChainID int
) ;
GO

CREATE USER Colin WITH PASSWORD = ‘Pa$$w0rd’ ;
GO

DENY SELECT ON OwnershipChain TO Colin ;
GO

CREATE PROCEDURE OwnershipChainSelect
AS
SELET * FROM dbo.OwnershipChain ;
GO

GRANT EXECUTE ON OwnershipChainSelect TO Colin ;
GO

EXECUTE AS USER = ‘Colin’ ;
GO

--The following statement will fail, as Colin has been denied permissions to the table

SELECT *
FROM   dbo.OwnershipChain ;
GO

--The following statement will succeed, because ownership chaining will be used

EXECUTE dbo.OwnershipChainSelect ;
GO

REVERT
