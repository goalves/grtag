defmodule GrtagWeb.ConnCase do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      use Phoenix.ConnTest
      alias GrtagWeb.Router.Helpers, as: Routes

      @endpoint GrtagWeb.Endpoint
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
