defmodule GRTag.Contents.Repository do
  use GRTag, :schema

  alias Ecto.Changeset
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
end
