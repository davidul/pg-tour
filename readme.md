Sample data:
 - Movie Database
 - Northwind - [diagram](https://brucebauer.info/assets/ITEC3610/Northwind/Northwind-Sample-Database-Diagram.pdf)
 - Performance
   - Analyze
   - Explain
   - Vacuum
   - Parameters

LATERAL Join ?

- [Create schema](#Create-schema)
- [Create Sequence](#Create-Sequence)
- [Create table](#Create-table)
- [Operators](#Operators)
- [WHERE clause](#WHERE-clause)
- [Create database](#Create-database)
- [Create Role](#Create-Role)
- [Limit offset](#Limit-offset)
- [FETCH](#FETCH)
- [Data types](#Data-types)
- [Domain](#Domain)
- [Sequence](#Sequence)
- [Aggregate functions](#Aggregate-functions)
- [Date time datatypes](#Date-time-datatypes)
- [String to date](#String-to-date)
- [Date to string](#Date-to-string)
- [Date construction functions](#Date-construction-functions)
- [GROUP BY](#GROUP-BY)
- [HAVING](#HAVING)
- [JOINS](#JOINS)
- [INNER JOIN](#INNER-JOIN)
- [LEFT JOIN](#LEFT-JOIN)
- [UNION](#UNION)
- [Arrays](#Arrays)
- [Ranges](#Ranges)

- ROW COnstructor

# Create schema
Schema is a namespace.
```sql
    CREATE SCHEMA sample;
```

Drop schema
```sql
    DROP SCHEMA sample;
```

Drop schema with cascade (drop all objects in the schema)
```sql
    DROP SCHEMA sample CASCADE;
```

Show search path, the order in which PostgreSQL will look for objects.

```sql
SHOW search_path ;
```

# Create Sequence

Temporary sequence is valid only in current session - TEMPORARY (TEMP).


```sql
CREATE SEQUENCE IF NOT EXISTS sample.armored_vehicle_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;    
```

# Create table
```sql
CREATE TABLE sample.armored_vehicle (
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

ANY returns true if any of the subquery values meet the condition.
```sql
SELECT * FROM northwind.public.categories WHERE category_name = ANY (
    'Beverages', 'Condiments', 'Confections');
```

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
## INNER JOIN
In PostgreSQL, the `INNER JOIN` keyword selects records that 
have matching values in both tables. Here's a basic example:

```sql
SELECT table1.column1, table2.column2 
FROM table1 
INNER JOIN table2 
ON table1.matching_column = table2.matching_column;
```

In this example, `table1` and `table2` are the names of the 
tables you want to join. `column1` and `column2` are the names 
of the columns you want to select. `matching_column` is the 
column that both tables have in common, 
which PostgreSQL will use to combine the tables.

Let's say you have two tables, `orders` and `customers`, and you 
want to list all the orders along with the customer information. 
You could do this with an `INNER JOIN` like so:

```sql
SELECT orders.order_id, customers.customer_name, customers.address 
FROM orders 
INNER JOIN customers 
ON orders.customer_id = customers.customer_id;
```

This will return a table that includes the `order_id` from the `orders` table and the `customer_name` and `address` from the `customers` table, for all orders where the `customer_id` in the `orders` table matches the `customer_id` in the `customers` table.
```sql
select * from movies inner join 
    revenues on movies.movie_id = revenues.movie_id;
```

INNER JOIN with USING, if they have same column name
```sql  
select * from movies inner join 
    revenues using (movie_id);
```

## LEFT JOIN
In PostgreSQL, the `LEFT JOIN` keyword returns all 
records from the left table (table1), and the matched 
records from the right table (table2). The result is NULL 
on the right side, if there is no match.

Here's a basic example:

```sql
SELECT table1.column1, table2.column2
FROM table1
LEFT JOIN table2
ON table1.matching_column = table2.matching_column;
```

In this example, `table1` and `table2` are the names 
of the tables you want to join. `column1` and `column2` 
are the names of the columns you want to select. `matching_column` 
is the column that both tables have in common, which PostgreSQL 
will use to combine the tables.

Let's say you have two tables, `orders` and `customers`, 
and you want to list all the orders along with the customer 
information, including orders that don't have a customer. 
You could do this with a `LEFT JOIN` like so:

```sql
SELECT orders.order_id, customers.customer_name, customers.address
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id;
```

This will return a table that includes the `order_id` 
from the `orders` table and the `customer_name` and `address` 
from the `customers` table, for all orders. 
If an order doesn't have a matching `customer_id` in 
the `customers` table, the `customer_name` and `address` will be NULL.

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

# Arrays

In PostgreSQL, an array is a user-defined data type that represents a 
collection of elements of a single data type. Arrays can be used to 
store multiple values in a single column.

Here's how you can create, insert, and select data from arrays:

1. **Create a table with array columns:**
```sql
CREATE TABLE test_array (
    id SERIAL PRIMARY KEY,
    numbers INTEGER[],
    words TEXT[]
);
```
In this example, `numbers` is an array of integers and `words` is 
an array of text.

2. **Insert data into the array columns:**
```sql
INSERT INTO test_array (numbers, words) 
VALUES ('{1,2,3}', '{"one", "two", "three"}');
```
Here, we're inserting an array of integers into the `numbers` 
column and an array of text into the `words` column.

3. **Select data from the array columns:**
```sql
SELECT * FROM test_array;
```
This will return all rows from the `test_array` table.

4. **Access individual elements of an array:**
```sql
SELECT numbers[1], words[2] FROM test_array;
```
This will return the first element from the `numbers` 
array and the second element from the `words` array.

Remember that array indices in PostgreSQL start from 1, not 0.

Array is a collection of elements of the same data type.
```sql
create table t (col1 int[], col2 text[]);
insert into t values ('{1, 2, 3}', '{"one", "two", "three"}');
select col1[1], col2[1] from t;
```

You can update the values in an array column in PostgreSQL using the `UPDATE` 
statement along with the array index. Here's an example:

```sql
UPDATE test_array
SET numbers[1] = 10, words[2] = 'ten'
WHERE id = 1;
```

In this example, we're updating the first element of the `numbers` 
array to `10` and the second element of the `words` array to `'ten'` 
for the row where `id` is `1`.

Remember that array indices in PostgreSQL start from 1, not 0.

In PostgreSQL, you can't directly delete an element from 
an array. However, you can achieve this by creating a new 
array that excludes the element you want to remove.

Here's an example of how you can do this:

```sql
UPDATE test_array
SET numbers = array_remove(numbers, 10)
WHERE id = 1;
```

In this example, we're creating a new array for the `numbers` column that excludes the number `10`. The `array_remove` function takes two arguments: the original array and the element to remove. It returns a new array that excludes all instances of the element to remove.

Remember that this will remove all instances of the number `10` from the `numbers` array. If you want to remove an element at a specific position, you would need to use a different approach, such as using the `array_cat` function to concatenate two subarrays that exclude the element at the specific position.

In PostgreSQL, you can concatenate two 
arrays using the `||` operator. Here's an example:

```sql
SELECT ARRAY[1,2,3] || ARRAY[4,5,6];
```

This will return a new array: `{1,2,3,4,5,6}`.

## Ranges
In PostgreSQL, a range is a data type that represents a range 
of values of an element type. It can be discrete ranges 
(such as all integer values 1 through 10) or continuous ranges 
(such as all real numbers from 0 to 1).

Ranges can be used to simplify queries and improve performance 
for range-based queries. For example, instead of having two 
separate columns for start date and end date, you can have 
a single range column that represents the duration.

Here's an example of how you can create a table with a range column:

```sql
CREATE TABLE schedule (
    id SERIAL PRIMARY KEY,
    duration TSRANGE
);
```

In this example, `duration` is a range of timestamps. 
You can insert data into this table like this:

```sql
INSERT INTO schedule (duration)
VALUES ('[2022-01-01 14:30, 2022-01-01 15:30)');
```

This inserts a range from 14:30 to 15:30 on 2022-01-01.

You can also query this data using range operators. 
For example, to find all schedules that contain a specific time:

```sql
SELECT * FROM schedule
WHERE duration @> '2022-01-01 15:00'::TIMESTAMP;
```

This will return all rows where the `duration` 
range contains the timestamp '2022-01-01 15:00'.

- INT4RANGE - range of integers
- INT8RANGE - range of big integers
- NUMRANGE - range of numeric values
- DATERANGE - range of dates
- TSRANGE - range of timestamps
- TSTZRANGE - range of timestamps with time zones

# Tablespace
Specifies alternate location on the file system where the data is stored.
```sql
CREATE TABLESPACE my_tablespace LOCATION '/mnt/data';
```
