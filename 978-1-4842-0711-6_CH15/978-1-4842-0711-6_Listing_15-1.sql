CREATE DATABASE Chapter15
 ON  PRIMARY 
( NAME = 'Chapter15', FILENAME = 'C:\MSSQL\DATA\Chapter15.mdf'), 
 FILEGROUP FileGroupA
( NAME = 'Chapter15FileA', FILENAME = 'C:\MSSQL\DATA\Chapter15FileA.ndf' ), 
 FILEGROUP FileGroupB 
( NAME = 'Chapter15FileB', FILENAME = 'C:\MSSQL\DATA\Chapter15FileB.ndf' )
 LOG ON 
( NAME = 'Chapter15_log', FILENAME = 'C:\MSSQL\DATA\Chapter15_log.ldf' ) ;
GO

ALTER DATABASE [Chapter15] SET RECOVERY FULL ;
GO

USE Chapter15
GO

CREATE TABLE dbo.Contacts
(
ContactID	INT	NOT NULL	IDENTITY	PRIMARY KEY,
FirstName	NVARCHAR(30),
LastName	NVARCHAR(30),
AddressID	INT
) ON FileGroupA ;

CREATE TABLE dbo.Addresses
(
AddressID	INT	NOT NULL	IDENTITY	PRIMARY KEY,
AddressLine1	NVARCHAR(50),
AddressLine2	NVARCHAR(50),
AddressLine3	NVARCHAR(50),
PostCode	NCHAR(8)
) ON FileGroupB ;
