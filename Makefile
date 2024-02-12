pg-run:
	docker run --rm -it -p 5432:5432 -e POSTGRES_PASSWORD=postgres postgres:alpine
