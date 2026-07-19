/*
Purpose: Create the sports-specific shemas for indivitual sports.
Objects: core, reference, stats schemas. XFER for internal use.
Dependencies: None

Change Log:
2026-07-06  Initial version
2026-07-14  Updates from ChatGPT-assisted analysis
*/
DECLARE @Schemas TABLE (SchemaName sysname PRIMARY KEY);
INSERT INTO @Schemas (SchemaName)
VALUES (N'core'), (N'reference'), (N'stats'), (N'XFER'); -- Schemas to create

DECLARE @SchemaName sysname;
DECLARE @sql nvarchar(max);

DECLARE schema_cursor CURSOR LOCAL FAST_FORWARD FOR
    SELECT SchemaName
    FROM @Schemas
    ORDER BY SchemaName;

OPEN schema_cursor;
FETCH NEXT FROM schema_cursor INTO @SchemaName;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM sys.schemas
        WHERE name = @SchemaName
    )
    BEGIN
        SET @sql = N'CREATE SCHEMA ' + QUOTENAME(@SchemaName) + N';';
        EXEC sys.sp_executesql @sql;
        PRINT N'Schema ' + @SchemaName + N' created.';
    END
    ELSE
    BEGIN
        PRINT N'Schema ' + @SchemaName + N' already exists.';
    END;

    FETCH NEXT FROM schema_cursor INTO @SchemaName;
END

CLOSE schema_cursor;
DEALLOCATE schema_cursor;