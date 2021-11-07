defmodule FelixirWeb.Plugs.ProtectGraphql do
  import Plug.Conn

  alias Felixir.Auth
  alias Felixir.Auth.User
  alias FelixirWeb.Constants

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = Plug.Conn.get_session(conn, :zcurrent_user_id)

    if user_id do
      user = Auth.get_user!(user_id)

      case user do
        %User{} ->
          conn
          |> Absinthe.Plug.put_options(context: %{current_user: user})

        _ ->
          send_resp(conn, 401, Constants.not_authenticated())

          conn
          |> halt()
      end
    else
      send_resp(conn, 401, Constants.not_authenticated())

      conn
      |> halt()
    end
  end
end
