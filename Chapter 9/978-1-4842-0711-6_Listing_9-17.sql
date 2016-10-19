USE Chapter9
GO

--Grant with OBJECT notation

GRANT SELECT ON OBJECT::dbo.SensitiveData TO [PROSQLADMIN\Chapter9Users] ;
GO

--Grant without OBJECT notation

GRANT SELECT ON dbo.SensitiveData TO [PROSQLADMIN\Chapter9Users] ;
GO
