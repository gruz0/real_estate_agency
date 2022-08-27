# Real Estate Agency

[![RuboCop](https://github.com/gruz0/real_estate_agency/actions/workflows/rubocop.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/rubocop.yml)
[![Bundle Audit](https://github.com/gruz0/real_estate_agency/actions/workflows/bundle-audit.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/bundle-audit.yml)
[![Brakeman](https://github.com/gruz0/real_estate_agency/actions/workflows/brakeman.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/brakeman.yml)
[![Maintainability](https://api.codeclimate.com/v1/badges/db0acd56daab29bab9ab/maintainability)](https://codeclimate.com/github/gruz0/real_estate_agency/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/db0acd56daab29bab9ab/test_coverage)](https://codeclimate.com/github/gruz0/real_estate_agency/test_coverage)
[![Security](https://hakiri.io/github/gruz0/real_estate_agency/master.svg)](https://hakiri.io/github/gruz0/real_estate_agency/master)

This project is a database for a real estate agency.

## Development

To run project the first one what you need is:

```bash
make dockerize
```

It builds and runs Docker containers: `app` and `db`.

All of your changes in the project automatically applied to Docker
and you don't need to reload or rebuild container.

The project will be available on `http://localhost:3000/`.

### System dependencies

* Docker
* Docker Compose
* Ruby 2.7 (already installed to Docker)
* Rails 5.2 (already installed to Docker)
* MariaDB 10.0 (as Docker image)

### Configuration

All configuration files stored in `config` directory in the project root path.
You don't need to change it, because these already prepared to run
in the Docker environment.

### Database creation and initialization

```bash
docker-compose exec app rake db:drop db:create db:migrate db:seed
```

## Production

All commands are available from the application directory (eg. `/var/www/real_estate_agency/current`)

###

```bash
RAILS_ENV=production ./bin/rails db:migrate
```

### Create default system administrator

After deploy application to production server you need to create default administrators. The command below will create
the administrators with emails `root@example.com` and `me@example.com` and default password `123456` for each of them.
The first one will have the role `service_admin` and the other will have `admin`.

**NOTE:** Do not forget to create a new administrator after successfully logged in to the web.

```bash
bundle exec rake app:create_admin
```

### Initialize dictionaries with default values

The command below will populate dictionaries (`EstateType`, `EstateProject`, `EstateMaterial`) with default values

```bash
bundle exec rake app:initialize
```

## Tests

### How to run the test suite locally

Run dockerized database:

```bash
make test_db_up
```

Create a test database:

```bash
make test_db_setup
```

Then run all tests:

```bash
make test
```

Or run specific test:

```bash
make test spec/routing/
```

## Docker

The application contains 2 Docker files: `Dockerfile`
and `Dockerfile.real_estate_agency`.

The first one uses by `docker-compose` to build development environment
(or Travis CI builds) and depends on public image called
`gruz0/real_estate_agency` (which builds from `Dockerfile.real_estate_agency`).

To build a new version of public image you should:

1. Run `make docker_build`
   (ensure that you increment version in `Makefile` if some changes happened)
1. Run `docker login` with username and password from hub.docker.com
1. Run `make docker_push` to publish container in hub.docker.com
