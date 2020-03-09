defmodule GRTagWeb.UserController do
  use GRTagWeb, :controller

  alias GRTag.{Accounts, Validator}
  alias GRTag.Accounts.User

  action_fallback GRTagWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with :ok <- Validator.validate_uuid(id),
         {:ok, %User{} = user} <- Accounts.get_user(id),
         do: render(conn, "show.json", user: user)
  end
end
