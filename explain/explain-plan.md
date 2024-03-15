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


