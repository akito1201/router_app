FROM ruby:2.6.5
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client \
    yarn
WORKDIR /var/www/myspot
COPY Gemfile Gemfile.lock /var/www/myspot/
RUN gem install bundler:2.1.4 && bundle install
COPY . .

