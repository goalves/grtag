defmodule GRTagWeb.FallbackController do
  use GRTagWeb, :controller

  alias GRTagWeb.{ChangesetView, ErrorView}

  require Logger

  @not_found_resource_errors [:user_does_not_exist, :repository_does_not_exist]

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("404.json")
  end

  for resource_error <- @not_found_resource_errors,
      do: def(call(conn, {:error, unquote(resource_error)}), do: call(conn, {:error, :not_found}))

  def call(conn, error) do
    %{private: %{phoenix_controller: controller, phoenix_action: action}, body_params: body_params} = conn

    Logger.error(
      "Route was called and did not match anything in controller or fallback. Controller:#{inspect(controller)}. Method: #{
        inspect(action)
      }. Parameters: #{inspect(body_params)} The error that was sent was: #{inspect(error)}."
    )

    conn
    |> put_status(:internal_server_error)
    |> put_view(ErrorView)
    |> render("500.json")
  end
end
