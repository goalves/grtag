defmodule GRTagWeb.UserTagControllerTest do
  use GRTagWeb.ConnCase

  import GRTag.Factory

  alias Ecto.UUID
  alias GRTag.Contents.Tag
  alias GRTag.Repo

  setup %{conn: conn},
    do: {:ok, conn: put_req_header(conn, "accept", "application/json")}

  describe "POST /users/:user_id/tags" do
    setup %{conn: conn}, do: %{conn: conn}

    test "should create a tag for an user", %{conn: conn} do
      tag_params = params_with_assocs(:tag)

      response =
        conn
        |> post(Routes.user_tag_path(conn, :create, tag_params.user_id), tag: tag_params)
        |> json_response(201)

      assert %Tag{} = Repo.get(Tag, response["data"]["id"])
    end

    test "should render errors when data is invalid", %{conn: conn} do
      user = insert(:user)
      conn = post(conn, Routes.user_tag_path(conn, :create, user.id), tag: %{})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "PATCH /tags" do
    setup %{conn: conn}, do: %{conn: conn}

    test "should update a tag", %{conn: conn} do
      tag = insert(:tag, name: "old_name")
      new_name = "new_name"
      params = %{name: new_name}

      response =
        conn
        |> patch(Routes.tag_path(conn, :update, tag.id), tag: params)
        |> json_response(200)

      assert %Tag{name: ^new_name} = Repo.get(Tag, response["data"]["id"])
    end

    test "should render errors when data is invalid", %{conn: conn} do
      tag = insert(:tag)
      conn = patch(conn, Routes.tag_path(conn, :update, tag.id), tag: %{name: nil})
      assert json_response(conn, 422)["errors"] != %{}
    end

    test "should return an error if the tag does not exist", %{conn: conn} do
      conn = patch(conn, Routes.tag_path(conn, :update, UUID.generate()), tag: %{})
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  describe "DELETE /tags/:id" do
    setup %{conn: conn}, do: %{conn: conn}

    test "should delete a tag", %{conn: conn} do
      tag = insert(:tag)

      assert conn
             |> delete(Routes.tag_path(conn, :delete, tag.id))
             |> response(204) == ""

      assert Repo.all(Tag) == []
    end

    test "should return an error if the tag does not exist", %{conn: conn} do
      conn = delete(conn, Routes.tag_path(conn, :delete, UUID.generate()))
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end

  describe "GET /tags" do
    test "should return a list of tags", %{conn: conn} do
      tags_number = :random.uniform(10)

      insert_list(tags_number, :tag)

      conn = get(conn, Routes.tag_path(conn, :index))
      contents = json_response(conn, 200)["data"]
      assert Enum.count(contents) == tags_number
    end
  end

  describe "GET /tags/:id" do
    test "should return a specific tag", %{conn: conn} do
      tag = insert(:tag)

      conn = get(conn, Routes.tag_path(conn, :show, tag.id))

      assert json_response(conn, 200)["data"] == %{
               "id" => tag.id,
               "name" => tag.name,
               "user_id" => tag.user_id,
               "repository_id" => tag.repository_id
             }
    end

    test "should return an error if the tag does not exist", %{conn: conn} do
      conn = get(conn, Routes.tag_path(conn, :show, UUID.generate()))
      assert json_response(conn, 404) == %{"errors" => %{"detail" => "Not Found"}}
    end
  end
end
