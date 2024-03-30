[Access methods](#access-methods) 
- [Index only scan](#index-only-scan) 
- [Index scan](#index-scan)
- [Sequential scan](#sequential-scan)
- [Bitmap index scan](#bitmap-index-scan)

[Explain](#explain)

[Costing](#costing)

# Access methods

## Index only scan
Index only scan is a feature in PostgreSQL that allows the database 
to satisfy a query using only the index, without having to 
access the table data. This can significantly improve query 
performance by reducing the amount of I/O required to retrieve the necessary data.

When an index only scan is performed, the database reads the 
necessary data directly from the index, without having to access 
the table itself. This can be beneficial in cases where the index 
contains all the necessary information to satisfy the query, 
and the table data is not required.

## Index scan
An index scan is a method used by the PostgreSQL query planner
to read the rows in a table using an index. This is done when
the query planner determines that it is more efficient to use
an index to read the rows in the table rather than using a
sequential scan.

## Sequential scan
A sequential scan is a method used by the PostgreSQL query planner
to read all the rows in a table in their physical order. This
is done when the query planner determines that it is more efficient
to read all the rows in the table rather than using an index.

A sequential scan can be beneficial when the table is small,
or when the query requires a large portion of the table's data.

## Bitmap index scan
A bitmap index scan is a method used by the PostgreSQL query planner
to combine multiple indexes to satisfy a query. This is done by
creating a bitmap for each index, and then combining the bitmaps
to find the rows that satisfy the query.

A bitmap index scan can be beneficial when the query requires
multiple indexes to be used, and the combination of the indexes
is more efficient than using a single index.

# Explain

The `EXPLAIN` command in PostgreSQL is used to show the execution
plan for a query. This can be useful for understanding how the
query planner is processing a query, and for identifying potential
performance issues.

Example:
```sql
explain analyse
select * from employees;
```
Will produce the following plan:
```
Seq Scan on employees  (cost=0.00..15103.01 rows=1000001 width=10) (actual time=0.015..59.489 rows=1000001 loops=1)
Planning Time: 0.501 ms
Execution Time: 90.914 ms
```
It is using the sequential scan method to read all the rows in the table.
`(cost=0.00..15103.01 rows=1000001 width=10)` shows the initial cost
0.00 and the final cost 15103.01. The startup cost is the estimate how
long it will take to fetch the first row.
The number of rows and the width of the rows.

The actual time is the time it took to execute the query.

The planning time is the time it took to plan the query.

The execution time is the total time it took to execute the query.


# Costing
Basic parameters:
*	**seq_page_cost**		    Cost of a sequential page fetch
*	**random_page_cost**	    Cost of a non-sequential page fetch
*	**cpu_tuple_cost**		    Cost of typical CPU time to process a tuple
*	**cpu_index_tuple_cost**    Cost of typical CPU time to process an index tuple
*	**cpu_operator_cost**	    Cost of CPU time to execute an operator or function
*	**parallel_tuple_cost**     Cost of CPU time to pass a tuple from worker to leader backend
*	**parallel_setup_cost**     Cost of setting up shared memory for parallelism

The default values and descriptions are:

| Parameter  | Default | Description |
|------------|---------|-------------|
|cpu_index_tuple_cost|0.005|Sets the planner's estimate of the cost of processing each index entry during an index scan|
|cpu_operator_cost|0.0025|Sets the planner's estimate of the cost of processing each operator or function call|
|cpu_tuple_cost|0.01|Sets the planner's estimate of the cost of processing each tuple (row)|
|seq_page_cost|1|Sets the planner's estimate of the cost of a sequentially fetched disk page|
|random_page_cost|4|Sets the planner's estimate of the cost of a nonsequentially fetched disk page|
|parallel_tuple_cost|0.1|Sets the planner's estimate of the cost of passing each tuple (row) from worker to leader backend|
|parallel_setup_cost|1000|Sets the planner's estimate of the cost of starting up worker processes for parallel query|


Lookup statistic for pages see pages.md
This query gives us 5103 pages and 1000001 tuples
```sql
select relpages, reltuples from pg_class where relname = 'employees';
```
5103,1000001

Cost calculation formula:

`disk_run_cost = the number of pages X seq_page_cost`

`cpu_run_cost = Total number of records X cpu_tuple_cost`

`total_cost = disk_run_cost + cpu_run_cost`

We can verify the cost manually

Total cost of Seq Scan
= (estimated sequential page reads * seq_page_cost) + 
(estimated rows returned * cpu_tuple_cost)
= (5103 * 1) + (1000001 * 0.01) = 5103 + 10000.01 = 15103.01

[Costsize](https://github.com/postgres/postgres/blob/master/src/backend/optimizer/path/costsize.c)

## Example plans

Query by primary key and retrieve pk, performs index only scan.
All data are in the index, no need to read the table.
```sql
explain analyse
select id from employees where id = 100;

-- Index Only Scan using idx_employees on employees  (cost=0.42..4.44 rows=1 width=4) (actual time=0.158..0.159 rows=1 loops=1)
--   Index Cond: (id = 100)
--   Heap Fetches: 0
-- Planning Time: 0.145 ms
-- Execution Time: 0.185 ms
```

If we add a column to the select list, it will perform an index scan.
`name` is not part of an index, Postgres has to read the table to get the value.
```sql
explain analyse
select id, name from employees where id = 10000;

-- Index Scan using idx_employees on employees  (cost=0.42..8.44 rows=1 width=10) (actual time=0.080..0.082 rows=1 loops=1)
--   Index Cond: (id = 10000)
-- Planning Time: 0.091 ms
-- Execution Time: 0.562 ms
```
