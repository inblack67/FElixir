defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth

  @spec get_all_users(any, any, any) :: {:ok, any}
  def get_all_users(_, _, _) do
    users = Auth.list_users()
    {:ok, users}
  end
end
