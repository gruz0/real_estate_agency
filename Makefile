.PHONY: help dockerize shell docker_build docker_push test_db_setup test

TEST_DATABASE_URL="mysql2://root:example@127.0.0.1:3307/real_estate_agency_test"

help:
	@echo 'Available targets:'
	@echo '  make dockerize'
	@echo '  make shell'
	@echo '  make docker_build'
	@echo '  make docker_push'
	@echo '  make test_db_setup'
	@echo '  make test'

dockerize:
	docker-compose down
	docker-compose up --build

shell:
	docker-compose exec app sh

docker_build:
	docker build -f Dockerfile.real_estate_agency -t gruz0/real_estate_agency:0.5 .

docker_push:
	docker push gruz0/real_estate_agency

test_db_up:
	docker compose up db_test

test_db_setup:
	DATABASE_URL=${TEST_DATABASE_URL} bundle exec rake db:drop db:create db:migrate

test:
	DATABASE_URL=${TEST_DATABASE_URL} bundle exec rspec $(filter-out $@,$(MAKECMDGOALS))
