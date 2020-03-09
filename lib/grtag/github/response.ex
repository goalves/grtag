defmodule GRTag.Github.Response do
  alias GRTag.Github.Link
  alias Tesla.Env

  use TypedStruct

  @ok_status 200

  typedstruct enforce: true do
    field :body, map()
    field :headers, map()
    field :links, %Link{}, enforce: false
    field :url, :string
    field :status, :integer
  end

  @spec parse(Env.t(), fun()) :: %__MODULE__{}
  def parse(%Env{body: body, headers: headers, url: url, status: status}, decoding_function) do
    %__MODULE__{
      body: parse_body(status, body, decoding_function),
      headers: headers,
      links: Link.parse_from_headers(headers),
      url: url,
      status: status
    }
  end

  defp parse_body(@ok_status, body, decoding_function) when is_list(body), do: Enum.map(body, &decoding_function.(&1))
  defp parse_body(@ok_status, body, decoding_function) when is_map(body), do: decoding_function.(body)
  defp parse_body(_, body, _), do: body
end
