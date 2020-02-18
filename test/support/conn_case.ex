defmodule GRTagWeb.ConnCase do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      use Phoenix.ConnTest
      alias GRTagWeb.Router.Helpers, as: Routes

      @endpoint GRTagWeb.Endpoint
    end
  end

  setup tags do
    :ok = Sandbox.checkout(GRTag.Repo)

    unless tags[:async] do
      Sandbox.mode(GRTag.Repo, {:shared, self()})
    end

    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
