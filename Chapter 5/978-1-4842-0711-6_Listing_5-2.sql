ALTER DATABASE [Chapter5] ADD FILEGROUP [Chapter5_FS_FG] CONTAINS FILESTREAM; 
GO

ALTER DATABASE [Chapter5] ADD FILE ( NAME = N'Chapter5_FA_File1', FILENAME = N'F:\MSSQL\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter5_FA_File1' ) TO FILEGROUP [Chapter5_FS_FG];
GO  

