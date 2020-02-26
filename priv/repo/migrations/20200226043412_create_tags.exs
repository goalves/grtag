defmodule GRTag.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :user_id, references(:users, type: :binary_id), null: false
      add :repository_id, references(:repositories, type: :binary_id), null: false
      add :name, :string, null: false

      timestamps()
    end

    create index(:tags, ["lower(name)"])
    create unique_index(:tags, [:name, :repository_id])
  end
end
