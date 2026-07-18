-- Manual sqlcmd entrypoint for running the full V2 database build in order.
-- Primary/authoritative container initialization is defined in docker-compose.yml (init-db-image).
-- Keep this file aligned with compose script order for local/manual execution.

:r .\database\001-create-database.sql
:r .\security\002-security.sql
:r .\schema\101-ddl.V2.schemas.sql
:r .\schema\102-ddl.V2.Sports.sql
:r .\schema\103-ddl.V2.PositionsCodes.sql
:r .\schema\104-ddl.V2.Teams.sql
:r .\schema\105-ddl.V2.Players.sql
:r .\schema\106-ddl.V2.MLBPlayerStats.sql
:r .\schema\107-ddl.V2.NBAPlayerStats.sql
:r .\schema\108-ddl.V2.NFLPlayerStats.sql
:r .\schema\109-ddl.V2.NHLPlayerStats.sql
:r .\schema\115-ddl.V2.Attendance.sql
:r .\schema\120-sprocs.sql
:r .\seed\201-seed_reference_sports.sql
:r .\seed\202-seed_reference_PositionCodes.sql
:r .\seed\203-seed_core_Teams.sql
:r .\seed\204-seed_core_players.sql
:r .\seed\205-seed_stats_MLBPlayerStats.sql
:r .\seed\206-seed_stats_NHLPlayerStats.sql
:r .\seed\207-seed_stats_Attendance.sql
:r .\database\099-final-db-cleanup.sql
