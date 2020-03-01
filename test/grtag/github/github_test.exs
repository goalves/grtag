defmodule GRTag.GithubTest do
  use GRTag.DataCase

  import Mock
  import GRTag.HTTPFactory

  alias Ecto.UUID
  alias GRTag.Github
  alias GRTag.Github.{Request, Response}

  describe "client/0" do
    setup do
      token = "test_token"
      Application.put_env(:GRTag, :github_api_token, token)
      [token: token]
    end

    @github_api_url Application.get_env(:GRTag, :github_api_url)
    @github_api_version "application/vnd.github.v3+json"
    @github_api_headers [
      {"Accept", @github_api_version},
      {"User-Agent", "GRTag"}
    ]
    @tesla_headers_module Tesla.Middleware.Headers
    @tesla_base_url_module Tesla.Middleware.BaseUrl

    test "should return a new client with correct base url" do
      assert client = %Tesla.Client{} = Github.client()
      assert {@tesla_base_url_module, _, [base_url]} = find_middleware(client, @tesla_base_url_module)
      assert base_url == @github_api_url
    end

    @tag :capture_log
    test "should return a new client with correct headers without authorization" do
      Application.delete_env(:GRTag, :github_api_token)
      assert client = %Tesla.Client{} = Github.client()
      assert {@tesla_headers_module, _, [headers]} = find_middleware(client, @tesla_headers_module)
      assert headers == @github_api_headers
    end

    test "should return a new client with correct headers when github_api_token is set", %{token: token} do
      assert client = %Tesla.Client{} = Github.client()
      assert {@tesla_headers_module, _, [headers]} = find_middleware(client, @tesla_headers_module)
      assert headers == [{"Authorization", "token #{token}"} | @github_api_headers]
    end

    defp find_middleware(%Tesla.Client{pre: pre}, module),
      do: Enum.find(pre, fn {tesla_module, _, _} -> tesla_module == module end)
  end

  describe "call/2" do
    setup do: %{client: Github.client(), url: Faker.Internet.url()}

    test "should return a response structure on successful request", %{client: client, url: url} do
      {:ok, success_response} = success()
      request = %Request{method: :index, url: url, decoding_function: &decoding_function_mock/1}

      with_mock Tesla, get: fn _, _ -> {:ok, success_response} end do
        assert {:ok, %Response{status: status, body: body}} = Github.call(client, request)
        assert status == success_response.status
        assert body == success_response.body
      end
    end

    test "should return a response structure on unsucessful request", %{client: client, url: url} do
      {:ok, bad_request} = bad_request()
      request = %Request{method: :index, url: url, decoding_function: &decoding_function_mock/1}

      with_mock Tesla, get: fn _, _ -> {:ok, bad_request} end do
        assert {:ok, %Response{status: status, body: body}} = Github.call(client, request)
        assert status == bad_request.status
        assert body == bad_request.body
      end
    end

    test "should return an error when request fails for any other reason", %{client: client, url: url} do
      request = %Request{method: :index, url: url, decoding_function: &decoding_function_mock/1}

      with_mock Tesla, get: fn _, _ -> tesla_connection_error() end do
        assert {:error, :request_error} == Github.call(client, request)
      end
    end

    test "should call external api two times when request is index and is paginated", %{client: client} do
      first_url = Faker.Internet.url()
      next_url = Faker.Internet.url()
      request = %Request{url: first_url, method: :index, decoding_function: &decoding_function_mock/1}

      first_item = UUID.generate()
      second_item = UUID.generate()

      with_mock Tesla,
        get: fn
          _, ^first_url -> success_paginated(next_url, [first_item])
          _, ^next_url -> success([second_item])
        end do
        assert {:ok, response = %Response{}} = Github.call(client, request)
        assert is_list(response.body)
        assert [first_response_element, second_response_element] = response.body
        assert first_response_element == first_item
        assert second_response_element == second_item
      end
    end

    defp decoding_function_mock(body), do: body
  end
end
