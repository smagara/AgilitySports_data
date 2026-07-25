/*
-- User already exists in Master, remove CREATE LOGIN, keep CREATE USER (for new DB)
IF SUSER_ID(N'$(AGILITY_TEST_USER)') IS NULL
BEGIN
	DECLARE @Login SYSNAME = N'$(AGILITY_TEST_USER)';
	DECLARE @Password NVARCHAR(128) = N'$(AGILITY_TEST_USER)';
	DECLARE @quotedPassword NVARCHAR(260);
	DECLARE @createLoginSql NVARCHAR(MAX);
	SET @quotedPassword = N'''' + REPLACE(@Password, N'''', N'''''') + N'''';
	SET @createLoginSql = N'CREATE LOGIN ' + @Login + N' WITH PASSWORD = ' + @quotedPassword + N';';
	EXEC (@createLoginSql);
END

*/
USE [$(AZURE_SQL_DATABASE)];
GO

IF USER_ID(N'$(AGILITY_TEST_USER)') IS NULL
BEGIN
	DECLARE @createUserSql NVARCHAR(MAX);
	SET @createUserSql = N'CREATE USER ' + N'$(AGILITY_TEST_USER)' + N' FOR LOGIN ' + N'$(AGILITY_TEST_USER)' + N';';
	PRINT @createUserSql
	EXEC (@createUserSql);
END
GO

DECLARE @grantReaderSql NVARCHAR(MAX);
DECLARE @grantWriterSql NVARCHAR(MAX);

SET @grantReaderSql = N'ALTER ROLE db_datareader ADD MEMBER ' + N'$(AGILITY_TEST_USER)' + N';';
SET @grantWriterSql = N'ALTER ROLE db_datawriter ADD MEMBER ' + N'$(AGILITY_TEST_USER)' + N';';

EXEC (@grantReaderSql);
EXEC (@grantWriterSql);
GO