-- Check if the ImageMetadata table exists
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ImageMetadata' AND xtype='U')
BEGIN
    CREATE TABLE ImageMetadata (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        FileName NVARCHAR(255) NOT NULL,
        Latitude FLOAT NULL,
        Longitude FLOAT NULL,
        CreatedAt DATETIME DEFAULT GETDATE()
    );
END;