defmodule GRTag.Github.StarredTest do
  use GRTag.DataCase

  import Mock
  import GRTag.HTTPFactory

  alias GRTag.Github
  alias GRTag.Github.{Request, Response, Starred}
  alias Faker.{Internet, Lorem}

  @max_integer 999_999_999

  describe "user_starred/1" do
    setup do: %{client: Github.client(), username: Faker.Internet.user_name()}

    test "should call correct function on Github module", %{client: client, username: username} do
      expected_url = "/users/#{username}/starred"

      with_mock Github, call: fn _, _ -> :ok end do
        Starred.user_starred(client, username)
        assert_called(Github.call(client, %Request{url: expected_url, method: :index, decoding_function: :_}))
      end
    end

    test "should properly decode elements into structure", %{client: client, username: username} do
      {:ok, response = %{body: [body]}} = user_starred_success()

      expected_encoded_body = %Starred{
        id: body["id"],
        name: body["name"],
        description: body["description"],
        url: body["url"],
        language: body["language"],
        languages_url: body["languages_url"]
      }

      with_mock Tesla, get: fn _, _ -> {:ok, response} end do
        assert {:ok, %Response{body: body}} = Starred.user_starred(client, username)
        assert body == [expected_encoded_body]
      end
    end
  end

  describe "as_structure" do
    test "should return a valid structure from map" do
      id = :random.uniform(@max_integer)
      name = Lorem.word()
      description = Lorem.paragraph()
      url = Internet.url()
      language = Lorem.word()
      languages_url = Internet.url()

      body = %{
        "id" => id,
        "name" => name,
        "description" => description,
        "url" => url,
        "language" => language,
        "languages_url" => languages_url
      }

      expected_starred = %Starred{
        id: id,
        name: name,
        description: description,
        url: url,
        language: language,
        languages_url: languages_url
      }

      assert expected_starred == Starred.as_structure(body)
    end
  end
end
