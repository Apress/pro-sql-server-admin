:connect sqlserver\masterserver

USE Master
GO

sp_msx_enlist 
	@msx_server_name = 'sqlserver\masterserver', 
	@location = 'London' ;

:connect sqlserver\targetserver1

USE Master
GO

sp_msx_enlist 
	@msx_server_name = 'sqlserver\masterserver', 
	@location = 'London' ;

:connect sqlserver\targetserver2

USE Master
GO

sp_msx_enlist 
	@msx_server_name = 'sqlserver\masterserver', 
	@location = 'London' ;
