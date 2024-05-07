-- current session pid
select * from pg_backend_pid();

select * from pg_stat_get_activity ( pg_backend_pid() );

-- current statistics timestamp
analyse;
select * from pg_stat_get_snapshot_timestamp ();