defmodule GRTag.ContentsTest do
  use GRTag.DataCase

  import Mock
  import GRTag.{Factory, HTTPFactory}

  alias Ecto.UUID
  alias Faker.Internet
  alias GRTag.Contents
  alias GRTag.Contents.Repository
  alias Tesla.Client

  describe "get_repository/1" do
    test "should return an the repository with the given id" do
      repository = insert(:repository)
      assert {:ok, fetch_repository = %Repository{}} = Contents.get_repository(repository.id)
      assert fetch_repository.id == repository.id
    end

    test "should return an error if the an repository with the specified id does not exist",
      do: assert({:error, :repository_does_not_exist} == Contents.get_repository(UUID.generate()))
  end

  describe "create_repository/1" do
    @invalid_attributes %{}

    test "should create an repository" do
      attributes = params_for(:repository)
      assert {:ok, %Repository{id: id}} = Contents.create_repository(attributes)
      refute Repository |> Repo.get(id) |> is_nil()
    end

    test "should accept extra options for creating users" do
      repository = insert(:repository)
      attributes = Map.drop(repository, [:__meta__, :__struct__])

      assert {:ok, %Repository{id: id, github_id: github_id}} =
               Contents.create_repository(attributes, on_conflict: :nothing)

      refute Repository |> Repo.get_by(github_id: github_id) |> is_nil()
      assert Repository |> Repo.get(id) |> is_nil()
    end

    test "should return an error when repository attributes are invalid",
      do: assert({:error, %Ecto.Changeset{}} = Contents.create_repository(@invalid_attributes))
  end

  describe "import_user_repositories/1" do
    test "should create a repository after fetching from github" do
      username = Internet.user_name()
      user_starred_success = user_starred_success()
      {:ok, %{body: [body]}} = user_starred_success

      with_mocks [
        {Tesla, [], get: fn _, _ -> user_starred_success end},
        {Tesla, [], client: fn _ -> %Client{} end}
      ] do
        assert {:ok, [repository = %Repository{}]} = Contents.import_user_repositories(username)
        assert repository.github_id == body["id"]
        assert Repository |> Repo.all() |> Enum.count() == 1
      end
    end
  end
end
