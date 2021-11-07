defmodule FelixirWeb.AuthController do
  use FelixirWeb, :controller
  import Plug.Conn

  alias Felixir.Auth
  alias FelixirWeb.Utils
  alias FelixirWeb.Constants
  alias Felixir.Auth.User

  plug :dont_exploit_me when action in [:login, :register]
  plug :protect_me when action in [:logout, :getme]

  def login(conn, params) do
    # IO.inspect(conn)

    %Plug.Conn{req_headers: req_headers} = conn
    req_headers_map = Enum.into(req_headers, %{})
    # IO.inspect(req_headers_map)
    # IO.inspect(req_headers_map["cookie"])

    if req_headers_map["origin"] === nil do
      IO.inspect("no origin")

      case User.login_changeset(params) do
        %Ecto.Changeset{valid?: true, changes: %{username: username, password: password}} ->
          user = Auth.get_by_username(username)

          case user do
            %User{} ->
              if Argon2.verify_pass(password, user.password) do
                conn
                |> put_status(:created)
                |> put_session(:current_user_id, user.id)
                |> render("acknowledge.json", %{message: "Logged In"})
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
    else
      IO.inspect("yes origin #{req_headers_map["origin"]}")

      case User.login_changeset(params) do
        %Ecto.Changeset{valid?: true, changes: %{username: username, password: password}} ->
          user = Auth.get_by_username(username)

          case user do
            %User{} ->
              if Argon2.verify_pass(password, user.password) do
                conn
                |> put_status(:created)
                |> put_session(:current_user_id, user.id)
                |> render("acknowledge.json", %{message: "Logged In"})
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

  def getme(conn, _params) do
    # IO.inspect(conn)
    %Plug.Conn{req_headers: req_headers} = conn
    req_headers_map = Enum.into(req_headers, %{})
    # IO.inspect(req_headers_map)
    # IO.inspect(req_headers_map["cookie"])

    if req_headers_map["origin"] == nil do
      IO.inspect("no origin")
    else
      IO.inspect("yes origin #{req_headers_map["origin"]}")
    end

    render(conn, "getme.json", %{current_user: conn.assigns.current_user})
  end

  def logout(conn, _params) do
    conn
    |> Plug.Conn.clear_session()
    |> render("acknowledge.json", %{message: "Logged Out"})
  end

  defp dont_exploit_me(conn, _params) do
    if conn.assigns.user_signed_in? do
      send_resp(conn, 401, Constants.not_authorized())

      conn
      |> halt()
    else
      conn
    end
  end

  defp protect_me(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, Constants.not_authenticated())

      conn
      |> halt()
    end
  end
end
