# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :GRTag,
  ecto_repos: [GRTag.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :GRTag, GrtagWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5rw8F1g0hrx/mlN6Abts+CLG7W8RYHMv5LkC1AN3yutB1idHKR5RLqMKt8RzFLYY",
  render_errors: [view: GrtagWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: GRTag.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
