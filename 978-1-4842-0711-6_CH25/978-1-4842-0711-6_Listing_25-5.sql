USE msdb;
GO

EXEC smart_admin.sp_set_db_backup 
                @database_name='Chapter25' 
                ,@enable_backup=1
                ,@retention_days =30 
                ,@credential_name ='URLBackupCredential'
                ,@encryption_algorithm ='NO_ENCRYPTION' ;             
GO
