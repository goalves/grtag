defmodule GRTagWeb.RepositoryView do
  use GRTagWeb, :view

  alias GRTag.Contents.Repository

  def render("show.json", %{repository: repository = %Repository{}}),
    do: %{data: render_one(repository, __MODULE__, "repository.json")}

  def render("index.json", %{repositories: repositories}) when is_list(repositories),
    do: %{data: render_many(repositories, __MODULE__, "repository.json")}

  def render("repository.json", %{repository: repository = %Repository{}}) do
    %{
      id: repository.id,
      github_id: repository.github_id,
      name: repository.name,
      description: repository.description,
      url: repository.url,
      language: repository.language
    }
  end
end
