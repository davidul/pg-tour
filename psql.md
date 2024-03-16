-d dbname - database name
-h hostname - database server host or socket directory
-U username - database user name

psql -h localhost:5432 -U postgres -d postgres
docker exec -it postgres psql -U postgres

\d - list of tables, views, and sequences
\d+ - extended list of tables
\dt - list of tables
\d[table_name] - list of columns of a table
\set ECHO_HIDDEN on - output query

\dn - namespace (schema) list
\dy - event trigger list
\df - function list
\du - user list
\dp - access privileges
\l - database list
\dv - view list