truncate table dbo.PositionCodes

/* populate the PositionCodes table, for NHL */
insert into dbo.PositionCodes (Sport, PositionCode, PositionDesc)
values 
('NHL', 'C', 'Center'),
('NHL', 'D', 'Defenseman'),
('NHL', 'F', 'Forward'),
('NHL', 'G', 'Goalie'),
('NHL', 'LW', 'Left Winger'),
('NHL', 'RW', 'Right Winger')

/* populate the PositionCodes table, for NBA */
insert into dbo.PositionCodes (Sport, PositionCode, PositionDesc)
values 
('NBA', 'C', 'Center'),
('NBA', 'F', 'Forward'),
('NBA', 'SF', 'Small Forward'),
('NBA', 'PF', 'Power Forward'),
('NBA', 'G', 'Guard'),
('NBA', 'PG', 'Point Guard'),
('NBA', 'SG', 'Shooting Guard')

select *
from dbo.PositionCodes