defmodule GRTag.Application do
  use Application

  def start(_type, _args) do
    children = [
      GRTag.Repo,
      GRTagWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: GRTag.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GRTagWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
