# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :felixir,
  ecto_repos: [Felixir.Repo]

# Configures the endpoint
config :felixir, FelixirWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uPgOd7Brit0b8WcxWCxA34aS6Y6Wmljp+3atiZUXfWjU6E1DioiaadQnO8Q+DBpK",
  render_errors: [view: FelixirWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Felixir.PubSub,
  live_view: [signing_salt: "HzEbdr6D"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
