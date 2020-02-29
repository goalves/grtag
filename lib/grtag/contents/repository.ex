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
  def build_map(%Starred{id: id, name: name, description: description, url: url, language: language}),
    do: %{github_id: id, name: name, description: description, url: url, language: language}

  @spec filters(any, map) :: {:ok, EctoQuery.t()} | {:error, Changeset.t()}
  def filters(queriable, params) do
    with {:ok, filters} <- Query.parse_filters(@acceptable_filters, params),
         do: {:ok, apply_filters(queriable, filters)}
  end

  defp apply_filters(queriable, %{tag_name: tag_name, tag_user_id: tag_user_id}),
    do: query_by_user_tag(queriable, tag_name, tag_user_id)

  defp apply_filters(queriable, _), do: queriable

  @spec query_by_user_tag(any, binary, binary) :: EctoQuery.t()
  def query_by_user_tag(queriable, tag_name, tag_user_id) when is_binary(tag_name) and is_binary(tag_user_id) do
    from(repository in queriable,
      left_join: tag in assoc(repository, :tags),
      where: ilike(tag.name, ^"%#{tag_name}%"),
      where: tag.user_id == ^tag_user_id
    )
  end
end
