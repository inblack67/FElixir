defmodule FelixirWeb.Schema.Resolvers.RoomResolver do
  alias Felixir.Chat
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants

  def delete_room(_, %{input: input}, %{context: context}) do
    case Chat.delete_room_by_id(input.room_id, context.current_user.id) do
      {1, _} ->
        {:ok, true}

      {0, _} ->
        {:error, Constants.not_found()}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end

  def get_all_rooms(_, _, %{context: _context}) do
    rooms = Chat.list_rooms()
    {:ok, rooms}
  end

  def create_room(_, %{input: input}, %{context: context}) do
    input_with_user_id = Map.merge(input, %{user_id: context.current_user.id})

    case Chat.create_room(input_with_user_id) do
      {:ok, _room} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.format_changeset_errors(changeset)}

      _ ->
        {:error, Constants.internal_server_error()}
    end
  end
end
