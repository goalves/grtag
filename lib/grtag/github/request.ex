defmodule GRTag.Github.Request do
  use TypedStruct

  @type methods :: :index

  typedstruct enforce: true do
    field :url, :string
    field :method, methods()
    field :decoding_function, fun()
  end
end
