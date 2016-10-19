CREATE TRIGGER EnforceLicensing
ON ALL SERVER
FOR LOGON
AS
BEGIN
	IF (SELECT COUNT(DISTINCT login_name) 
		FROM sys.dm_exec_sessions 
		WHERE is_user_process = 1) > 100
	ROLLBACK ;
END
