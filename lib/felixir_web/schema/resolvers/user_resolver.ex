defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth

  @spec get_all_users(any, any, any) :: {:ok, any}
  def get_all_users(_, _, %{context: context}) do
    IO.puts("i pass")
    IO.inspect(context)
    users = Auth.list_users()
    {:ok, users}
  end
end
