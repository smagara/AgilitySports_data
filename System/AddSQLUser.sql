-- =============================================================================================================================
-- Create Azure SQL User account for AgilitySports API data access
-- =============================================================================================================================

/* drop the old SQL login with password */
DROP USER [agility_user]; -- run in AgilitySports2  
DROP LOGIN [agility_user_login]; -- run in master

/* Create a new SQL login from an Azure managed identity for passwordless access */
CREATE LOGIN AgilitySQLUserReadonly  FROM EXTERNAL PROVIDER; -- run in Master
CREATE USER AgilitySQLUserReadonly   FROM EXTERNAL PROVIDER; -- run in AgilitySports2
ALTER ROLE db_datareader ADD MEMBER AgilitySQLUserReadonly ; -- run in AgilitySports2
ALTER ROLE db_datawriter ADD MEMBER AgilitySQLUserReadonly ; -- run in AgilitySports2