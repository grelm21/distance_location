#!/bin/sh -e

./bin/rails db:prepare
./bin/rails tailwindcss:build

exec "$@"
