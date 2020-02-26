defmodule GRTag.Accounts do
  import Ecto.Query, warn: false

  alias Ecto.{Changeset, Multi}
  alias GRTag.Accounts.User
  alias GRTag.Repo
  alias GRTag.Workers.Importer

  @type user_response :: {:error, :user_does_not_exist} | {:ok, %User{}}
  @type user_change_response :: {:ok, %User{}} | {:error, Changeset.t()}

  @spec get_user(binary) :: user_response
  def get_user(id) when is_binary(id) do
    User
    |> Repo.get(id)
    |> case do
      user = %User{} -> {:ok, user}
      _ -> {:error, :user_does_not_exist}
    end
  end

  @spec create_user(map()) :: user_change_response
  def create_user(attributes) when is_map(attributes) do
    user_attributes = User.params_for(attributes)

    Multi.new()
    |> Multi.insert(:user, user_change(%User{}, user_attributes))
    |> Multi.run(:enqueue_importer, fn _, %{user: user} -> enqueue_importer(user) end)
    |> Repo.transaction()
    |> case do
      {:ok, %{user: user = %User{}}} -> {:ok, user}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  defp enqueue_importer(user = %User{}) do
    %{github_username: user.username}
    |> Importer.new()
    |> Oban.insert()
  end

  defp user_change(user = %User{}, attributes) when is_map(attributes), do: User.changeset(user, attributes)
end
