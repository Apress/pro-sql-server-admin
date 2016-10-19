--Create Chapter7 Database

CREATE DATABASE Chapter7
 ON  PRIMARY 
( NAME = N'Chapter7', FILENAME = N'F:\Program Files\Microsoft SQL Server\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter7.mdf'), 
 FILEGROUP [MEM] CONTAINS MEMORY_OPTIMIZED_DATA  DEFAULT
( NAME = N'MEM', FILENAME = N'H:\DATA\CH07')
 LOG ON 
( NAME = N'Chapter7_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL12.PROSQLADMIN\MSSQL\DATA\Chapter7_log.ldf')
GO

USE Chapter7
GO

--Create CIDemo table

CREATE TABLE CIDemo
(
	ID			INT			IDENTITY,
	DummyText	VARCHAR(30)
)
GO

--Create clustered index

CREATE CLUSTERED INDEX [CI_CIDemo] ON [dbo].[CIDemo]([ID]) 
GO
