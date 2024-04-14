# Catalog

Available databases can be listed using the following command:

```sql
select * from pg_database

```

- datname - database name


```sql
select * from pg_class;

```

- relname - table name
- relnamespace - schema
- relkind
  - r = ordinary table, 
  - i = index, 
  - S = sequence, 
  - t = TOAST table,
  - v = view, 
  - m = materialized view, 
  - c = composite type,
  - f = foreign table, 
  - p = partitioned table, 
  - I = partitioned index

```sql
select * from pg_namespace;

```

```sql
select * from pg_tablespace

```