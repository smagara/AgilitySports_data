-- Create our test/dev database for local development on a SQL Server 2022 Docker image.
IF DB_ID(N'$(DB_NAME)') IS NULL
BEGIN
	EXEC('CREATE DATABASE [$(DB_NAME)]');
END
GO
