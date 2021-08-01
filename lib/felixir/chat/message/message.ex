defmodule Felixir.Chat.Message.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Felixir.Auth.User
  alias Felixir.Chat.Room

  schema "messages" do
    field :content, :string

    belongs_to :user, User
    belongs_to :room, Room

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:content, :user_id, :room_id])
    |> validate_required([:content, :user_id, :room_id])
    |> validate_length(:content, min: 1)
  end
end
