# Create schema
Schema is a namespace.
```sql
    CREATE SCHEMA vehicle_db;
```

# Create Sequence
```sql
CREATE SEQUENCE vehicle_db.armored_vehicle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;    
```

# Create table
```sql
CREATE TABLE vehicle_db.armored_vehicle (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    description VARCHAR(255),
    deployment_date DATE,
    production_date DATE                                     
)
```


# Operators
- Equality  (a = b)
- Not equal (a != b) or (a <> b)
- Greater than (a > b)
- Less than (a < b)
- Greater than or equal (a >= b)
- Less than or equal (a <= b)

Logical operators
- AND
- OR
- NOT
- IN
- BETWEEN
- LIKE
- IS NULL
- IS NOT NULL
- EXISTS
- ALL
- ANY
- SOME
- UNIQUE
- UNION
- UNION ALL
- INTERSECT
- MINUS

# WHERE clause
```sql  
SELECT * FROM vehicle_db.armored_vehicle WHERE name = 'T-90';
```

# Create database
```sql
CREATE DATABASE vehicle_db;
```

# Create Role
Role is a group of privileges. Role can own database objects.
```sql
CREATE ROLE vehicle_admin WITH LOGIN -- can login
    PASSWORD 'admin' -- identified by password
    SUPERUSER -- can do anything
```
SUPERUSER | NOSUPERUSER (default) - you must a superuser to create a superuser role.

# Limit offset
```sql
SELECT * FROM actors LIMIT 5;
SELECT * FROM actors LIMIT 5 offset 5;
```

# Data types
## Boolean

True/False/NULL
TRUE    | FALSE | NULL
'true' 'false' 'null'
```sql
select 'true', TRUE = 'true'
union all
select 't', TRUE = 't'
union all
select 'y', TRUE = 'y'
union all
select 'yes', TRUE = 'yes'
union all
select '1', TRUE = '1';
```

```sql
select 'false', FALSE = 'false'
union all
select 'f', FALSE = 'f'
union all
select 'n', FALSE = 'n'
union all
select 'no', FALSE = 'no'
union all
select '0', FALSE = '0';
```

## Character
CHAR(n) - fixed length, blank padded
VARCHAR(n) - variable length

## Casting
```sql
SELECT CAST('2019-01-01' AS DATE);
SELECT CAST('2019-01-01' AS TIMESTAMP);
SELECT CAST('2019-01-01' AS TIME); --error
SELECT CAST('10' as INTEGER);
SELECT CAST('10.5' as FLOAT);
SELECT CAST('10.5' as DECIMAL);
SELECT CAST('10.5' as NUMERIC);

select '2019-01-01'::DATE;

SELECT '10 minutes'::INTERVAL;
```

## Domain
```sql
create domain my_domain as integer;
create domain my_domain as integer default 5;
create domain positive_integer as integer check (value > 0);
create domain us_postal_code as char(5) check (value ~ '^\d{5}$');
create domain email as varchar(255) check (value ~ '^.+@.+\..+$');

-- create enumeration
create type my_enum as enum ('one', 'two', 'three');
```

# Sequence
```sql
create sequence my_sequence;
select nextval('my_sequence');
select currval('my_sequence');
select setval('my_sequence', 100);
```

```sql
create sequence my_sequence_100 start 100 increment 10;
select nextval('my_sequence_100');
select currval('my_sequence_100');

create sequence my_sequence_small start 100 increment 10 
    minvalue 100 maxvalue 200;
select nextval('my_sequence_small');
select currval('my_sequence_small');
```

Cycle sequence
```sql
create sequence my_sequence_cycle start 100 increment 10 
    minvalue 100 maxvalue 200 cycle;
```

Restart sequence

```sql
alter sequence my_sequence_small restart with 100;
```

# Aggregate functions
```sql
SELECT COUNT(*) FROM actors;
```