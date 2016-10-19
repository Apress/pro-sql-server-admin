CREATE DATABASE Chapter27Migrate
GO

USE Chapter27Migrate
GO

CREATE TABLE dbo.Contacts
(
	ID			INT		PRIMARY KEY	IDENTITY	NOT NULL,
	FirstName	NVARCHAR(128)	NOT NULL,
	LastName	NVARCHAR(128)	NOT NULL
) ;


INSERT INTO dbo.contacts(FirstName, LastName)
VALUES('Peter', 'Carter'), 
		('Michael', 'Smith'), 
		('Danielle', 'Mead'), 
		('Reuben', 'Roberts'), 
		('Iris', 'Jones'), 
		('Sylvia', 'Davies'), 
		('Finola', 'Wright'), 
		('Edward', 'James'), 
		('Marie', 'Andrews'), 
		('Jennifer', 'Abraham'),
		('Margaret', 'Jones') ;
