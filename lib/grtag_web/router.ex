defmodule GRTagWeb.Router do
  use GRTagWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GRTagWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show]
    resources "/repositories", RepositoryController, only: [:show, :index]
  end
end
