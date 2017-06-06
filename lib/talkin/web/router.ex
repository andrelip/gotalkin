defmodule Talkin.Web.Router do
  use Talkin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers

    if Mix.env == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Talkin.GraphQL.Schema
    end
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Talkin.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/sample", ExampleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Talkin.Web do
  #   pipe_through :api
  # end
end
