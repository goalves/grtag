defmodule GRTagWeb.ErrorViewTest do
  use GRTagWeb.ConnCase, async: true

  import Phoenix.View

  test "renders 404.json",
    do: assert(render(GRTagWeb.ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}})

  test "renders 500.json",
    do:
      assert(
        render(GRTagWeb.ErrorView, "500.json", []) ==
          %{errors: %{detail: "Internal Server Error"}}
      )
end
