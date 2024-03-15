

select * from pg_locks;

-- relkind
-- r = ordinary table, i = index, S = sequence, t = TOAST table,
-- v = view, m = materialized view, c = composite type,
-- f = foreign table, p = partitioned table, I = partitioned index
select * from pg_class where relkind = 'r';

-- reltype
select * from pg_type ;

select * from pg_rules;

select * from pg_stats;



