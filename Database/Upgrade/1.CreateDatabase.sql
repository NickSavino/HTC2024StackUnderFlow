-- Drop all foreign key constraints
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += 'ALTER TABLE [' + SCHEMA_NAME(schema_id) + '].[' + OBJECT_NAME(parent_object_id) + '] DROP CONSTRAINT [' + name + '];' + CHAR(13)
FROM sys.foreign_keys;

IF @sql <> ''
BEGIN
    PRINT 'Dropping all foreign key constraints...';
    EXEC sp_executesql @sql;
    PRINT 'All foreign key constraints dropped.';
END
ELSE
BEGIN
    PRINT 'No foreign key constraints found to drop.';
END
GO

DECLARE @sql NVARCHAR(MAX) = '';
-- Drop all tables in the database
SET @sql = '';

SELECT @sql += 'DROP TABLE [' + SCHEMA_NAME(schema_id) + '].[' + name + '];' + CHAR(13)
FROM sys.tables
WHERE is_ms_shipped = 0;

IF @sql <> ''
BEGIN
    PRINT 'Dropping all tables...';
    EXEC sp_executesql @sql;
    PRINT 'All tables dropped.';
END
ELSE
BEGIN
    PRINT 'No tables found to drop.';
END
GO

-- Additional setup or table creation commands can follow here
