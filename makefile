all: destroy bootstrap_cluster build show_members start

bootstrap_cluster:
	docker run --hostname=server01-local --rm --name=consul-server1 -p 8500:8500 -p 8600:8600 -p 8600:8600/udp -d consul:latest agent -server -ui -bootstrap-expect=3 -client=0.0.0.0 -bind=0.0.0.0 -datacenter=yorktown --recursor 8.8.8.8 --recursor 8.8.4.4&& \
 	docker run --hostname=server02-local --rm --name=consul-server2 -e CONSUL_BIND_INTERFACE=eth0 -d consul agent -server -bootstrap-expect=3 -retry-join=172.17.0.2 -datacenter=yorktown && \
	docker run --hostname=server03-local --rm --name=consul-server3 -e CONSUL_BIND_INTERFACE=eth0 -d consul agent -server -bootstrap-expect=3 -retry-join=172.17.0.2 -datacenter=yorktown

destroy:
	docker stop consul-server1 ; \
	docker stop consul-server2 ; \
	docker stop consul-server3 ; \
	docker stop static_file_server

build:
	docker build -t dexpops/docker-static-file-server:latest .

start:
	docker run --rm --name=static_file_server \
	-v ~/Downloads:/var/www/static:ro \
	-e VIRTUAL_HOST=static.karstenjakobsen.dk \
	-e VIRTUAL_PORT=8080 \
	-p 8080:8080 \
	dexpops/docker-static-file-server:latest

show_members:
	docker exec -it consul-server1 consul members
