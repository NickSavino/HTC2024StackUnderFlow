-- Switch to master database
USE master;
GO

-- Check if the database exists
IF DB_ID('HTC_DB') IS NOT NULL
BEGIN
    PRINT 'Database HTC_DB exists. Dropping it now...';

    -- Set the database to SINGLE_USER mode to drop active connections
    ALTER DATABASE HTC_DB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    -- Drop the database
    DROP DATABASE HTC_DB;
    PRINT 'Database HTC_DB dropped successfully.';
END
ELSE
BEGIN
    PRINT 'Database HTC_DB does not exist.';
END
GO

-- Create the database
PRINT 'Creating database HTC_DB...';
CREATE DATABASE HTC_DB;
PRINT 'Database HTC_DB created successfully.';
GO

-- Switch to the new database
USE HTC_DB;
GO

-- Optional: Check if the USE statement worked
IF DB_NAME() = 'HTC_DB'
BEGIN
    PRINT 'Switched to HTC_DB successfully.';
END
ELSE
BEGIN
    PRINT 'Failed to switch to HTC_DB.';
END
GO
