set quiet := true
set shell := ["bash", "-cu", "-o", "pipefail"]

BIN := 'bundle exec ruby -Ilib bin/dotman'

import? 'local.just'

[private]
help:
    just --list --unsorted

init:
    bundle install

run +args:
    {{ BIN }} {{ args }}

test:
    bundle exec rspec
    echo
    echo o coverage/index.html

fmt:
    echo 'Nothing to format'

lint:
    rubocop

fix:
    rubocop -A

build:
    bundle exec rake build

install:
    bundle exec rake install

clean:
    rm -vf pkg/*
