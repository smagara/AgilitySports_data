/* Populate test NFL data for dev */

IF EXISTS (SELECT 1 FROM [NFL].[Roster])
BEGIN
	PRINT 'NFL roster already seeded. Skipping 006-seed-dev-data-NFL.sql';
	SET NOEXEC ON;
END
GO

SET IDENTITY_INSERT [NFL].[Roster] ON 
GO
INSERT [NFL].[Roster] ([PlayerId], [FirstName], [LastName], [Team], [Position], [FantasyPosition], [PositionCategory], [Height], [Weight], [Number], [CurrentStatus], [CurrentStatusColor], [BirthDateShortString], [Age], [AgeExact], [College], [CollegeDraftRound], [CollegeDraftPick], [ExperienceDigit], [PlayerUrlString], [TeamName], [TeamUrlString], [PhotoUrl], [PreferredHostedHeadshotUrl], [LowResPreferredHostedHeadshotUrl], [IsAvailableToPlay], [Status], [InjuryStatus], [InjuryBodyPart], [ShortName], [TeamDetails], [CSName]) VALUES
(1, N'John', N'Docker', N'NYG', N'QB', NULL, NULL, N'6''2"', 220, 12, NULL, NULL, NULL, 33, NULL, N'Docker University', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, N'Fred', N'Docker', N'Dolphins', N'FB', NULL, NULL, N'6''1"', 222, 13, NULL, NULL, NULL, 33, NULL, N'Nebraska', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, N'John', N'Doe', N'NYG', N'QB', NULL, NULL, N'6''2"', 220, 12, NULL, NULL, NULL, 22, NULL, N'Example University', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2003, N'John', N'Doe', N'NYG', N'QB', N'QB', N'OFF', N'6''2"', 220, 12, N'Healthy', N'green', CAST(N'1995-05-15' AS Date), 29, 29.75, N'Example University', N'1', N'10', N'5', N'http://example.com/player/johndoe', N'Example Team', N'http://example.com/team/exampleteam', N'http://example.com/player/johndoe/photo.jpg', N'http://example.com/player/johndoe/headshot.jpg', N'http://example.com/player/johndoe/headshot_lowres.jpg', 1, N'Healthy', N'None', N'None', N'J. Doe', N'Example Team Details', N'John Doe'),
(3003, N'Fred', N'Smith', N'NYG', N'NT', NULL, NULL, N'6''2"', 220, 12, NULL, NULL, NULL, 33, NULL, N'Example University', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5003, N'John', N'Doe', N'NYG', N'QB', N'QB', N'OFF', N'6''2"', 220, 12, N'Healthy', N'green', CAST(N'1995-05-15' AS Date), 29, NULL, N'Example University', N'1', N'10', N'5', N'http://example.com/player/johndoe', N'Example Team', N'http://example.com/team/exampleteam', N'http://example.com/player/johndoe/photo.jpg', N'http://example.com/player/johndoe/headshot.jpg', N'http://example.com/player/johndoe/headshot_lowres.jpg', 1, N'Healthy', N'None', N'None', N'J. Doe', N'Example Team Details', N'John Doe'),
(6005, N'Tom', N'Brady', N'TB', N'QB', N'QB', N'OFF', N'6''4"', 225, 12, N'Active', N'green', CAST(N'1977-08-03' AS Date), 46, NULL, N'Michigan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6006, N'Docker Docker', N'Smith', N'NYG', N'K', NULL, NULL, N'6''2"', 220, 12, NULL, NULL, NULL, 29, NULL, N'Example University', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [NFL].[Roster] OFF
GO
declare @status varchar(100);
SELECT @status='NFL.Roster FINISHED! Volume=' + convert(varchar(100), count(*)) + '. Timestamp:' + convert(varchar(50), getdate(), 120) from NFL.Roster;
print @status;
GO

SET NOEXEC OFF;
GO


