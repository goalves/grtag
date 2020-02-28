defmodule GRTag.Contents.Repository do
  use GRTag, :schema

  alias Ecto.Changeset
  alias GRTag.Contents.Tag
  alias GRTag.Github.Starred

  @required_fields [:github_id, :name, :url]
  @fields [:description, :language | @required_fields]

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "repositories" do
    field :github_id, :integer
    field :name, :string
    field :description, :string
    field :url, :string
    field :language, :string

    has_many(:tags, Tag)

    timestamps()
  end

  @spec changeset(%__MODULE__{}, map()) :: Changeset.t()
  def changeset(repository = %__MODULE__{}, attributes) when is_map(attributes) do
    repository
    |> cast(attributes, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:github_id)
  end

  @spec build_map(%Starred{}) :: map()
  def build_map(%Starred{id: id, name: name, description: description, url: url, language: language}) do
    %{github_id: id, name: name, description: description, url: url, language: language}
  end

  @spec query_by_user_tag(any, binary, binary) :: Query.t()
  def query_by_user_tag(queriable, input, user_id) when is_binary(input) and is_binary(user_id) do
    from(repository in queriable,
      left_join: tag in assoc(repository, :tags),
      where: ilike(tag.name, ^"%#{input}%"),
      where: tag.user_id == ^user_id
    )
  end
end
