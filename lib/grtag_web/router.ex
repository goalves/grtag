defmodule GRTagWeb.Router do
  use GRTagWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GRTagWeb do
    pipe_through :api

    resources "/users", UserController, only: [:create, :show] do
      resources "/tags", TagController, only: [:create]
    end

    resources "/repositories", RepositoryController, only: [:show, :index]
    resources "/tags", TagController, only: [:show, :update, :delete, :index]
  end
end
