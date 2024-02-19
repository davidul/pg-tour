pg-run:
	docker run --name pg-tour --rm -d -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:alpine

pg-stop:
	docker stop pg-tour

pg-movies:
	docker cp sample_data/movie_database pg-tour:/tmp
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/movie_database.sql
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/actors.sql
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/directors.sql
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/movies.sql
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/movies_actors.sql
	docker exec -it pg-tour psql -U postgres -f /tmp/movie_database/movies_revenues.sql

pg-kill:
	docker kill pg-tour

pg-logs:
	docker logs pg-tour

pg-psql:
	docker exec -it pg-tour psql -U postgres