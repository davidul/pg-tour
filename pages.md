In PostgreSQL, you can find the size of a table 
including its indexes, toast tables, and free space map 
using the `pg_total_relation_size` function. However, 
this function returns the size in bytes, not in pages.

To get the size in pages, you can divide the 
total size in bytes by the page size. The default page size 
in PostgreSQL is 8KB.

Here's an example of how you can do this:

```sql
SELECT 
    relname AS "Table",
    pg_total_relation_size(relid)::bigint / 8192 AS "Size in Pages"
FROM 
    pg_catalog.pg_statio_user_tables
ORDER BY 
    pg_total_relation_size(relid) DESC;
```

This SQL query will return a list of all user tables 
in the current database, sorted by their total size in 
pages, in descending order. The `pg_statio_user_tables` view 
contains I/O statistics for tables that the current user has access to.