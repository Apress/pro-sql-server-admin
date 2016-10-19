USE Chapter9
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter9-SensitiveData]
WITH (STATE = ON) ;
GO

USE Master
GO

ALTER SERVER AUDIT [Audit-Chapter9] WITH (STATE = ON) ;
