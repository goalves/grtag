defmodule GRTag.Github do
  alias GRTag.Github.{Link, Request, Response}
  alias Tesla.Middleware.{BaseUrl, FollowRedirects, Headers, JSON}
  alias Tesla.{Client, Env}

  @github_api_url Application.get_env(:GRTag, :github_api_url)
  @github_api_version "application/vnd.github.v3+json"
  @default_github_api_headers [
    {"Accept", @github_api_version},
    {"User-Agent", "GRTag"}
  ]
  @default_middleware [
    {BaseUrl, @github_api_url},
    JSON,
    FollowRedirects
  ]

  @type url :: binary()
  @type responses :: {:ok, Response.t()} | {:error, any()}

  @spec client :: Client.t()
  def client, do: Tesla.client([headers() | @default_middleware])

  defp headers do
    github_token = Application.get_env(:GRTag, :github_api_token)

    if is_nil(github_token),
      do: {Headers, @default_github_api_headers},
      else: {Headers, [{"Authorization", "token #{github_token}"} | @default_github_api_headers]}
  end

  @spec call(Client.t(), Request.t()) :: responses
  def call(client = %Client{}, request = %Request{method: :index}) do
    client
    |> request_base(request)
    |> request_next(client, request)
  end

  defp request_base(client = %Client{}, request = %Request{method: :index, url: url}) do
    client
    |> Tesla.get(url)
    |> parse_response(request.decoding_function)
  end

  @spec parse_response(Env.result(), fun()) :: responses()
  defp parse_response({:ok, env = %Env{}}, decoding_function), do: Response.parse(env, decoding_function)
  defp parse_response(_, _), do: {:error, :request_error}

  defp request_next(response = %Response{links: nil}, _, _), do: {:ok, response}
  defp request_next(response = %Response{links: %Link{next: nil}}, %Client{}, _), do: {:ok, response}

  defp request_next(response = %Response{links: %Link{next: next_url}}, client = %Client{}, request = %Request{})
       when is_binary(next_url) do
    new_request = %{request | url: next_url}

    with new_response = %Response{} <- request_base(client, new_request),
         do: request_next(%{new_response | body: response.body ++ new_response.body}, client, new_request)
  end

  defp request_next(error = {:error, _}, _, _), do: error
end
