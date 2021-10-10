defmodule FelixirWeb.Schema.Types.MessageType do
  use Absinthe.Schema.Notation

  object :message_type do
    field :id, :id
    field :user_id, :id
    field :room_id, :id
    field :user, :user_type
    field :room, :room_type
    field :content, :string
    field :inserted_at, :string
  end

  object :deleted_message_type do
    field :room_id, :id
    field :message_id, :id
  end

  input_object :list_messages_type do
    field :room_id, non_null(:id)
    field :cursor, :integer
  end

  input_object :message_input_type do
    field :content, non_null(:string)
    field :room_id, non_null(:id)
  end

  input_object :delete_message_input do
    field :message_id, non_null(:id)
    field :room_id, non_null(:id)
  end

  input_object :deleted_message_input do
    field :room_id, non_null(:id)
  end
end
