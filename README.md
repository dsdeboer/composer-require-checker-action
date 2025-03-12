# GitHub Action for `ComposerRequireChecker`

This repo contains a `Dockerfile` to build https://github.com/maglnet/ComposerRequireChecker/ from scratch.
Docker images are also built weekly by a GitHub Actions workflow and are published on
[ghcr.io](https://github.com/dsdeboer/composer-require-checker-action/pkgs/container/composer-require-checker).

## GitHub Action 

You can run a prebuilt image as a GitHub Action as follows:

```yaml
# .github/workflows/check.yml
on: [push, pull_request]
name: Main
jobs:
  composer-require-checker:
    name: ComposerRequireChecker
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: ComposerRequireChecker
      uses: dsdeboer/composer-require-checker-action@main
```

Too pass a custom config file, add this:

```diff
# .github/workflows/check.yml
on: [push, pull_request]
name: Main
jobs:
  composer-require-checker:
    name: ComposerRequireChecker
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: ComposerRequireChecker
      uses: dsdeboer/composer-require-checker-action@main
+      with:
+        config-file: composer-require-checker.js
```

Too pass a custom directory, add this:

```diff
# .github/workflows/check.yml
on: [push, pull_request]
name: Main
jobs:
  composer-require-checker:
    name: ComposerRequireChecker
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: ComposerRequireChecker
      uses: dsdeboer/composer-require-checker-action@main
+      with:
+        working-dir: app
```

## Command line usage

Apart from GitHub Actions, you can run a published Docker image in any given
directory:

```bash
docker run --rm -it -v ${PWD}:/app ghcr.io/dsdeboer/composer-require-checker:4.16.1
```

## Building the image yourself

Review and/or tweak the `Dockerfile` if necessary.

Run
```bash
docker build --build-arg VERSION=4.16.1 --tag composer-require-checker .
```

and be sure to set the build argument `VERSION` to a [valid version number](https://github.com/maglnet/ComposerRequireChecker/tags).

To validate your own image, run 

```bash
docker run --rm -it composer-require-checker --version
```

To use your own image, run

```bash
docker run --rm -it -v ${PWD}:/app composer-require-checker
```

## Credits, Copyright and License

This action is a fork of the original [webfactory/docker-composer-require-checker](https://github.com/webfactory/docker-composer-require-checker)
