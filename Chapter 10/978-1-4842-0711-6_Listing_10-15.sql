USE Chapter10
GO

SELECT SUM(DATALENGTH(CreditCardNumber))/1024.0/1024.0 PlainTextLengthMB
FROM Chapter10.dbo.SensitiveData ;

USE Chapter10CellEncrypted
GO

SELECT SUM(DATALENGTH(CreditCardNumber))/1024.0/1024.0 EncryptedLengthMB
FROM Chapter10CellEncrypted.dbo.SensitiveData ;
