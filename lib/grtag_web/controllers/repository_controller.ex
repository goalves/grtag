defmodule GRTagWeb.RepositoryController do
  use GRTagWeb, :controller

  alias GRTag.{Contents, Validator}
  alias GRTag.Contents.Repository

  action_fallback GRTagWeb.FallbackController

  def index(conn, _) do
    repositories = Contents.list_repositories()
    render(conn, "index.json", repositories: repositories)
  end

  def show(conn, %{"id" => id}) do
    with :ok <- Validator.validate_uuid(id),
         {:ok, %Repository{} = repository} <- Contents.get_repository(id),
         do: render(conn, "show.json", repository: repository)
  end
end
