defmodule FelixirWeb.Schema.Types.RoomType do
  use Absinthe.Schema.Notation

  object :room_type do
    field :id, :id
    field :user_id, :id
    field :user, :user_type
    field :messages, list_of(:message_type)
    field :name, :string
    field :description, :string
    field :inserted_at, :string
  end

  input_object :room_input_type do
    field :name, non_null(:string)
    field :description, non_null(:string)
  end

  input_object :delete_room_input do
    field :room_id, non_null(:id)
  end
end
