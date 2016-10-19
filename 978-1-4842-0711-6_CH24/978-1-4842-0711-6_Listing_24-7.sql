--Disable the trigger

DISABLE TRIGGER PreventDatabaseCreation ON ALL SERVER ;

--Create the database

CREATE DATABASE Chapter24 ;

--Enable the trigger

ENABLE TRIGGER PreventDatabaseCreation ON ALL SERVER ;
