EXEC smart_admin.sp_set_instance_backup 
			@enable_backup = 1, 
			@retention_days = 30, 
			@credential_name = N'URLBackupCredential', 
			@storage_url = N'https://prosqladmin.blob.core.windows.net/', 
			@encryption_algorithm = N'NO_ENCRYPTION' ;

GO
