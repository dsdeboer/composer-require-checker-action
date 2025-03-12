#!/bin/sh -l

PROJECT_DIR=${1:-.}
cd "$PROJECT_DIR" || exit
/composer-require-checker/bin/composer-require-checker check --output=text