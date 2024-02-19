# ACID
Atomicity, Consistency, Isolation, Durability

ACID is an acronym that stands for Atomicity, 
Consistency, Isolation, and Durability. 
These are a set of properties that guarantee that 
database transactions are processed reliably.

1. **Atomicity**: This property ensures that all operations 
within a transaction are completed successfully; if not, the 
transaction is aborted at the failure point and previous operations 
are rolled back to their former state.

2. **Consistency**: This property ensures that a transaction 
brings the database from one valid state to another, 
maintaining database invariants: any data written to the 
database must be valid according to all defined rules, 
including constraints, cascades, triggers, and any combination thereof.

3. **Isolation**: This property ensures that concurrent 
execution of transactions leaves the database in the same 
state that would have been obtained if the transactions 
were executed sequentially.

4. **Durability**: This property ensures that once a 
transaction has been committed, it will remain committed 
even in the case of a system failure. This is usually achieved 
by storing the transaction into a transaction log that can be 
replayed to recreate the system state right before the failure.

A database management system that implements ACID properties 
can be trusted for a broad range of tasks, from simple 
record changes to complex transactions.

In addition to the ACID properties, there are other 
important properties and concepts related to database transactions:

1. **Concurrency Control**: This is the process of managing simultaneous operations without conflicting with each another. It is essential for the correct functioning of a database system where multiple transactions are being executed simultaneously and independently.

2. **Deadlock Management**: Deadlocks are a condition where two or more transactions are waiting indefinitely for each other to release resources. A good database transaction system should have mechanisms to prevent, detect and manage deadlocks.

3. **Transaction Log**: This is a history of all actions related to database modifications. It is used to ensure durability and atomicity of transactions. In case of a system failure, the transaction log is used to recover the database to a consistent state.

4. **Savepoints**: These are markers within a transaction that allow for partial rollbacks. Instead of rolling back the entire transaction, you can roll back to a specific savepoint, discarding only part of the transaction.

5. **Nested Transactions**: These are transactions that exist within the context of a larger transaction. If a nested transaction fails, it can be rolled back without affecting the larger transaction.

6. **Distributed Transactions**: These are transactions that 
involve multiple network hosts. They can be more complex 
due to the need to coordinate across different systems, 
but they allow for transactions that span multiple databases 
or other resources.

7. **Isolation Levels**: These define how and when the changes 
made by one transaction are visible to other concurrent transactions. 
The isolation level can impact the performance and concurrency of a system. The four standard isolation levels are Read Uncommitted, Read Committed, Repeatable Read, and Serializable.

# Transaction
A transaction is a sequence of operations performed as a single
logical unit of work. A transaction can be composed of one or
more individual operations, but it is treated as a single unit
of work. A transaction is a fundamental concept in database
management systems and is used to maintain the integrity of
the database.

Transaction lifecycle:
1. **Begin**: The transaction begins. This is the point at 
which the database management system starts tracking the 
operations that are part of the transaction.
2. **Execute**: The operations that are part of the transaction 
are executed. These operations can include reads, writes, updates, 
and other database operations.
3. **Commit**: The transaction is committed. This means that the 
changes made by the transaction are made permanent and visible 
to other transactions. Once a transaction is committed, its changes 
are durable and cannot be undone.
4. **Rollback**: The transaction is rolled back. This means that 
the changes made by the transaction are undone, and the database 
is restored to its state before the transaction began. This can 
happen if the transaction encounters an error or if it is 
explicitly rolled back by the application.

# WAL
The transaction log in PostgreSQL, also known as the write-ahead 
log (WAL), serves a crucial role in maintaining data integrity. 
Its primary purposes are:

1. **Recovery**: In the event of a system crash or power failure, 
the transaction log provides a means to recover the database to a 
consistent state. It does this by replaying the changes recorded 
in the log.

2. **Durability**: The transaction log helps ensure the durability 
property of ACID-compliant transactions. When a transaction is 
committed, its changes are written to the transaction log before 
they're written to the main database. This ensures that even if a 
crash occurs immediately after a commit, the changes can be recovered.

3. **Concurrency and Performance**: The transaction log allows 
PostgreSQL to flush data pages to disk less frequently, 
which can significantly improve performance. It also enables 
efficient implementation of multi-version concurrency control (MVCC).

4. **Replication and Standby Servers**: The transaction log can 
be streamed to standby servers in real time, allowing them to 
maintain an up-to-date copy of the database for high availability 
or read scaling.

In summary, the transaction log is a critical component of 
PostgreSQL that ensures data integrity, aids in recovery 
from failures, and can improve performance and concurrency.

# FSM
The Free Space Map (FSM) in PostgreSQL is a data structure that tracks the available space in 
each table and index. It is used to quickly find a page with enough space to 
insert a new tuple without having to scan the entire table or index.

When a row is deleted or updated (which is essentially a delete followed by an 
insert in PostgreSQL), the space it occupied becomes available for future inserts. 
The FSM keeps track of these spaces to optimize insert operations.

The FSM is stored separately from the main data file of the table or index. 
It is automatically updated by PostgreSQL as rows are inserted, updated, and deleted. 
The size of the FSM is configurable, and it can have an impact on the performance 
of the database. If the FSM is too small, it may not track all available spaces, 
causing unnecessary disk I/O. If it's too large, it can waste memory.

In summary, the Free Space Map is an essential component of PostgreSQL's storage 
system, helping to manage and optimize the use of disk space.

The PostgreSQL Free Space Map (FSM) is a crucial component that 
helps maintain efficient storage allocation and performance within your database. 
Here's a breakdown of its key aspects:

**Purpose:**

- Tracks available space within each relation (table or index) in a PostgreSQL database.
- Improves performance by efficiently locating free space for new data insertions.
- Minimizes fragmentation by prioritizing contiguous free space allocation.

**Structure:**

- Each relation has a separate FSM file (`relation_fileno_fsm`) stored alongside its main data file.
- Organized as a tree structure:
    - Leaf nodes: Represent individual pages (blocks) with their available free space.
    - Non-leaf nodes: Aggregate information from their children, indicating maximum free space.
- Uses one byte per page to store free space information (rounded to 1/256 of page size).

**Operations:**

- **Insert:** Uses FSM to find a page with enough free space for new data.
- **Update:** FSM is updated to reflect changes in space usage after updates.
- **VACUUM:** Reclaims unused space and updates FSM accordingly.

**Benefits:**

- Efficient space allocation leads to faster writes and improved performance.
- Minimizes fragmentation for better read performance and space utilization.
- Helps identify potential free space issues and optimize table storage.

**Considerations:**

- Accessing FSM information usually requires superuser privileges or specific roles.
- Free space information is not exact and may have slight discrepancies.
- For heavily updated tables, VACUUM needs to be run periodically to keep FSM accurate.

**Useful tools:**

- `pg_freespacemap` extension provides functions to examine FSMs.
- `VACUUM` and `CLUSTER` commands manage and optimize free space.

**Overall, understanding the PostgreSQL Free Space Map helps you leverage 
efficient storage management and optimize your database performance.**