defmodule GRTagWeb.UserControllerTest do
  use GRTagWeb.ConnCase

  import GRTag.Factory

  alias Ecto.UUID
  alias GRTag.Accounts.User
  alias GRTag.Repo

  setup %{conn: conn},
    do: {:ok, conn: put_req_header(conn, "accept", "application/json")}

  describe "GET /users/:id" do
    test "should return a specific user", %{conn: conn} do
      user = insert(:user)

      conn = get(conn, Routes.user_path(conn, :show, user.id))
      assert json_response(conn, 200)["data"] == %{"id" => user.id, "username" => user.username}
    end

    test "should return an error if the user does not exist", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :show, UUID.generate()))
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  describe "POST /users" do
    test "should create an user", %{conn: conn} do
      response =
        conn
        |> post(Routes.user_path(conn, :create), user: params_for(:user))
        |> json_response(201)

      assert %User{} = Repo.get(User, response["data"]["id"])
    end

    test "should render errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
