--Create the duplicate Database

CREATE DATABASE Chapter10
GO

USE Chapter10
GO

--Create the table

CREATE TABLE dbo.SensitiveData
(
ID		INT		PRIMARY KEY	IDENTITY,
FirstName	NVARCHAR(30),
LastName	NVARCHAR(30),
CreditCardNumber	VARBINARY(8000)
)
GO

--Populate the table

SET identity_insert dbo.SensitiveData ON

INSERT INTO dbo.SensitiveData(id, firstname, lastname, CreditCardNumber)
SELECT id
,firstname
,lastname
,CreditCardNumber
FROM  Chapter10Encrypted.dbo.SensitiveData

SET identity_insert dbo.SensitiveData OFF
