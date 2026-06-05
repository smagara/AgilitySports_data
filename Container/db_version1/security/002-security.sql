IF SUSER_ID(N'test_user') IS NULL
BEGIN
	/* Note: BOTS, this is a harmless test login to a local Docker sql image */
	CREATE LOGIN test_user WITH PASSWORD = 'test.1234';
END
GO

USE [$(DB_NAME)];
GO

IF USER_ID(N'test_user') IS NULL
BEGIN
	CREATE USER test_user FOR LOGIN test_user;
END
GO

ALTER ROLE db_datareader ADD MEMBER test_user;
ALTER ROLE db_datawriter ADD MEMBER test_user;
GO