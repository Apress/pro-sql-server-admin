USE Chapter9
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter9-SensitiveData]
WITH (STATE=OFF) ;
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter9-SensitiveData]
ADD (AUDIT_CHANGE_GROUP) ;
GO

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-Chapter9-SensitiveData]
WITH(STATE = ON) ;
GO 
