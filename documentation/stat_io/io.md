[pg_stat_io](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-IO-VIEW)

database level
select datid, tup_fetched, tup_returned, tup_inserted, tup_updated from pg_stat_database;

Live/dead tuples
select n_dead_tup, n_live_tup from pg_stat_all_tables;
select n_live_tup, n_dead_tup from pg_stat_user_tables;


Backend type:
```sql
select distinct pg_stat_io.backend_type from pg_stat_io;
```

object type:
relation - permanent table or index
temporary - temporary table or index

context:
normal - normal operation, uses shared buffers
vacuum - vacuum operation, outside of shared buffers
bulkread - large io operation, outside of shared buffers
bulkwrite - large io operation, outside of shared buffers

reads/writes:
in number of operations, not bytes

read_time/write_time:
need to switch on track_io_timing

writebacks:
sending data from kernel to OS. File system cache managed
by kernel.

writeback_time:
time spent in writeback

extends:
number of blocks extended

extend_time:
time spent in extending

op_bytes:
size of the page (chunk)

hits:
number of hits in shared buffers

evictions:
number of evictions from shared buffers

reuses:
number of reuses in shared buffers

fsync/fsync_time:
number of fsync operations and time spent in fsync

stats_reset:
time of last reset

shared_buffers = 128MB - caching data
work_mem = 4MB - sorting and hashing
maintenance_work_mem = 64MB - maintenance operations
effective_cache_size = 4GB - planner estimates

pg_buffer_cache extension
CREATE EXTENSION pg_buffercache;

# Background Writer
Separate process that writes dirty shared buffers to disk.

Configuration:
bgwriter_delay (integer)
bgwriter_lru_maxpages (integer)
bgwriter_lru_multiplier (floating point)
bgwriter_flush_after (integer)

# Checkpoints


