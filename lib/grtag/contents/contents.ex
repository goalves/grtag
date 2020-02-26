defmodule GRTag.Contents do
  import Ecto.Query, warn: false

  alias Ecto.{Changeset, Multi}
  alias GRTag.Contents.{Repository, Tag}
  alias GRTag.Github.{Response, Starred}
  alias GRTag.{Github, Repo}

  @type repository_response :: {:ok, %Repository{}} | {:error, :repository_does_not_exist}
  @type repository_change_response :: {:ok, %Repository{}} | {:error, Changeset.t()}

  @type tag_response :: {:ok, %Tag{}} | {:error, :tag_does_not_exist}
  @type tag_change_response :: {:ok, %Tag{}} | {:error, Changeset.t()}

  @spec get_repository(binary) :: repository_response
  def get_repository(id) when is_binary(id) do
    Repository
    |> Repo.get(id)
    |> case do
      repository = %Repository{} -> {:ok, repository}
      _ -> {:error, :repository_does_not_exist}
    end
  end

  @spec list_repositories :: [%Repository{}]
  def list_repositories, do: Repo.all(Repository)

  @spec create_repository(map()) :: repository_change_response
  @spec create_repository(map(), keyword()) :: repository_change_response
  def create_repository(attributes, insert_options \\ []) when is_map(attributes) do
    repository_attributes = Repository.params_for(attributes)

    %Repository{}
    |> Repository.changeset(repository_attributes)
    |> Repo.insert(insert_options)
  end

  @spec import_user_repositories(binary) :: {:ok, [%Repository{}]} | {:error, any()}
  def import_user_repositories(github_username) when is_binary(github_username) do
    client = Github.client()

    Multi.new()
    |> Multi.run(:fetch, fn _, _ -> request_repositories(client, github_username) end)
    |> Multi.run(:repositories, fn _, %{fetch: response} -> insert_all_repositories(response) end)
    |> Repo.transaction()
    |> case do
      {:ok, %{repositories: repositories}} -> {:ok, repositories}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  defp request_repositories(client = %Tesla.Client{}, github_username) when is_binary(github_username),
    do: Starred.user_starred(client, github_username)

  defp build_repositories(%Response{body: starred_repositories}) when is_list(starred_repositories),
    do: Enum.map(starred_repositories, fn repository -> repository |> Repository.build_map() end)

  defp insert_all_repositories(response = %Response{}) do
    response
    |> build_repositories()
    |> Enum.with_index()
    |> Enum.reduce(Multi.new(), fn {attributes, index}, acc ->
      Multi.run(acc, {:repository, index}, fn _, _ -> create_repository(attributes, on_conflict: :nothing) end)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, map} -> {:ok, map |> Map.to_list() |> Keyword.values()}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  @spec get_tag(binary) :: tag_response
  def get_tag(id) when is_binary(id) do
    Tag
    |> Repo.get(id)
    |> case do
      tag = %Tag{} -> {:ok, tag}
      _ -> {:error, :tag_does_not_exist}
    end
  end

  @spec list_tags :: [%Tag{}]
  def list_tags, do: Repo.all(Tag)

  @spec create_tag(map()) :: tag_change_response
  def create_tag(attributes) when is_map(attributes) do
    tag_attributes = Tag.params_for(attributes)

    %Tag{}
    |> tag_change(tag_attributes)
    |> Repo.insert()
  end

  @spec update_tag(binary, map()) :: tag_response | tag_change_response
  def update_tag(id, changes) when is_binary(id) and is_map(changes) do
    changes_map = Tag.params_for(changes, remove_extras: true)

    Multi.new()
    |> Multi.run(:get, fn _, _ -> get_tag(id) end)
    |> Multi.update(:update, fn %{get: tag = %Tag{}} -> tag_change(tag, changes_map) end)
    |> Repo.transaction()
    |> case do
      {:ok, %{update: updated_tag = %Tag{}}} -> {:ok, updated_tag}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  @spec delete_tag(binary) :: tag_response
  def delete_tag(id) when is_binary(id) do
    Multi.new()
    |> Multi.run(:get, fn _, _ -> get_tag(id) end)
    |> Multi.delete(:delete, fn %{get: tag = %Tag{}} -> tag end)
    |> Repo.transaction()
    |> case do
      {:ok, %{delete: deleted_tag = %Tag{}}} -> {:ok, deleted_tag}
      {:error, _, reason, _} -> {:error, reason}
    end
  end

  def tag_change(tag = %Tag{}, changes) when is_map(changes), do: Tag.changeset(tag, changes)
end
