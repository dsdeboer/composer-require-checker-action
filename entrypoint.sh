#!/bin/sh -l

PROJECT_DIR=${1:-.}
if [ "$PROJECT_DIR" = "--version" ]; then
  /composer-require-checker/bin/composer-require-checker check --version
  exit 0;
fi

CONFIG_FILE=${2}

cd "$PROJECT_DIR" || exit

/composer-require-checker/bin/composer-require-checker check --output=text $CONFIG_FILE