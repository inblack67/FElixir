defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth

  def get_all_users(_, _, %{context: _context}) do
    users = Auth.list_users()
    {:ok, users}
  end

  def get_me(_, _, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end
end
