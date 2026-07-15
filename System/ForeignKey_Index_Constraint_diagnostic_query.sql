/*
Purpose: Diagnostic to list foreign keys, indexes & constraints
Object: Input a table name with schema.
Dependencies: none
*/

declare @table varchar(30) = 'core.Players';

-- list foreign keys
SELECT
    fk.name AS foreign_key_name
FROM sys.foreign_keys fk
WHERE fk.parent_object_id = OBJECT_ID(@table);

SELECT
    fk.name AS fk_name,
    OBJECT_SCHEMA_NAME(fk.parent_object_id) AS parent_schema,
    OBJECT_NAME(fk.parent_object_id) AS parent_table
FROM sys.foreign_keys fk
WHERE fk.referenced_object_id = OBJECT_ID(@table);

-- List constraints
EXEC sp_helpconstraint @table;

-- List indexes
EXEC sp_helpindex @table;