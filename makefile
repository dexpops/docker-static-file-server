all: bootstrap

bootstrap:
	docker run --hostname=server01-local --rm --name=consul-server1 -p 8500:8500 -d consul:latest agent -server -ui -bootstrap-expect=3 -client=0.0.0.0 -bind=0.0.0.0 && \
 	docker run --hostname=server02-local --rm --name=consul-server2 -e CONSUL_BIND_INTERFACE=eth0 -d consul agent -server -bootstrap-expect=3 -retry-join=172.17.0.2 && \
	docker run --hostname=server03-local --rm --name=consul-server3 -e CONSUL_BIND_INTERFACE=eth0 -d consul agent -server -bootstrap-expect=3 -retry-join=172.17.0.2

stop:
	docker stop consul-server1 && \
	docker stop consul-server2 && \
	docker stop consul-server3

show-members:
	docker exec -it consul-server1 consul members

