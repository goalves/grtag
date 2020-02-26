defmodule GRTag.Github.Starred do
  alias GRTag.Github
  alias GRTag.Github.Request
  alias Tesla.Client

  use TypedStruct

  @users_resource "/users"
  @starred_resource "/starred"
  @separator "/"

  typedstruct enforce: true do
    field :id, :integer
    field :name, :string
    field :description, :string
    field :url, :string
    field :language, :string
    field :languages_url, :string
  end

  @spec user_starred(Client.t(), binary()) :: Github.responses()
  def user_starred(client = %Client{}, username) do
    request = %Request{
      url: @users_resource <> @separator <> username <> @starred_resource,
      method: :index,
      decoding_function: &as_structure/1
    }

    Github.call(client, request)
  end

  @spec as_structure(map) :: %__MODULE__{}
  def as_structure(body) when is_map(body) do
    %__MODULE__{
      id: body["id"],
      name: body["name"],
      description: body["description"],
      url: body["url"],
      language: body["language"],
      languages_url: body["languages_url"]
    }
  end
end
