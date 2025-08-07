#!/bin/sh -e

if [ -f tmp/pids/server_1.pid ]; then
  rm tmp/pids/server_1.pid
fi

# ./bin/rails db:prepare
# ./bin/rails tailwindcss:build

bundle exec rails s -b 0.0.0.0 -e development


