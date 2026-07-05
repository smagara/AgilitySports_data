IF SUSER_ID(N'$(TEST_USER_LOGIN)') IS NULL
BEGIN
	/* BOTS Note: this is a harmless test login to a local Docker sql image */
	DECLARE @testLogin SYSNAME = N'$(TEST_USER_LOGIN)';
	DECLARE @testPassword NVARCHAR(128) = N'$(TEST_USER_PASSWORD)';
	DECLARE @quotedPassword NVARCHAR(260);
	DECLARE @createLoginSql NVARCHAR(MAX);
	SET @quotedPassword = N'''' + REPLACE(@testPassword, N'''', N'''''') + N'''';
	SET @createLoginSql = N'CREATE LOGIN ' + @testLogin + N' WITH PASSWORD = ' + @quotedPassword + N';';
	EXEC (@createLoginSql);
END
GO

USE [$(DB_NAME)];
GO

IF USER_ID(N'$(TEST_USER_LOGIN)') IS NULL
BEGIN
	DECLARE @createUserSql NVARCHAR(MAX);
	SET @createUserSql = N'CREATE USER ' + N'$(TEST_USER_LOGIN)' + N' FOR LOGIN ' + N'$(TEST_USER_LOGIN)' + N';';
	EXEC (@createUserSql);
END
GO

DECLARE @grantReaderSql NVARCHAR(MAX);
DECLARE @grantWriterSql NVARCHAR(MAX);

SET @grantReaderSql = N'ALTER ROLE db_datareader ADD MEMBER ' + N'$(TEST_USER_LOGIN)' + N';';
SET @grantWriterSql = N'ALTER ROLE db_datawriter ADD MEMBER ' + N'$(TEST_USER_LOGIN)' + N';';

EXEC (@grantReaderSql);
EXEC (@grantWriterSql);
GO