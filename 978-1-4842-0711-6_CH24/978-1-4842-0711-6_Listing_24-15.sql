USE Master
GO

EXEC sp_settriggerorder @triggername='EnforceLicensing', @order='First', @stmttype='LOGON', @namespace='SERVER' ;

EXEC sp_settriggerorder @triggername='PreventLogindURINGetl', @order='Last', @stmttype='LOGON', @namespace='SERVER' ;
