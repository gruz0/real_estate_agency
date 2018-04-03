FROM gruz0/real_estate_agency:0.2
MAINTAINER Alexander Kadyrov <gruz0.mail@gmail.com>

COPY Gemfile Gemfile.lock /app/
RUN bundle install
RUN yarn install
COPY . /app

EXPOSE 3000
