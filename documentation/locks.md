# Locks

- Table level locks
- Row level locks
- Page level locks
- Deadlocks
- Advisory locks

Explicit locking - LOCK

Lock modes
- ACCESS SHARE 
- ROW SHARE 
- ROW EXCLUSIVE 
- SHARE UPDATE EXCLUSIVE
- SHARE 
- SHARE ROW EXCLUSIVE 
- EXCLUSIVE 
- ACCESS EXCLUSIVE

```sql
select pid,
       usename,
       pg_blocking_pids(pid) as blocked_by,
       query                 as blocked_query
from pg_stat_activity
where cardinality(pg_blocking_pids(pid)) > 0;
```

```sql
select l.locktype, 
       l.relation, 
       l.database, 
       l.pid, 
       l.mode,
       c.relname, 
       n.nspname
from pg_locks l, pg_class c, pg_namespace n
where 
    c.oid = l.relation
and n.nspname = 'public'
and n.oid = c.relnamespace;
```