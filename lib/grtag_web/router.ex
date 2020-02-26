defmodule GRTagWeb.Router do
  use GRTagWeb, :router

  @version "v1"

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/#{@version}", GRTagWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show] do
      resources "/tags", TagController, only: [:create]
    end

    resources "/repositories", RepositoryController, only: [:show, :index]
    resources "/tags", TagController, only: [:show, :update, :delete, :index]
  end
end
