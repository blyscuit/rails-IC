[![Build Status](https://github.com/blyscuit/docs/actions/workflows/deploy_fly.yml/badge.svg)](https://github.com/blyscuit/rails-ic/tree/chore/3-deployment-automation)

## Introduction

Rails Internal Certificate.


## Get Started

### Requirements

- Install ruby and set your local ruby version to `3.0.1`
- Install rails `7.0.1`
- Install node `16.13.2` (For creating web application)

> 📝 If running on Apple M1, to build docker image, please make sure to set platform to AMD64 by `export DOCKER_DEFAULT_PLATFORM=linux/amd64`

### Use Script

```sh
make dev
```

### Manually

```
bundle install
bin/docker-prepare
bin/rails s
```

## Deployment

Staging URL: https://rails-ic-staging.fly.dev/
Production URL: https://rails-ic.fly.dev/

## Documentation

Please check out full documentation on the [wiki](../../wiki).
