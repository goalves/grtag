defmodule GRTagWeb.ChangesetView do
  use GRTagWeb, :view

  alias Ecto.Changeset

  def render("error.json", %{changeset: %Changeset{errors: changeset_errors}}) do
    errors = Enum.map(changeset_errors, fn {field, detail} -> "#{field} #{render_detail(detail)}" end)
    %{errors: errors}
  end

  @spec render_detail({binary(), list()}) :: binary()
  def render_detail({message, values}) when is_list(values),
    do: Enum.reduce(values, message, fn {k, v}, acc -> String.replace(acc, "%{#{k}}", to_string(v)) end)
end
