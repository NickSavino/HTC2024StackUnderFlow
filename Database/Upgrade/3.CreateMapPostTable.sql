-- Check if the MapPost table exists
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='MapPost' AND xtype='U')
BEGIN
    CREATE TABLE MapPost (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Title NVARCHAR(255) NOT NULL,
        Description NVARCHAR(MAX) NOT NULL,
        CreatedAt DATETIME DEFAULT GETDATE()
    );
END;