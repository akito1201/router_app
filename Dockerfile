FROM ruby:2.6.5
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn
WORKDIR /myspot
COPY Gemfile Gemfile.lock /myspot/
RUN gem install bundler:2.1.4 && bundle install

