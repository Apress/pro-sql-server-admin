USE Chapter5
GO

CREATE TABLE dbo.ch05_test AS FILETABLE
  WITH
  (
    FILETABLE_DIRECTORY = 'Chapter5_FileTable',
    FILETABLE_COLLATE_FILENAME = database_default
  );
GO  
