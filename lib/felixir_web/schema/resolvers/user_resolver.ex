defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth

  def register_user(_, %{input: input}, _) do
    IO.inspect(input)
    res = Auth.create_user(input)
    IO.puts("create_user res => ")
    IO.inspect(res)
    {:ok, true}
  end
end
