defmodule Felixir.Chat.Room do
  use Ecto.Schema
  import Ecto.Changeset

  alias Felixir.Auth.User
  alias Felixir.Chat.Message.Message

  schema "rooms" do
    field :description, :string
    field :name, :string

    belongs_to :user, User

    has_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:name, :description, :user_id])
    |> validate_required([:name, :description, :user_id])
    |> unique_constraint(:name)
    |> validate_length(:name, min: 5, max: 30)
    |> validate_length(:description, min: 10, max: 300)
  end
end
