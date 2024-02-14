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

## FETCH
```sql
SELECT * FROM actors FETCH FIRST 5 ROWS ONLY;
SELECT * FROM actors FETCH FIRST ROW ONLY;
SELECT * FROM actors FETCH FIRST 5 ROWS ONLY offset 5;
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

## Numeric
- SMALLINT 2 bytes
- INTEGER 4 bytes
- BIGINT 8 bytes
- DECIMAL(p, s) - exact numeric
- NUMERIC(p, s) - exact numeric
- REAL - 4 bytes
- DOUBLE PRECISION - 8 bytes
- SMALLSERIAL - auto incrementing integer
- SERIAL - auto incrementing integer
- BIGSERIAL - auto incrementing integer

## Decimal
Decimal(p, s) - p is precision, s is scale
```sql
SELECT 123.456::DECIMAL(5, 2);
```

Precision is the total number of digits in the number.
Scale is the number of digits to the right of the decimal point.


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
## COUNT
```sql
SELECT COUNT(*) FROM actors;
```
Distinct
```sql
select count(movies.movie_length) from movies;
select count(distinct movies.movie_length) from movies;
```
## SUM
```sql
select sum(revenues_domestic), sum(revenues_international) from movies_revenues;

select sum(distinct revenues_domestic), sum(revenues_international) from movies_revenues;
```

## MIN/MAX
```sql
select min(revenues_domestic), max(revenues_domestic) from movies_revenues;
```

## GREATEST/LEAST
```sql
select greatest(1, 2, 3, 4, 5), least(1, 2, 3, 4, 5);
```

# Date time datatypes
- DATE
- TIME
  - with time zone
  - without time zone
- TIMESTAMP
- INTERVAL

```sql
SHOW DATESTYLE ; --ISO, MDY
SET DATESTYLE TO 'ISO, DMY';
```

## String to date
TO_DATE function
TO_DATE(string, format)
```sql
SELECT '2019-01-01'::DATE;
```
TO_TIMESTAMP function
TO_TIMESTAMP(string, format)
```sql
SELECT TO_TIMESTAMP('2019-01-01 12:00:00', 'YYYY-MM-DD HH24:MI:SS');
```

## Date to string
TO_CHAR function
TO_CHAR(date, format)

select current_timestamp;

```sql  
SELECT TO_CHAR(NOW(), 'YYYY-MM-DD HH24:MI:SS');
```

## Date construction functions
```sql
select make_date(2019, 1, 1);
select make_time(12, 30, 0);
select make_timestamp(2019, 1, 1, 12, 30, 0);
select make_interval(0, 0, 0, 0, 0, 10);
```

# GROUP BY
```sql
select movie_lang, count(*) from movies group by movie_lang;
select movie_lang, age_certificate, avg(movie_length)
from movies group by movie_lang, age_certificate order by movie_lang;
```
## HAVING

# JOINS

# UNION
```sql
select * from movies where movie_lang = 'English'
union all
select * from movies where movie_lang = 'Spanish';
```

```sql
create table t1 (col1 int, col2 int);
create table t2 (col3 int);
insert into t1 values (1, 2), (3, 4);
insert into t2 values (5), (6);
select col1, col2 from t1
union
select col3, null from t2;
```