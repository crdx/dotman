set quiet

BIN := 'bundle exec ruby -Ilib bin/dotman'

import? 'internal.just'

[private]
help:
    just --list --unsorted

# build gem
build:
    bundle exec rake build

# remove built gems
clean:
    rm -vf pkg/*

# build and install the gem globally to the system
install:
    bundle exec rake install

# run the gem's binary
run +args:
    {{ BIN }} "{{ args }}"

# run tests
test:
    bundle exec rspec
    echo
    echo o coverage/index.html

# run linter
lint:
    rubocop

# fix lint errors
fix:
    rubocop -a
