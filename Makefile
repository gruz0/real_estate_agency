.PHONY: help docker_build docker_push

help:
	@echo 'Available targets:'
	@echo '  make docker_build'
	@echo '  make docker_push'

docker_build:
	docker build -f Dockerfile.real_estate_agency -t gruz0/real_estate_agency:0.1 .

docker_push:
	docker push gruz0/real_estate_agency
