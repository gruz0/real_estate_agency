# Real Estate Agency CRM

[![RuboCop](https://github.com/gruz0/real_estate_agency/actions/workflows/rubocop.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/rubocop.yml)
[![Bundle Audit](https://github.com/gruz0/real_estate_agency/actions/workflows/bundle-audit.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/bundle-audit.yml)
[![Brakeman](https://github.com/gruz0/real_estate_agency/actions/workflows/brakeman.yml/badge.svg)](https://github.com/gruz0/real_estate_agency/actions/workflows/brakeman.yml)

## System dependencies

* Docker
* Docker Compose
* Ruby 2.7
* Rails 6.0

## Development

Start development database:

```bash
make docker-dev-db-up
```

Install dependencies and configure database:

```bash
make setup
```

Populate database with sample data:

```bash
make docker-dev-db-seed
```

Start the web server:

```bash
make run
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

Credentials:

* Login: `root@example.com`
* Password: `123456`

## Tests

Run test database:

```bash
make docker-test-db-up
```

Create tables:

```bash
make docker-test-db-setup
```

Apply migrations (if you need):

```bash
make docker-test-db-migrate
```

Run all tests:

```bash
make test
```

Or specific test:

```bash
make test spec/routing/
```

## Production

### How to create administrators

Create service admin and regular admin:

```bash
bundle exec rake app:create_admin
```

**Service Admin:**

* Login: `root@example.com`
* Password: `123456`
* Role: `service_admin`

**Regular Admin:**

* Login: `me@example.com`
* Password: `123456`
* Role: `admin`

**NOTE:** Do not forget to change passwords!

### Initialize dictionaries with default values

Populate dictionaries (`EstateType`, `EstateProject`, `EstateMaterial`) with
default values:

```bash
bundle exec rake app:initialize
```

## Questions & Answers

### How to clean application data

```bash
make docker-clean
bin/rails log:clear tmp:clear
```
