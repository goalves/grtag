defmodule GRTagWeb.TagController do
  use GRTagWeb, :controller

  alias GRTag.{Contents, Validator}
  alias GRTag.Contents.Tag

  action_fallback GRTagWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with :ok <- Validator.validate_uuid(id),
         {:ok, tag = %Tag{}} <- Contents.get_tag(id),
         do: render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag}) do
    with :ok <- Validator.validate_uuid(id),
         {:ok, tag = %Tag{}} <- Contents.update_tag(id, tag) do
      conn
      |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    with :ok <- Validator.validate_uuid(id),
         {:ok, %Tag{}} <- Contents.delete_tag(id),
         do: send_resp(conn, :no_content, "")
  end

  def create(conn, %{"user_id" => user_id, "tag" => tag_params}) do
    params = Map.put(tag_params, "user_id", user_id)

    with {:ok, tag = %Tag{}} <- Contents.create_tag(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def index(conn, _) do
    tags = Contents.list_tags()
    render(conn, "index.json", tags: tags)
  end
end
