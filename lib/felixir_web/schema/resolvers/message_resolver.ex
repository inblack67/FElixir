defmodule FelixirWeb.Schema.Resolvers.MessageResolver do
  alias Felixir.Chat.Message
  alias Felixir.Chat.Room
  alias Felixir.Chat
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants

  def delete_message(_, %{input: input}, %{context: context}) do
    case Message.delete_message_by_id(input.message_id, input.room_id, context.current_user.id) do
      {1, _} ->
        {:ok, %{message_id: input.message_id, room_id: input.room_id}}

      {0, _} ->
        {:error, Constants.not_found()}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end

  def get_all_messages(_, %{input: %{room_id: room_id, cursor: cursor}}, %{context: _context}) do
    {:ok, Message.list_messages(room_id, cursor)}
  end

  def get_all_messages(_, %{input: %{room_id: room_id}}, %{context: _context}) do
    {:ok, Message.list_messages(room_id)}
  end

  def create_message(_, %{input: input}, %{context: context}) do
    case Chat.get_room(input.room_id) do
      %Room{} ->
        input_with_ids =
          Map.merge(input, %{user_id: context.current_user.id, room_id: input.room_id})

        case Message.create_message(input_with_ids) do
          {:ok, message} ->
            {:ok, message}

          {:error, %Ecto.Changeset{} = changeset} ->
            {:error, Utils.format_changeset_errors(changeset)}

          _ ->
            {:error, Constants.internal_server_error()}
        end

      _ ->
        {:error, Constants.not_found()}
    end
  end
end
