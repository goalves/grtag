defmodule GRTagWeb.UserView do
  use GRTagWeb, :view

  alias GRTag.Accounts.User

  def render("show.json", %{user: user = %User{}}),
    do: %{data: render_one(user, __MODULE__, "user.json")}

  def render("user.json", %{user: user = %User{}}),
    do: %{id: user.id, username: user.username}
end
