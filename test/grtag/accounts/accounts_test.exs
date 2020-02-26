defmodule GRTag.AccountsTest do
  use GRTag.DataCase
  use Oban.Testing, repo: GRTag.Repo

  import GRTag.Factory

  alias Ecto.UUID
  alias GRTag.Accounts
  alias GRTag.Accounts.User
  alias GRTag.Workers.Importer

  describe "get_user/1" do
    test "should return an the user with the given id" do
      user = insert(:user)
      assert {:ok, fetch_user = %User{}} = Accounts.get_user(user.id)
      assert fetch_user.id == user.id
    end

    test "should return an error if the an user with the specified id does not exist",
      do: assert({:error, :user_does_not_exist} == Accounts.get_user(UUID.generate()))
  end

  describe "create_user/1" do
    @invalid_attributes %{}

    test "should create an user" do
      attributes = params_for(:user)
      assert {:ok, %User{id: id}} = Accounts.create_user(attributes)
      refute User |> Repo.get(id) |> is_nil()
    end

    test "should enqueue a job to import user repositories" do
      attributes = params_for(:user)
      assert {:ok, %User{id: id, username: username}} = Accounts.create_user(attributes)
      refute User |> Repo.get(id) |> is_nil()
      assert_enqueued(worker: Importer, args: %{github_username: username})
    end

    test "should return an error when user attributes are invalid",
      do: assert({:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attributes))
  end
end
