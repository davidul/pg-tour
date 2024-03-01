select * from employees;

explain select * from employees;
explain analyse select * from employees where id = 1;

-- Index Scan using employees_pkey on employees  (cost=0.42..8.44 rows=1 width=10) (actual time=0.048..0.050 rows=1 loops=1)
--   Index Cond: (id = 1)
-- Planning Time: 0.573 ms
-- Execution Time: 0.105 ms


-- Estimated startup cost: 0.42
-- Estimated total cost: 8.44
-- Estimated rows: 1
-- Estimated average width (in bytes) : 10
-- Cost is measured in arbitrary units established by the planner.
-- It is used to compare different plans.
-- The actual value of the cost is not important.

SHOW seq_page_cost;
SHOW random_page_cost;
SHOW cpu_tuple_cost;
SHOW cpu_index_tuple_cost;
SHOW cpu_operator_cost;
SHOW effective_cache_size;
SHOW parallel_setup_cost;
SHOW parallel_tuple_cost;
