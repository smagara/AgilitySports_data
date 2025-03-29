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

/* populate the PositionCodes table, for NFL */
insert into dbo.PositionCodes (Sport, PositionCode, PositionDesc)
values 
('NFL', 'C', 'Center'),
('NFL', 'CB', 'Cornerback'),
('NFL', 'DB', 'Defensive Back'),
('NFL', 'DE', 'Defensive End'),
('NFL', 'DL', 'Defensive Lineman'),
('NFL', 'DT', 'Defensive Tackle'),
('NFL', 'FB', 'Fullback'),
('NFL', 'G', 'Guard'),
('NFL', 'ILB', 'Inside Linebacker'),
('NFL', 'K', 'Kicker'),
('NFL', 'LB', 'Linebacker'),
('NFL', 'LS', 'Long Snapper'),
('NFL', 'NT', 'Nose Tackle'),
('NFL', 'OL', 'Offensive Lineman'),
('NFL', 'OLB', 'Outside Linebacker'),
('NFL', 'OT', 'Offensive Tackle'),
('NFL', 'P', 'Punter'),
('NFL', 'QB', 'Quarterback'),
('NFL', 'RB', 'Running Back'),
('NFL', 'S', 'Safety'),
('NFL', 'TE', 'Tight End'),
('NFL', 'WR', 'Wide Receiver');

select *
from dbo.PositionCodes
where sport = 'nfl'