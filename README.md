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
