defmodule Felixir.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Felixir.Auth.User
  alias Felixir.Chat.Room

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password, :string)
    field(:username, :string)

    has_many :rooms, Room

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :username, :password])
    |> validate_required([:name, :email, :username, :password])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, fn email -> String.downcase(email) end)
    |> update_change(:username, fn username -> String.downcase(username) end)
    |> validate_length(:username, min: 4, max: 30)
    |> validate_length(:name, min: 3, max: 30)
    |> validate_length(:password, min: 8, max: 30)
    |> hash_password
  end

  def login_changeset(attrs) do
    %User{}
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> update_change(:username, &String.downcase/1)
  end

  defp hash_password(%Ecto.Changeset{} = changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        new_changeset = put_change(changeset, :password, Argon2.hash_pwd_salt(password))
        new_changeset

      _ ->
        changeset
    end
  end
end
