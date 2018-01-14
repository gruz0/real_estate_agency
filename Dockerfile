FROM ruby:2.3.5
MAINTAINER Alexander Kadyrov <gruz0.mail@gmail.com>

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libpq-dev && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install
COPY . /app

EXPOSE 3000
