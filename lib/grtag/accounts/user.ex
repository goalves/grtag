defmodule GRTag.Accounts.User do
  use GRTag, :schema

  alias Ecto.Changeset

  @required_fields [:username]
  @fields @required_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :username, :string

    timestamps()
  end

  @spec changeset(%__MODULE__{}, map()) :: Changeset.t()
  def changeset(user = %__MODULE__{}, attributes) when is_map(attributes) do
    user
    |> cast(attributes, @fields)
    |> validate_required(@required_fields)
  end
end
