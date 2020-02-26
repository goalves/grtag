defmodule GRTag.Factory do
  use ExMachina.Ecto, repo: GRTag.Repo

  alias Ecto.UUID
  alias Faker.{Internet, Lorem}
  alias GRTag.Accounts.User
  alias GRTag.Contents.Repository
  alias GRTag.Github.Starred

  @max_integer 999_999_999

  def user_factory, do: %User{username: Internet.user_name(), id: UUID.generate()}

  def repository_factory do
    %Repository{
      description: Lorem.paragraph(),
      github_id: :random.uniform(@max_integer),
      url: Internet.url(),
      language: Lorem.word(),
      name: Lorem.word()
    }
  end

  def starred_factory do
    %Starred{
      description: Lorem.paragraph(),
      id: :random.uniform(@max_integer),
      language: Lorem.word(),
      languages_url: Internet.url(),
      name: Lorem.word(),
      url: Internet.url()
    }
  end
end
