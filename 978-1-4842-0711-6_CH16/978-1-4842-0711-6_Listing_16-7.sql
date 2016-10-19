EXEC sp_adddistributiondb @database = N'Distribution'
        , @data_folder = N'C:\MSSQL\Data'
        , @log_folder = N'C:\MSSQL\Data'
        , @log_file_size = 2
        , @min_distretention = 0
        , @max_distretention = 72
        , @history_retention = 48
        , @security_mode = 1 ;
GO
