# https://hub.docker.com/_/ruby
FROM ruby:3.3

WORKDIR /usr/src/app

COPY Gemfile ./
RUN bundle install

COPY . /usr/src/app

CMD ["tail", "-f", "/dev/null"]
