defmodule GRTag.Github.Link do
  use TypedStruct

  @link_key "link"
  @next_pattern "rel=\"next\""
  @last_pattern "rel=\"last\""
  @prev_pattern "rel=\"prev\""
  @first_pattern "rel=\"first\""
  @links_split_pattern ", "
  @unique_link_regex ~r{<?(.+)>; (.+)}

  typedstruct do
    field :prev, :string
    field :first, :string
    field :next, :string
    field :last, :string
  end

  @spec parse_from_headers(list()) :: t() | nil
  def parse_from_headers(list_of_headers) when is_list(list_of_headers) do
    link = Enum.find_value(list_of_headers, &find_link_on_headers/1)

    if is_nil(link),
      do: nil,
      else: parse_link(link)
  end

  defp parse_link(links_text) when is_binary(links_text) do
    parsed_header = String.split(links_text, @links_split_pattern, trim: true)
    next = parsed_header |> Enum.find(&String.contains?(&1, @next_pattern)) |> clean_link()
    last = parsed_header |> Enum.find(&String.contains?(&1, @last_pattern)) |> clean_link()
    prev = parsed_header |> Enum.find(&String.contains?(&1, @prev_pattern)) |> clean_link()
    first = parsed_header |> Enum.find(&String.contains?(&1, @first_pattern)) |> clean_link()

    %__MODULE__{next: next, last: last, prev: prev, first: first}
  end

  defp find_link_on_headers({@link_key, links}), do: links
  defp find_link_on_headers(_), do: false

  defp clean_link(string) when is_binary(string) do
    [_, url, _] = Regex.run(@unique_link_regex, string)
    url
  end

  defp clean_link(nil), do: nil
end
