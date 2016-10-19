USE MASTER
GO

CREATE TRIGGER PreventDatabaseCreation
ON ALL SERVER
AFTER CREATE_DATABASE
AS
BEGIN
	DECLARE @Message NVARCHAR(256) ;
	SET @Message = (SELECT SUSER_SNAME() + ', you must follow due process in order to create Databases in this environment. Pleae contact the DBA Team') ;
	PRINT @Message ;
	ROLLBACK ;
END
