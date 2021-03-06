defmodule GRTag.ContentsTest do
  use GRTag.DataCase, async: true

  import Mock
  import GRTag.{Factory, HTTPFactory}

  alias Ecto.{Changeset, UUID}
  alias Faker.Internet
  alias GRTag.Contents
  alias GRTag.Contents.{Repository, Tag}
  alias Tesla.Client

  describe "get_repository/1" do
    test "returns an the repository with the given id" do
      repository = insert(:repository)
      assert {:ok, fetch_repository = %Repository{}} = Contents.get_repository(repository.id)
      assert fetch_repository.id == repository.id
    end

    test "returns an error if the an repository with the specified id does not exist",
      do: assert({:error, :repository_does_not_exist} == Contents.get_repository(UUID.generate()))
  end

  describe "list_repositories/0" do
    test "returns a list of inserted repositories" do
      number_of_repositories = :random.uniform(10)
      repositories_mapset = number_of_repositories |> insert_list(:repository) |> Enum.map(& &1.id) |> MapSet.new()
      assert {:ok, fetched_repositories} = Contents.list_repositories()
      assert Enum.all?(fetched_repositories, fn %struct{} -> struct == Repository end)
      assert fetched_repositories |> Enum.map(& &1.id) |> MapSet.new() == repositories_mapset
    end

    test "returns a list of inserted repositories when using filters" do
      repository = insert(:repository)
      user = insert(:user)
      tag = insert(:tag, repository: nil, repository_id: repository.id, user: nil, user_id: user.id)
      insert(:repository)

      params = %{"tag_user_id" => user.id, "tag_name" => tag.name}

      assert {:ok, repositories_list} = Contents.list_repositories(params)
      assert Enum.count(repositories_list) == 1
      assert [fetched_repository] = repositories_list
      assert fetched_repository.id == repository.id
    end

    test "returns an error when parameters are invalid for a repository" do
      invalid_filter_attributes = %{"tag_user_id" => 1, "tag_name" => 1}
      assert {:error, changeset = %Changeset{}} = Contents.list_repositories(invalid_filter_attributes)
      assert errors_on(changeset) == %{tag_name: ["is invalid"], tag_user_id: ["is invalid"]}
    end
  end

  describe "create_repository/1" do
    test "should create an repository" do
      attributes = params_for(:repository)
      assert {:ok, %Repository{id: id}} = Contents.create_repository(attributes)
      refute Repository |> Repo.get(id) |> is_nil()
    end

    test "should accept extra options for creating users" do
      repository = insert(:repository)
      attributes = Repository.to_map(repository)

      assert {:ok, %Repository{id: id, github_id: github_id}} =
               Contents.create_repository(attributes, on_conflict: :nothing)

      refute Repository |> Repo.get_by(github_id: github_id) |> is_nil()
      assert Repository |> Repo.get(id) |> is_nil()
    end

    test "returns an error when repository attributes are invalid" do
      invalid_attributes = %{}
      assert {:error, %Ecto.Changeset{}} = Contents.create_repository(invalid_attributes)
    end
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

  describe "get_tag/1" do
    test "returns an the tag with the given id" do
      tag = insert(:tag)
      assert {:ok, fetch_tag = %Tag{}} = Contents.get_tag(tag.id)
      assert fetch_tag.id == tag.id
    end

    test "returns an error if the an tag with the specified id does not exist",
      do: assert({:error, :tag_does_not_exist} == Contents.get_tag(UUID.generate()))
  end

  describe "list_tags/0" do
    test "returns a list of inserted tags" do
      number_of_tags = :random.uniform(10)
      tags_mapset = number_of_tags |> insert_list(:tag) |> Enum.map(& &1.id) |> MapSet.new()
      fetched_tags = Contents.list_tags()
      assert Enum.all?(fetched_tags, fn %struct{} -> struct == Tag end)
      assert fetched_tags |> Enum.map(& &1.id) |> MapSet.new() == tags_mapset
    end
  end

  describe "create_tag/1" do
    test "should create a tag" do
      tag_params = params_with_assocs(:tag)
      assert {:ok, tag = %Tag{id: id}} = Contents.create_tag(tag_params)
      refute Tag |> Repo.get(id) |> is_nil()
    end

    test "should not allow to create duplicate tag names for the same repository" do
      tag_params = params_with_assocs(:tag)
      assert {:ok, tag = %Tag{id: id}} = Contents.create_tag(tag_params)
      assert {:error, changeset = %Changeset{}} = Contents.create_tag(tag_params)
      assert errors_on(changeset) == %{name_repository_id: ["has already been taken"]}
    end
  end

  describe "update_tag/2" do
    test "should edit a tag" do
      tag = insert(:tag, name: "old_name")
      new_name = "new_name"
      change_params = %{name: new_name}

      assert {:ok, tag = %Tag{id: id}} = Contents.update_tag(tag.id, change_params)
      assert tag.name == new_name
    end

    test "returns an error when tag does not exist" do
      invalid_attributes = %{}
      assert {:error, :tag_does_not_exist} = Contents.update_tag(UUID.generate(), invalid_attributes)
    end

    test "returns an error when parameters are invalid" do
      tag = insert(:tag)
      assert {:error, changeset = %Changeset{}} = Contents.update_tag(tag.id, %{name: nil})
      assert errors_on(changeset) == %{name: ["can't be blank"]}
    end
  end

  describe "delete_tag/1" do
    test "should delete a tag" do
      tag = insert(:tag, name: "old_name")
      assert {:ok, tag = %Tag{id: id}} = Contents.delete_tag(tag.id)
      assert Tag |> Repo.get(id) |> is_nil()
    end

    test "returns an error when tag does not exist" do
      invalid_attributes = %{}
      assert {:error, :tag_does_not_exist} = Contents.update_tag(UUID.generate(), invalid_attributes)
    end
  end
end
