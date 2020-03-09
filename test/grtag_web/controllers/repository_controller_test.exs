defmodule GRTagWeb.RepositoryControllerTest do
  use GRTagWeb.ConnCase

  import GRTag.Factory

  alias Ecto.UUID

  setup %{conn: conn}, do: {:ok, conn: put_req_header(conn, "accept", "application/json")}

  describe "GET /repositories/:id" do
    test "returns a specific repository", %{conn: conn} do
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

    test "returns an error if the repository does not exist", %{conn: conn} do
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
    test "returns a list of repositories", %{conn: conn} do
      repositories_number = :random.uniform(10)

      insert_list(repositories_number, :repository)

      conn =
        conn
        |> get(Routes.repository_path(conn, :index))
        |> doc(description: "List Repositories", operation_id: "list_repositories")

      contents = json_response(conn, 200)["data"]
      assert Enum.count(contents) == repositories_number
    end

    test "should accept filters", %{conn: conn} do
      repository = insert(:repository)
      user = insert(:user)
      tag = insert(:tag, user: nil, user_id: user.id, repository: nil, repository_id: repository.id)

      conn =
        conn
        |> get(Routes.repository_path(conn, :index), %{tag_user_id: user.id, tag_name: tag.name})
        |> doc(description: "List Repositories with Filters", operation_id: "list_repositories_with_filters")

      contents = json_response(conn, 200)["data"]
      assert Enum.count(contents) == 1
    end

    test "returns an error when filters are invalid", %{conn: conn} do
      conn =
        conn
        |> get(Routes.repository_path(conn, :index), %{tag_user_id: 1, tag_name: 1})
        |> doc(
          description: "List Repositories with Filters with invalid filters",
          operation_id: "list_repositories_with_filters_failed"
        )

      assert json_response(conn, 422)["errors"] == ["tag_name is invalid", "tag_user_id is invalid"]
    end
  end
end
