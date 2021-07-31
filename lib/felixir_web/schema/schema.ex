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

    @desc "Get all Rooms"
    field :rooms, list_of(:room_type) do
      resolve(&Resolvers.RoomResolver.get_all_rooms/3)
    end
  end

  mutation do
    @desc "Create Room"
    field :create_room, :boolean do
      arg(:input, non_null(:room_input_type))
      resolve(&Resolvers.RoomResolver.create_room/3)
    end

    @desc "Delete Room"
    field :delete_room, :boolean do
      arg(:input, non_null(:delete_room_input))
      resolve(&Resolvers.RoomResolver.delete_room/3)
    end
  end
end
