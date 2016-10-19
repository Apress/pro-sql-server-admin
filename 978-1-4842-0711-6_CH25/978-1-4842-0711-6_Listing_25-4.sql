USE Master
GO

RESTORE DATABASE Chapter25
FROM URL = 'https://prosqladmin.blob.core.windows.net/chapter25/chapter25.bak' 
WITH CREDENTIAL = 'URLBackupCredential', REPLACE ;

GO
