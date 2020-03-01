use Mix.Config

config :GRTag,
  ecto_repos: [GRTag.Repo],
  generators: [binary_id: true],
  github_api_url: "https://api.github.com",
  github_api_token: System.get_env("GITHUB_API_TOKEN")

config :GRTag, GRTagWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5rw8F1g0hrx/mlN6Abts+CLG7W8RYHMv5LkC1AN3yutB1idHKR5RLqMKt8RzFLYY",
  render_errors: [view: GRTagWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GRTag.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

config :GRTag, Oban,
  repo: GRTag.Repo,
  prune: {:maxlen, 10_000},
  queues: [default: 30, importers: 30]

import_config "#{Mix.env()}.exs"
