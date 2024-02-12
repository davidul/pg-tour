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
