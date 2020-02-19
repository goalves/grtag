use Mix.Config

config :GRTag, GRTag.Repo,
  username: "postgres",
  password: "postgres",
  database: "grtag_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :GRTag, GRTagWeb.Endpoint,
  http: [port: 4002],
  server: false

config :logger, level: :warn
