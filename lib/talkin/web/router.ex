defmodule Talkin.Web.Router do
  use Talkin.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
    plug Talkin.Web.GraphQLContext
  end

  scope "/api" do
    pipe_through :graphql

    forward "/", Absinthe.Plug,
      schema: Talkin.GraphQL.Schema
  end

  if Mix.env == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: Talkin.GraphQL.Schema
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
