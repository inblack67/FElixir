defmodule FelixirWeb.Schema.Types do
  use Absinthe.Schema.Notation

  import_types(FelixirWeb.Schema.Types.UserType)
  import_types(FelixirWeb.Schema.Types.RoomType)
  import_types(FelixirWeb.Schema.Types.MessageType)
end
