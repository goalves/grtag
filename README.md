![Continuous Integration](https://github.com/goalves/grtag/workflows/Continuous%20Integration/badge.svg?branch=master)

# GRTag

This repository contains application of the GRTag project. This application allows users to add _Tags_ to _Repositories_ an user has as their favorites on _Github_.

## Dependencies

The application depends on multiple parts to work properly. Even though it is possible to boot up in different ways, the recommended settings are as follows:

- Elixir 1.10-otp22;
- Erlang 22.1;
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

- [Coveralls](https://github.com/parroty/excoveralls): `mix coveralls` for test coverage;
- [Dialyxir](https://github.com/jeremyjh/dialyxir): `mix dialyzer` for static code analysis and spec validation;
- [Sobelow](https://github.com/nccgroup/sobelow): `mix sobelow --config` for static code analysis focused on security and a few performance aspects;
- [Credo](https://github.com/rrrene/credo): `mix credo` for general static code analysis;
- Elixir default Formatter: `mix format --check-formatted` for ensuring codebase is formatted.

## Github API Authorization

Github has a lower request limiting for unauthorized API calls. You can use [Personal Tokens](https://github.com/settings/tokens), adding the ability to fetch public repositories on the list of permissions, to circumvent this issue.

After creating a Personal Token, you can add it as an environment variable when running the application:

```sh
GITHUB_API_TOKEN=previously_generated_token mix phx.server
```

In case none is provided, the application will continue to work without any authorization set.

## Generating API Documentation

To generate the API documentation, you can use the following command:

```sh
API_DOCS=1 mix test
```

This will generate the Markdown file for the API Blueprint format, it is written in the `docs/documentation.md` file.

If you want to generate a readable HTML, you can render this file to a template using [Aglio][https://github.com/danielgtaylor/aglio].

You can install it it using `yarn global add aglio` or `npm install -g aglio`, depending on your package manager of choice. And then run:

```sh
aglio -i docs/documentation.md -o docs/documentation.html
```

And you can check the latest available documentation acessing the `docs/documentation.html` file.

Alternatively, you can use a docker container and mount the correct volumes, but that is better disected in Aglio documentation itself.
