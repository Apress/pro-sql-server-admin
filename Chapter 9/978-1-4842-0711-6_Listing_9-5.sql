CREATE LOGIN [PROSQLADMIN\pete] FROM WINDOWS WITH DEFAULT_DATABASE=Chapter8 ;
GO

USE Chapter7
GO

CREATE USER [PROSQLADMIN\pete] FOR LOGIN [PROSQLADMIN\pete] ;

USE Chapter8
GO

CREATE USER [PROSQLADMIN\pete] FOR LOGIN [PROSQLADMIN\pete] ;
