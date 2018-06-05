.PHONY: help docker_run docker_build docker_push

help:
	@echo 'Available targets:'
	@echo '  make docker_run'
	@echo '  make docker_build'
	@echo '  make docker_push'

docker_run:
	rm -f tmp/pids/server.pid
	docker-compose up --build

docker_build:
	docker build -f Dockerfile.real_estate_agency -t gruz0/real_estate_agency:0.2 .

docker_push:
	docker push gruz0/real_estate_agency
