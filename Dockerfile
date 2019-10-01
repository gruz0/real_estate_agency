FROM gruz0/real_estate_agency:0.4
MAINTAINER Alexander Kadyrov <gruz0.mail@gmail.com>

COPY Gemfile Gemfile.lock /app/
RUN gem install bundler && bundle install
COPY . /app

EXPOSE 3000
CMD ./docker-entrypoint.sh
