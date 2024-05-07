select * from pg_stat_io;
select * from pg_statio_all_tables;
select * from pg_statio_user_tables;
select * from pg_statio_all_indexes;
select * from pg_statio_user_indexes;
select * from pg_statio_all_sequences;
select * from pg_statio_user_sequences;


select distinct pg_stat_io.backend_type from pg_stat_io;

explain (analyze, buffers) select * from pg_stat_io;

show shared_buffers ;
show track_io_timing ;
set track_io_timing = on;