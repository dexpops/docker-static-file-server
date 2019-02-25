all: stop build start

stop:
	docker stop static_file_server

build:
	docker build -t dexpops/docker-static-file-server:latest .

run:
	docker stop static_file_server; \
	docker run --rm --name=static_file_server \
	-v /Users/kj/temp_data:/var/www/static:ro \
	-e VIRTUAL_HOST=static.karstenjakobsen.dk \
	-e VIRTUAL_PORT=8080 \
	-p 8080:8080 \
	dexpops/docker-static-file-server:latest