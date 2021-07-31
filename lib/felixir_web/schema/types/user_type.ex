defmodule FelixirWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :name, :string
    field :email, :string
    field :username, :string
    field :inserted_at, :string
    field :rooms, list_of(:room_type)
  end
end
