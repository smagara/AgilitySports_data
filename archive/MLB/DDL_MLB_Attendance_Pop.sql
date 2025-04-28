/****** Script for SelectTopNRows command from SSMS  ******/
insert into AgilitySports.MLB.Attendance 
(teamId
      ,[yearId]
      ,[teamName]
      ,[parkName]
      ,[attendance])
SELECT teamId, yearId, teamName=name, parkName=park, attendance
  FROM xfer.[MLB].Teams
  where yearID > 1919