USE Chapter9
GO

CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter9-SensitiveData]
FOR SERVER AUDIT [Audit-Chapter9]
ADD (INSERT ON OBJECT::dbo.SensitiveData BY public),
ADD (SELECT ON OBJECT::dbo.SensitiveData BY Danielle) ;
