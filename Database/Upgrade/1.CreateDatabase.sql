-- Switch to master database
USE master;
GO

-- Check if the database exists
IF DB_ID('HTC_DB') IS NOT NULL
BEGIN
    -- Set the database to SINGLE_USER mode to drop active connections
    ALTER DATABASE HTC_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE HTC_DB;
    PRINT 'Database HTC_DB dropped.';
END
ELSE
BEGIN
    PRINT 'Database HTC_DB does not exist.';
END
GO

-- Create the database
CREATE DATABASE HTC_DB;
PRINT 'Database HTC_DB created.';
GO

-- Switch to the new database
USE HTC_DB;
GO
