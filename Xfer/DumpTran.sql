ALTER DATABASE AgilitySports SET RECOVERY SIMPLE

GO

DBCC SHRINKFILE (AgilitySports_Log, 5, TRUNCATEONLY)

GO

ALTER DATABASE AgilitySports SET RECOVERY FULL

GO