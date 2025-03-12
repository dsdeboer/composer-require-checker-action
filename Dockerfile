FROM php:8-cli-alpine AS base
RUN set -eux \
    && apk add --no-cache libzip icu-libs libintl gettext

FROM base AS build_extensions

RUN set -eux \
    && apk add --no-cache libzip-dev icu-libs icu-dev gettext-dev \
    && docker-php-ext-install gettext zip intl \
    && docker-php-ext-enable gettext zip intl

FROM composer:2 AS staging

RUN apk --no-cache add git

WORKDIR /composer-require-checker
ARG VERSION
ENV COMPOSER_REQUIRE_CHECKER_VERSION=${VERSION}
RUN git clone https://github.com/maglnet/ComposerRequireChecker.git /composer-require-checker
RUN git checkout $VERSION \
    && composer install --no-progress --no-interaction --no-ansi --no-dev --no-suggest --ignore-platform-reqs

FROM base

COPY --from=build_extensions /usr/local/lib/php /usr/local/lib/php
COPY --from=build_extensions /usr/local/etc/php /usr/local/etc/php
COPY --from=staging /composer-require-checker /composer-require-checker

COPY memory.ini /usr/local/etc/php/conf.d/memory.ini

RUN mkdir /app
WORKDIR /app
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

LABEL "com.github.actions.name"="dsdeboer-composer-require-checker"
LABEL "com.github.actions.description"="Analyze composer dependencies and verify that no unknown symbols are used in the sources of a package"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="https://github.com/dsdeboer/composer-require-checker-action"
LABEL "homepage"="https://github.com/maglnet/ComposerRequireChecker"
LABEL "maintainer"="Duncan de Boer <info@dsdeboer.nl>"
