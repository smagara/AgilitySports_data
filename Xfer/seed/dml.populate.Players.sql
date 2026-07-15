-- Insert NFL Players
INSERT INTO dbo.Players (playerID, sportCode, positionCode, firstName, lastName, dateOfBirth, height, weight, number, college, birthCountry, birthCityState, draftYear)
VALUES
    (1001, 'NFL', 'QB', 'Patrick', 'Mahomes', '1995-09-17', '6-3', 230, 15, 'Texas Tech', 'USA', 'Tyler, TX', 2017),
    (1002, 'NFL', 'WR', 'Justin', 'Jefferson', '1999-06-16', '6-1', 195, 18, 'LSU', 'USA', 'St. Rose, LA', 2020),
    (1003, 'NFL', 'DE', 'Nick', 'Bosa', '1997-10-23', '6-4', 266, 97, 'Ohio State', 'USA', 'Fort Lauderdale, FL', 2019),
    (1004, 'NFL', 'RB', 'Christian', 'McCaffrey', '1996-06-07', '5-11', 205, 23, 'Stanford', 'USA', 'Castle Rock, CO', 2017),
    (1005, 'NFL', 'CB', 'Jalen', 'Ramsey', '1994-10-24', '6-1', 208, 5, 'Florida State', 'USA', 'Smyrna, TN', 2016);

-- Insert NBA Players
INSERT INTO dbo.Players (playerID, sportCode, positionCode, firstName, lastName, dateOfBirth, height, weight, number, college, birthCountry, birthCityState, draftYear)
VALUES
    (2001, 'NBA', 'PG', 'Stephen', 'Curry', '1988-03-14', '6-2', 185, 30, 'Davidson', 'USA', 'Akron, OH', 2009),
    (2002, 'NBA', 'SF', 'LeBron', 'James', '1984-12-30', '6-9', 250, 23, 'None', 'USA', 'Akron, OH', 2003),
    (2003, 'NBA', 'C', 'Nikola', 'Jokic', '1995-02-19', '6-11', 284, 15, 'None', 'Serbia', 'Sombor, Serbia', 2014),
    (2004, 'NBA', 'SG', 'Luka', 'Doncic', '1999-02-28', '6-7', 230, 77, 'None', 'Slovenia', 'Ljubljana, Slovenia', 2018),
    (2005, 'NBA', 'PF', 'Giannis', 'Antetokounmpo', '1994-12-06', '6-11', 242, 34, 'None', 'Greece', 'Athens, Greece', 2013); 