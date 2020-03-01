use Mix.Config

config :GRTag, github_api_token: "test_token"

config :GRTag, GRTag.Repo,
  username: "postgres",
  password: "postgres",
  database: "grtag_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :GRTag, GRTagWeb.Endpoint,
  http: [port: 4002],
  server: false

config :tesla, adapter: Tesla.Mock

config :logger, level: :warn

config :GRTag, Oban, crontab: false, queues: false, prune: :disabled
