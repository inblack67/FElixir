defmodule FelixirWeb.Router do
  use FelixirWeb, :router

  alias FelixirWeb.AuthController
  alias FelixirWeb.Plugs.PopulateAuth
  alias FelixirWeb.Plugs.ProtectGraphql

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug PopulateAuth
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    # plug ProtectGraphql
  end

  scope "/api" do
    pipe_through :api
    post "/auth/register", AuthController, :register
    post "/auth/login", AuthController, :login
    get "/auth/getme", AuthController, :getme
    delete "/auth/logout", AuthController, :logout
  end

  scope "/api/graphql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL,
      schema: FelixirWeb.Schema,
      interface: :playground,
      socket: FelixirWeb.UserSocket

    post "/", Absinthe.Plug, schema: FelixirWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: FelixirWeb.Telemetry
    end
  end
end
