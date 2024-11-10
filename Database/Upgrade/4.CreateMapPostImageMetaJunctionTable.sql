-- Check if the MapPostImageMetadata table exists
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MapPostImageMetadata' AND xtype='U')
BEGIN
    CREATE TABLE MapPostImageMetadata (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        MapPostId INT NOT NULL,
        ImageMetadataId INT NOT NULL,
        FOREIGN KEY (MapPostId) REFERENCES MapPost(Id),
        FOREIGN KEY (ImageMetadataId) REFERENCES ImageMetadata(Id)
    );
END;