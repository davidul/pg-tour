
CREATE TABLE grades (
id serial PRIMARY KEY,
 g int,
 name text 
); 


INSERT INTO grades (g, name )
select random()*100, substring(md5(random()::text ), 0, floor(random()*31)::int)
 from generate_series(0, 500);

VACUUM (ANALYZE, VERBOSE, FULL);

EXPLAIN ANALYZE SELECT id,g FROM grades WHERE g > 80 AND g < 95 ORDER BY g;

