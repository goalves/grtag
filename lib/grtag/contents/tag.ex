defmodule GRTag.Contents.Tag do
  use GRTag, :schema

  alias Ecto.Changeset
  alias GRTag.Accounts.User
  alias GRTag.Contents.Repository

  @required_fields [:repository_id, :user_id, :name]
  @fields @required_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "tags" do
    field :name, :string

    belongs_to(:user, User, type: :binary_id)
    belongs_to(:repository, Repository, type: :binary_id)

    timestamps()
  end

  @spec changeset(%__MODULE__{}, map()) :: Changeset.t()
  def changeset(tag = %__MODULE__{}, attributes) when is_map(attributes) do
    tag
    |> cast(attributes, @fields)
    |> validate_required(@required_fields)
    |> assoc_constraint(:user)
    |> assoc_constraint(:repository)
    |> unique_constraint(:name_repository_id)
  end
end
