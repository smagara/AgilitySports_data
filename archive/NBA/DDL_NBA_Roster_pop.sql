-- populate the NBA roster table

  insert into AgilitySports.NBA.Roster( 
      [FirstName]
      ,[LastName]
      ,[Team]
      ,[Position]
      ,[Number]
      ,[Height]
      ,[Weight]
      ,[DateOfBirth]
      ,[College])
select  
	[FirstName]
      ,[LastName]
      ,[Team]
      ,[Position]
      ,[Number]
      ,[Height]
      ,[Weight]
      ,[DateOfBirth]
      ,[College] from xfer.nba.vwPlayer
GO


