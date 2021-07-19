defmodule Felixir.Repo do
  use Ecto.Repo,
    otp_app: :felixir,
    adapter: Ecto.Adapters.Postgres
end
