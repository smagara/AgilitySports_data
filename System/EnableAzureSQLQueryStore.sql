/* enable Azure SQL query store for historical query research and analysis */
ALTER DATABASE AgilitySports2 SET QUERY_STORE = ON;

ALTER DATABASE AgilitySports2 
SET QUERY_STORE (OPERATION_MODE = READ_WRITE, 
                 CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 3), 
                 DATA_FLUSH_INTERVAL_SECONDS = 900, 
                 INTERVAL_LENGTH_MINUTES = 60, 
                 MAX_STORAGE_SIZE_MB = 100, 
                 QUERY_CAPTURE_MODE = ALL, 
                 SIZE_BASED_CLEANUP_MODE = AUTO);


/* sample usage */
select *
from sys.query_store_query_text
where query_sql_text like '%MLB%'
