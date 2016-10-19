USE Master
GO

EXEC xp_instance_regwrite 
    @rootkey = N'HKEY_LOCAL_MACHINE'
    ,@key = N'Software\Microsoft\MSSQLServer\MSSQLServer'
    ,@value_name = N'LoginMode'
    ,@type = N’REG_DWORD’
    ,@value = 1 ;
GO
