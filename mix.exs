defmodule GRTag.MixProject do
  use Mix.Project

  def project do
    [
      app: :GRTag,
      version: "0.1.0",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      dialyzer: [plt_file: {:no_warn, "priv/plts/dialyzer.plt"}],
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  def application do
    [
      mod: {GRTag.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:credo, "~> 1.1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.7", only: [:dev], runtime: false},
      {:bureaucrat, "~> 0.2.5"},
      {:ecto_sql, "~> 3.1"},
      {:ex_machina, "~> 2.4", only: :test},
      {:excoveralls, "~> 0.10", only: :test},
      {:faker, "~> 0.13", only: :test},
      {:jason, "~> 1.0"},
      {:mock, "~> 0.3.0", only: :test},
      {:phoenix_ecto, "~> 4.0"},
      {:phoenix_pubsub, "~> 1.1"},
      {:phoenix, "~> 1.4.11"},
      {:plug_cowboy, "~> 2.0"},
      {:postgrex, ">= 0.0.0"},
      {:sobelow, "~> 0.8", only: :dev},
      {:tesla, "~> 1.3.0"},
      {:typed_struct, "~> 0.1.4"},
      {:oban, "~> 1.1"}
    ]
  end

  defp aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate", "test"]
    ]
  end
end
