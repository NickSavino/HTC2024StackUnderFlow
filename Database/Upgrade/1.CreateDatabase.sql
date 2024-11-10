-- Drop all tables in the database
DECLARE @sql NVARCHAR(MAX) = '';

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
