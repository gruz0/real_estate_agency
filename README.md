# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

2.3.5

* System dependencies

* Configuration

* Database creation

```bash
$ docker-compose exec app rake db:drop db:create db:migrate
```

* Database initialization

```bash
$ docker-compose exec app rake db:seed
```

* Database diagram (ERD)

The diagram (`erd.pdf`) will be created after each of use the `rake db:migrate` command.

* How to run the test suite

```bash
$ docker-compose exec app rspec --fail-fast
```

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Docker

The application contains 2 Docker files: `Dockerfile` and `Dockerfile.real_estate_agency`.

The first one uses by `docker-compose` to build development environment (or Travis CI builds) and depends
on public image called `gruz0/real_estate_agency` (which builds from `Dockerfile.real_estate_agency`).

To build a new version of public image you should:

1. Run `make docker_build` (ensure that you increment tag version in `Makefile` if some changes happened)
2. Run `docker login` with username and password from hub.docker.com
3. Run `make docker_push` to publish container in hub.docker.com
