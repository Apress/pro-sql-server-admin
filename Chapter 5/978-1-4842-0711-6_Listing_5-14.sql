USE [Chapter5]
GO

DBCC SHRINKFILE (N'Chapter5_log' , 0, TRUNCATEONLY);
