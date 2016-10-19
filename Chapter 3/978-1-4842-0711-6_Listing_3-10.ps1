;SQL Server 2014 Configuration File
[OPTIONS]

; Accept the SQL Server License Agreement

IACCEPTSQLSERVERLICENSETERMS

; Specifies a Setup work flow, like INSTALL, UNINSTALL, or UPGRADE. This is a required parameter. 

ACTION="Install"

; Setup will display progress only, without any user interaction. 

QUIETSIMPLE="True"

; Specifies features to install, uninstall, or upgrade. The list of top-level features include SQL, AS, RS, IS, MDS, and Tools. The SQL feature will install the Database Engine, Replication, Full-Text, and Data Quality Services (DQS) server. The Tools feature will install Management Tools, Books online components, SQL Server Data Tools, and other shared components. 

FEATURES=SQLENGINE,REPLICATION,CONN

; Auto-start service after installation.  

AGTSVCSTARTUPTYPE="Automatic"

; Level to enable FILESTREAM feature at (0, 1, 2 or 3). 

FILESTREAMLEVEL="1"

; Specifies a Windows collation or an SQL collation to use for the Database Engine. 

SQLCOLLATION="Latin1_General_CI_AS"

; Windows account(s) to provision as SQL Server system administrators. 

SQLSYSADMINACCOUNTS="MyDomain\SQLDBA"

; Specify 0 to disable or 1 to enable the TCP/IP protocol. 

TCPENABLED="1"

; Specify 0 to disable or 1 to enable the Named Pipes protocol. 

NPENABLED="1"
