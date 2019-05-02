#!/bin/bash
set -eux

Precompiles all assets into static files in production mode
if [ $RAILS_ENV == "production" ]; then
  bundle exec rake assets:precompile;
fi

rm -f tmp/pids/server.pid && rails db:migrate && bundle exec rails s -b '0.0.0.0'
