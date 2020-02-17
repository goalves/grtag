use Mix.Config

config :GRTag,
  ecto_repos: [GRTag.Repo],
  generators: [binary_id: true]

config :GRTag, GrtagWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5rw8F1g0hrx/mlN6Abts+CLG7W8RYHMv5LkC1AN3yutB1idHKR5RLqMKt8RzFLYY",
  render_errors: [view: GrtagWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GRTag.PubSub, adapter: Phoenix.PubSub.PG2]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{Mix.env()}.exs"
