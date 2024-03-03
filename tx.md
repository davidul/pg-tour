# Transactions

A **transaction** is a sequence of operations performed as a single logical unit of work. 
A transaction is a fundamental concept in database management systems and is used to maintain the 
integrity of the database. 
A transaction is a set of operations that are executed as a single unit. If any of the 
operations fail, the entire transaction 
is rolled back, and the database is restored to its original state. 
This ensures that the database remains in a consistent state, even in the presence of failures.

Every transaction is identified by a unique transaction ID (XID).
VirtualTransactionId (also called virtualXID or vxid). It is backend/id.

The function `pg_lock_status()`.

Get the database from
```sql
select * from pg_database;
```

Lock Wait Event	Description
- advisory	Waiting to acquire an advisory user lock.
- applytransaction	Waiting to acquire a lock on a remote transaction being applied by a logical replication subscriber.
extend	Waiting to extend a relation.
frozenid	Waiting to update pg_database.datfrozenxid and pg_database.datminmxid.
object	Waiting to acquire a lock on a non-relation database object.
page	Waiting to acquire a lock on a page of a relation.
relation	Waiting to acquire a lock on a relation.
spectoken	Waiting to acquire a speculative insertion lock.
transactionid	Waiting for a transaction to finish.
tuple	Waiting to acquire a lock on a tuple.
userlock	Waiting to acquire a user lock.
virtualxid	Waiting to acquire a virtual transaction ID lock; see Section 74.1.

Transaction settings:
```sql
SHOW transaction isolation level ;
SHOW transaction_read_only;
SHOW transaction_deferrable;
```

Transaction isolation levels:
- Read Committed (default) - A statement can only see rows committed before it began.
- Repeatable Read - A statement can only see rows committed before it began.
- Serializable - A statement can only see rows committed before it began.

SET TRANSACTION SNAPSHOT 'snapshot_id';
pg_export_snapshot() returns text;