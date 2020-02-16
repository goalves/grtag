# GRTag

This repository contains application of the GRTag project. This application allows users to add _Tags_ to _Repositories_ an user has as their favorites on _Github_.

## Dependencies

The application depends on multiple parts to work properly. Even though it is possible to boot up in different ways, the recommended settings are as follows:

- Elixir 1.10;
- Postgres 11;
- Docker.

## Setting Up Local Environment

First of all, you need to fetch all dependencies for the application using `mix deps.get`.

We use Docker to set up the container containing the Postgres database, to start it you need to run:

```sh
docker-compose up -d
mix ecto.setup
```

To start the application, you need to run `mix phx.server`.

## Running Tests and Static Code Analysis

All of them should run on CI, but you can run them locally using the following commands:

- `mix coveralls` for test coverage;
- `mix dialyzer` for static code analysis;
- `mix sobelow` for static code analysis focused on security and a few performance aspects;
- `mix credo` for general static code analysis;
