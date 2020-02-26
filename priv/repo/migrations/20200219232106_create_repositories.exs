defmodule GRTag.Repo.Migrations.CreateRepositories do
  use Ecto.Migration

  def change do
    create table(:repositories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :github_id, :bigint, null: false
      add :name, :string, null: false
      add :description, :text
      add :url, :text, null: false
      add :language, :string
      timestamps()
    end

    create unique_index(:repositories, [:github_id])
  end
end
