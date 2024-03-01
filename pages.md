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

The structure of a PostgreSQL page is as follows:

- **Page Header**: This is the first part of the page and contains metadata 
about the page, such as the page number, the number of tuples on the page, 
and the free space pointer.

- **Item Identifiers**: These are pointers to the actual tuples. They are stored in 
an array that starts immediately after the page header and grows downwards towards the 
end of the page.

- **Tuples**: The actual data rows. They are stored starting from the end of the page 
and grow upwards towards the start of the page.

- **Free Space**: The space between the item identifiers and the tuples is free 
space that can be used to store new tuples.

The page size in PostgreSQL is typically 8KB, and this 
size includes the page header, item identifiers, tuples, 
and free space. The page size is a compile-time setting 
and can be increased up to 32KB, but this requires 
recompiling PostgreSQL.

Here is a visual representation of a PostgreSQL page:

```
+-----------------+
| Page Header     |
+-----------------+
| Item Identifiers|
| ...             |
+-----------------+
| Free Space      |
+-----------------+
| ...             |
| Tuples          |
+-----------------+
```

The page header is at the top, followed by the item identifiers. The tuples are at the 
bottom, and the free space is in the middle. The item identifiers and tuples grow towards 
each other as more data is added to the page.
