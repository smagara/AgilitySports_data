/* populate the PositionCodes table, for NHL */
insert into dbo.PositionCodes (Sport, PositionCode, PositionDesc)
values 
('NHL', 'C', 'Center'),
('NHL', 'D', 'Defenseman'),
('NHL', 'F', 'Forward'),
('NHL', 'G', 'Goalie'),
('NHL', 'LW', 'Left Winger'),
('NHL', 'RW', 'Right Winger')

select *
from dbo.PositionCodes