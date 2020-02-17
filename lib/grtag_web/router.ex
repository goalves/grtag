defmodule GrtagWeb.Router do
  use GrtagWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GrtagWeb do
    pipe_through :api
  end
end
