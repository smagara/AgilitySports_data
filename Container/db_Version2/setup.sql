-- Manual sqlcmd entrypoint for running the full V2 database build in order.
-- Primary/authoritative container initialization is defined in docker-compose.yml (init-db-image).
-- Keep this file aligned with compose script order for local/manual execution.

-- 07/24/2026 Sending this up by PR and CD/CD Azure SQL pipeline
-- Overlaying existing database (schemas are all different).

--:r Container/db_version2/security/database/001-create-database.sql
:r Container/db_version2/security/002-security.sql
:r Container/db_version2/schema/101-ddl.V2.schemas.sql
:r Container/db_version2/schema/102-ddl.V2.Sports.sql
:r Container/db_version2/schema/103-ddl.V2.PositionsCodes.sql
:r Container/db_version2/schema/104-ddl.V2.Teams.sql
:r Container/db_version2/schema/105-ddl.V2.Players.sql
:r Container/db_version2/schema/106-ddl.V2.MLBPlayerStats.sql
:r Container/db_version2/schema/107-ddl.V2.NBAPlayerStats.sql
:r Container/db_version2/schema/108-ddl.V2.NFLPlayerStats.sql
:r Container/db_version2/schema/109-ddl.V2.NHLPlayerStats.sql
:r Container/db_version2/schema/115-ddl.V2.Attendance.sql
:r Container/db_version2/schema/120-sprocs.sql
:r Container/db_version2/seed/201-seed_reference_sports.sql
:r Container/db_version2/seed/202-seed_reference_PositionCodes.sql
:r Container/db_version2/seed/203-seed_core_Teams.sql
:r Container/db_version2/seed/204-seed_core_players.sql
:r Container/db_version2/seed/205-seed_stats_MLBPlayerStats.sql
:r Container/db_version2/seed/206-seed_stats_NHLPlayerStats.sql
:r Container/db_version2/seed/207-seed_stats_Attendance.sql
:r Container/db_version2/database/099-final-db-cleanup.sql
