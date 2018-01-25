# Real Estate Agency


[![Build Status](https://travis-ci.org/gruz0/real_estate_agency.svg?branch=master)](https://travis-ci.org/gruz0/real_estate_agency)

This project is a database for a real estate agency.

## Development

To run project the first one what you need is:
```bash
$ docker-compose up --build
```

It builds and runs Docker containers: `app` and `db`.

All of your changes in the project automatically applied to Docker and you don't need to reload or rebuild container.

### System dependencies

* Docker
* Docker Compose
* Ruby 2.3.5 (already installed to Docker)
* Rails 5.1 (already installed to Docker)
* MariaDB 10.0 (as Docker image)

### Configuration

All configuration files stored in `config` directory in the project root path. You don't need to change it, because
these already prepared to run in the Docker environment.

### Database creation

```bash
$ docker-compose exec app rake db:drop db:create db:migrate
```

### Database initialization

```bash
$ docker-compose exec app rake db:seed
```

### Database diagram (ERD)

The diagram (`erd.pdf`) will be created after each of use the `rake db:migrate` command.

## Tests

### How to run the test suite in the Docker container

```bash
$ docker-compose exec app rspec --fail-fast
```

### Travis CI

Application is ready to use Travis CI. Configuration file – `.travis.yml`.

## Docker

The application contains 2 Docker files: `Dockerfile` and `Dockerfile.real_estate_agency`.

The first one uses by `docker-compose` to build development environment (or Travis CI builds) and depends
on public image called `gruz0/real_estate_agency` (which builds from `Dockerfile.real_estate_agency`).

To build a new version of public image you should:

1. Run `make docker_build` (ensure that you increment tag version in `Makefile` if some changes happened)
2. Run `docker login` with username and password from hub.docker.com
3. Run `make docker_push` to publish container in hub.docker.com
