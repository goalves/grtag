defmodule GRTagWeb.RepositoryControllerTest do
  use GRTagWeb.ConnCase

  import GRTag.Factory

  alias Ecto.UUID

  setup %{conn: conn},
    do: {:ok, conn: put_req_header(conn, "accept", "application/json")}

  describe "GET /repositories/:id" do
    test "should return a specific repository", %{conn: conn} do
      repository = insert(:repository)

      conn =
        conn
        |> get(Routes.repository_path(conn, :show, repository.id))
        |> doc(description: "Fetch Repository", operation_id: "fetch_repository")

      assert json_response(conn, 200)["data"] == %{
               "id" => repository.id,
               "description" => repository.description,
               "github_id" => repository.github_id,
               "language" => repository.language,
               "name" => repository.name,
               "url" => repository.url
             }
    end

    test "should return an error if the repository does not exist", %{conn: conn} do
      conn =
        conn
        |> get(Routes.repository_path(conn, :show, UUID.generate()))
        |> doc(
          description: "Fetch Repository fails when repository does not exist",
          operation_id: "fetch_repository_not_exist"
        )

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  describe "GET /repositories" do
    test "should return a list of repositories", %{conn: conn} do
      repositories_number = :random.uniform(10)

      insert_list(repositories_number, :repository)

      conn =
        conn
        |> get(Routes.repository_path(conn, :index))
        |> doc(description: "List Repositories", operation_id: "list_repositories")

      contents = json_response(conn, 200)["data"]
      assert Enum.count(contents) == repositories_number
    end
  end
end
