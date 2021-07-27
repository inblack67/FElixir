defmodule FelixirWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :name, :string
    field :email, :string
    field :username, :string
    field :password, :string
    field :inserted_at, :string
  end
end
