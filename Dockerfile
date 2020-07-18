FROM gruz0/real_estate_agency:0.5
MAINTAINER Alexander Kadyrov <gruz0.mail@gmail.com>

COPY --chown=user Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.1.4
RUN bundle install --jobs 20 --retry 5

COPY --chown=user . ./

EXPOSE 3000
CMD ./docker-entrypoint.sh
