use Mix.Config

config :gr_tag, github_api_token: "test_token"

config :gr_tag, GRTag.Repo,
  username: "postgres",
  password: "postgres",
  database: "grtag_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :gr_tag, GRTagWeb.Endpoint,
  http: [port: 4002],
  server: false

config :tesla, adapter: Tesla.Mock

config :logger, level: :warn

config :gr_tag, Oban, crontab: false, queues: false, prune: :disabled
