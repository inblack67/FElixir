defmodule FelixirWeb.AuthController do
  use FelixirWeb, :controller

  alias Felixir.Auth
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants
  alias Felixir.Auth.User

  def login(conn, params) do
    case User.login_changeset(params) do
      %Ecto.Changeset{valid?: true, changes: %{username: username, password: password}} ->
        user = Auth.get_by_username(username)

        case user do
          %User{} ->
            if Argon2.verify_pass(password, user.password) do
              render(conn, "acknowledge.json", %{message: "Logged In"})
            else
              render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
            end

          _ ->
            render(conn, "errors.json", %{errors: Constants.invalid_credentials()})
        end

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "errors.json", %{
          errors: Utils.format_changeset_errors(changeset)
        })

      {_, _} ->
        render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end

  def register(conn, params) do
    case Auth.create_user(params) do
      {:ok, _} ->
        render(conn, "acknowledge.json", %{message: "Registered"})

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "errors.json", %{
          errors: Utils.format_changeset_errors(changeset)
        })

      {_, _} ->
        render(conn, "errors.json", %{message: Constants.internal_server_error()})
    end
  end
end
