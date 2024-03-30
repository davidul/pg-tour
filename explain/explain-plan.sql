explain (analyse, buffers)
select * from employees;

--Seq Scan on employees  (cost=0.00..15103.01 rows=1000001 width=10) (actual time=0.015..59.489 rows=1000001 loops=1)
--Planning Time: 0.501 ms
--Execution Time: 90.914 ms

create index idx_employees on employees (id);

explain analyse
select id from employees where id = 100;

-- Index Only Scan using idx_employees on employees  (cost=0.42..4.44 rows=1 width=4) (actual time=0.158..0.159 rows=1 loops=1)
--   Index Cond: (id = 100)
--   Heap Fetches: 0
-- Planning Time: 0.145 ms
-- Execution Time: 0.185 ms

explain analyse
select id from employees where id > 10000;

-- Seq Scan on employees  (cost=0.00..17603.01 rows=989407 width=4) (actual time=0.387..68.094 rows=990001 loops=1)
--   Filter: (id > 10000)
--   Rows Removed by Filter: 10000
-- Planning Time: 0.082 ms
-- Execution Time: 94.723 ms

explain analyse
select id from employees where id < 10000;

-- Index Only Scan using idx_employees on employees  (cost=0.42..305.80 rows=10593 width=4) (actual time=0.133..2.779 rows=9999 loops=1)
--   Index Cond: (id < 10000)
--   Heap Fetches: 0
-- Planning Time: 0.193 ms
-- Execution Time: 3.526 ms

explain (analyse, verbose )
select id, name from employees where id = 10000;

-- Index Scan using idx_employees on employees  (cost=0.42..8.44 rows=1 width=10) (actual time=0.080..0.082 rows=1 loops=1)
--   Index Cond: (id = 10000)
-- Planning Time: 0.091 ms
-- Execution Time: 0.562 ms

explain (verbose, analyse, buffers)
select id, name from employees where id > 10000;

-- Seq Scan on public.employees  (cost=0.00..17603.01 rows=989407 width=10) (actual time=1.361..77.415 rows=990001 loops=1)
-- "  Output: id, name"
--   Filter: (employees.id > 10000)
--   Rows Removed by Filter: 10000
--   Buffers: shared hit=5103
-- Planning Time: 0.236 ms
-- Execution Time: 109.683 ms

explain (verbose, analyse, buffers)
select id, name from employees where name = 'John';

-- Gather  (cost=1000.00..11311.94 rows=6 width=10) (actual time=38.440..41.921 rows=0 loops=1)
-- "  Output: id, name"
--   Workers Planned: 2
--   Workers Launched: 2
--   Buffers: shared hit=5103
--   ->  Parallel Seq Scan on public.employees  (cost=0.00..10311.34 rows=2 width=10) (actual time=19.948..19.948 rows=0 loops=3)
-- "        Output: id, name"
--         Filter: (employees.name = 'John'::text)
--         Rows Removed by Filter: 333334
--         Buffers: shared hit=5103
--         Worker 0:  actual time=10.058..10.058 rows=0 loops=1
--           Buffers: shared hit=1054
--         Worker 1:  actual time=11.746..11.746 rows=0 loops=1
--           Buffers: shared hit=1216
-- Planning:
--   Buffers: shared hit=8
-- Planning Time: 0.123 ms
-- Execution Time: 41.943 ms

explain (verbose, analyse, buffers)
select id, name from employees where id < 100 and name = 'John';

-- Index Scan using idx_employees on public.employees  (cost=0.42..10.53 rows=1 width=10) (actual time=0.043..0.043 rows=0 loops=1)
-- "  Output: id, name"
--   Index Cond: (employees.id < 100)
--   Filter: (employees.name = 'John'::text)
--   Rows Removed by Filter: 99
--   Buffers: shared hit=4
-- Planning:
--   Buffers: shared hit=4
-- Planning Time: 0.265 ms
-- Execution Time: 0.069 ms
