defmodule GRTag.Github.ResponseTest do
  use GRTag.DataCase, async: true

  alias Ecto.UUID
  alias Tesla.Env
  alias GRTag.Github.{Link, Response}

  @default_headers [{"key", "value"}]

  describe "parse/1" do
    test "returns a response structure from a tesla env" do
      env = env_fixture()

      response = Response.parse(env, &decoding_function_mock/1)
      assert %Response{} = response
      assert response.body == env.body
      assert response.headers == env.headers
      assert response.links == nil
      assert response.status == env.status
      assert response.url == env.url
    end

    test "returns a response structure containing links from the headers" do
      user_id = UUID.generate()
      next_url = "https://api.github.com/user/#{user_id}/starred?page=2"
      last_url = "https://api.github.com/user/#{user_id}/starred?page=4"
      headers_with_link = [{"link", "<#{next_url}>; rel=\"next\", <#{last_url}>; rel=\"last\""}]

      env = env_fixture(headers_with_link)
      assert %Response{links: link = %Link{}} = Response.parse(env, &decoding_function_mock/1)
      assert link.last == last_url
      assert link.next == next_url
    end
  end

  defp env_fixture(headers \\ @default_headers) do
    %Env{
      body: %{},
      headers: headers,
      status: 200,
      url: Faker.Internet.url()
    }
  end

  defp decoding_function_mock(body), do: body
end
