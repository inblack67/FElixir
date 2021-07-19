defmodule Felixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Felixir.Repo,
      # Start the Telemetry supervisor
      FelixirWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Felixir.PubSub},
      # Start the Endpoint (http/https)
      FelixirWeb.Endpoint
      # Start a worker by calling: Felixir.Worker.start_link(arg)
      # {Felixir.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Felixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FelixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
