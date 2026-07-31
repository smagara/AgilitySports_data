-- AZURE_SQL_DATABASE / AGILITY_TEST_USER are supplied by docker-compose from
-- AGILITY_DB_NAME / AGILITY_TEST_LOGIN in .env (Azure CI passes the same sqlcmd names).
IF SUSER_ID(N'$(AGILITY_TEST_USER)') IS NULL
BEGIN
	/* BOTS Note: this is a harmless test login to a local Docker sql image */
	DECLARE @testLogin SYSNAME = N'$(AGILITY_TEST_USER)';
	DECLARE @testPassword NVARCHAR(128) = N'$(TEST_USER_PASSWORD)';
	DECLARE @quotedPassword NVARCHAR(260);
	DECLARE @createLoginSql NVARCHAR(MAX);
	SET @quotedPassword = N'''' + REPLACE(@testPassword, N'''', N'''''') + N'''';
	SET @createLoginSql = N'CREATE LOGIN ' + QUOTENAME(@testLogin) + N' WITH PASSWORD = ' + @quotedPassword + N';';
	EXEC (@createLoginSql);
END
GO

USE [$(AZURE_SQL_DATABASE)];
GO

IF USER_ID(N'$(AGILITY_TEST_USER)') IS NULL
BEGIN
	DECLARE @createUserSql NVARCHAR(MAX);
	SET @createUserSql = N'CREATE USER ' + QUOTENAME(N'$(AGILITY_TEST_USER)') + N' FOR LOGIN ' + QUOTENAME(N'$(AGILITY_TEST_USER)') + N';';
	EXEC (@createUserSql);
END
GO

DECLARE @grantReaderSql NVARCHAR(MAX);
DECLARE @grantWriterSql NVARCHAR(MAX);

SET @grantReaderSql = N'ALTER ROLE db_datareader ADD MEMBER ' + QUOTENAME(N'$(AGILITY_TEST_USER)') + N';';
SET @grantWriterSql = N'ALTER ROLE db_datawriter ADD MEMBER ' + QUOTENAME(N'$(AGILITY_TEST_USER)') + N';';

EXEC (@grantReaderSql);
EXEC (@grantWriterSql);
GO