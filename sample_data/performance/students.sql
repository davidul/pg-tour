--key vs non-key columns

-- make sure to run the container with at least 1gb shared memory
-- docker run --name pg —shm-size=1g -e POSTGRES_PASSWORD=postgres —name pg postgres



CREATE TABLE students (
id serial PRIMARY KEY,
 g int,
 firstname text, 
lastname text, 
middlename text,
address text,
 bio text,
dob date,
id1 int,
id2 int,
id3 int,
id4 int,
id5 int,
id6 int,
id7 int,
id8 int,
id9 int
); 


INSERT INTO students (g,
firstname, 
lastname, 
middlename,
address ,
 bio,
dob,
id1 ,
id2,
id3,
id4,
id5,
id6,
id7,
id8,
id9) 
SELECT
random()*100,
substring(md5(random()::text ),0,floor(random()*31)::int),
substring(md5(random()::text ),0,floor(random()*31)::int),
substring(md5(random()::text ),0,floor(random()*31)::int),
substring(md5(random()::text ),0,floor(random()*31)::int),
substring(md5(random()::text ),0,floor(random()*31)::int),
now(),
random()*100000,
random()*100000,
random()*100000,
random()*100000,
random()*100000,
random()*100000,
random()*100000,
random()*100000,
random()*100000
 from generate_series(0, 50000000);

VACUUM (ANALYZE, VERBOSE, FULL);

EXPLAIN ANALYZE SELECT id,g FROM students WHERE g > 80 AND g < 95 ORDER BY g;

