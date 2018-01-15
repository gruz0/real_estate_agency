# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

```bash
$ docker-compose exec app rake db:create
```

* Database initialization

* Database diagram (ERD)

The diagram must be created after each of use the `db:migrate` command:
```bash
$ docker-compose exec app bundle exec erd
```

This command will generate the file `erd.pdf` in the project directory.

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
