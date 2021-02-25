#!/bin/sh

RAILS_ENV=production rails assets:precompile

rails s -e production