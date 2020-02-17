defmodule GRTag.Application do
  use Application

  def start(_type, _args) do
    children = [
      GRTag.Repo,
      GrtagWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: GRTag.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    GrtagWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
