defmodule GRTagWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: GRTagWeb

      import Plug.Conn
      alias GRTagWeb.Router.Helpers, as: Routes
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/grtag_web/templates",
        namespace: GRTagWeb

      import Phoenix.Controller, only: [get_flash: 1, get_flash: 2, view_module: 1]

      alias GRTagWeb.Router.Helpers, as: Routes
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
