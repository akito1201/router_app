#!/bin/sh

RAILS_ENV=production bundle exec rails assets:precompile

rails s -e production