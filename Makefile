.DEFAULT_GOAL := help

BUNDLE_EXEC := bundle exec
DOCKER_COMPOSE := docker compose

help: # Show this help
	@egrep -h '\s#\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: # Setup project
	@bin/setup

test: # Run tests
	@RAILS_ENV=test ${BUNDLE_EXEC} rake factory_bot:lint
	@RAILS_ENV=test ${BUNDLE_EXEC} rspec $(filter-out $@,$(MAKECMDGOALS))

run: # Run the web server
	@bin/rails s

docker-up: # Start Docker containers
	@${DOCKER_COMPOSE} up

docker-down: # Stop Docker containers
	@${DOCKER_COMPOSE} down

docker-dev-db-up: # Run development database
	@${DOCKER_COMPOSE} up db

docker-dev-db-setup: # Set up development database
	@bin/rails db:prepare

docker-dev-db-migrate: # Migrate development database
	@bin/rails db:migrate

docker-dev-db-seed: # Populate development database with sample data
	@bin/rails db:seed

docker-test-db-up: # Run test database
	@${DOCKER_COMPOSE} up db_test

docker-test-db-setup: # Set up test database
	@RAILS_ENV=test bin/rails db:prepare

docker-test-db-migrate: # Migrate test database
	@RAILS_ENV=test bin/rails db:migrate

docker-clean: # Remove all Docker data
	@${DOCKER_COMPOSE} down
	@${DOCKER_COMPOSE} rm --force --stop --volumes
