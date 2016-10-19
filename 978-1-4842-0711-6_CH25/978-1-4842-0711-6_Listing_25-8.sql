USE MSDB
GO

EXEC smart_admin.sp_set_parameter 
            @parameter_name = 'SSMBackup2WAFrequency', 
            @parameter_value = 300 ;
