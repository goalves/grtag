defmodule GRTagWeb.TagView do
  use GRTagWeb, :view

  alias GRTag.Contents.Tag

  def render("show.json", %{tag: tag = %Tag{}}),
    do: %{data: render_one(tag, __MODULE__, "tag.json")}

  def render("index.json", %{tags: tags}) when is_list(tags),
    do: %{data: render_many(tags, __MODULE__, "tag.json")}

  def render("tag.json", %{tag: tag = %Tag{}}),
    do: %{id: tag.id, name: tag.name, user_id: tag.user_id, repository_id: tag.repository_id}
end
