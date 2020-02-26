defmodule GRTagWeb.ErrorView do
  use GRTagWeb, :view

  def render("404.json", _), do: %{errors: %{detail: "Not Found"}}

  def render("500.json", _), do: %{errors: %{detail: "Internal Server Error"}}
end
