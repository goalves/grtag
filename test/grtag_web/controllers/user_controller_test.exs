defmodule GRTagWeb.UserControllerTest do
  use GRTagWeb.ConnCase

  import GRTag.Factory

  alias Ecto.UUID
  alias GRTag.Accounts.User
  alias GRTag.Repo

  setup %{conn: conn},
    do: {:ok, conn: put_req_header(conn, "accept", "application/json")}

  describe "GET /users/:id" do
    test "returns a specific user", %{conn: conn} do
      user = insert(:user)

      conn =
        conn
        |> get(Routes.user_path(conn, :show, user.id))
        |> doc(description: "Fetch User", operation_id: "fetch_user")

      assert json_response(conn, 200)["data"] == %{"id" => user.id, "username" => user.username}
    end

    test "returns an error if the user does not exist", %{conn: conn} do
      conn =
        conn
        |> get(Routes.user_path(conn, :show, UUID.generate()))
        |> doc(description: "Fetch User fails when user does not exist", operation_id: "fetch_user_not_exist")

      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  describe "POST /users" do
    test "should create an user", %{conn: conn} do
      response =
        conn
        |> post(Routes.user_path(conn, :create), user: params_for(:user))
        |> doc(description: "Create User", operation_id: "create_user")
        |> json_response(201)

      assert %User{} = Repo.get(User, response["data"]["id"])
    end

    test "should render errors when data is invalid", %{conn: conn} do
      conn =
        conn
        |> post(Routes.user_path(conn, :create), user: %{})
        |> doc(
          description: "Create User when parameters are invalid",
          operation_id: "create_user_failed"
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
