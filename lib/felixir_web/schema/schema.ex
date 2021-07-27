defmodule FelixirWeb.Schema do
  use Absinthe.Schema

  import_types(FelixirWeb.Schema.Types)

  alias FelixirWeb.Schema.Resolvers

  query do
    @desc "greet"
    field :hello, :string do
      resolve(fn _, _ -> {:ok, "worlds"} end)
    end

    @desc "Get all Users"
    field :users, list_of(:user_type) do
      resolve(&Resolvers.UserResolver.get_all_users/3)
    end
  end
end
