defmodule FelixirWeb.Schema.Resolvers.UserResolver do
  alias Felixir.Auth
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants

  def get_all_users(_, _, _) do
    users = Auth.list_users()
    {:ok, users}
  end

  def register_user(_, %{input: input}, _) do
    case Auth.create_user(input) do
      {:ok, _} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        errors = Utils.format_changeset_errors(changeset)
        {:error, errors}

      {_, _} ->
        {:error, Constants.internal_server_error()}
    end
  end
end
