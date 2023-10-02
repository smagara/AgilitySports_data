-- =============================================================================================================================
-- Create Azure SQL User account for AgilitySports API data access
-- =============================================================================================================================

--Use AgilitySports2;

CREATE USER [agility_user] WITH PASSWORD = 'jfZwV8Ki4P4I5w', DEFAULT_SCHEMA=[MLB];

ALTER ROLE db_datareader ADD MEMBER [agility_user];