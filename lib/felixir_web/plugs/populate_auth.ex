defmodule FelixirWeb.Plugs.PopulateAuth do
  import Plug.Conn

  alias Felixir.Auth
  alias Felixir.Auth.User

  def init(_params) do
  end

  def call(conn, _params) do
    %Plug.Conn{req_headers: req_headers} = conn
    req_headers_map = Enum.into(req_headers, %{})
    IO.inspect(req_headers_map)
    # IO.inspect(req_headers_map["cookie"])

    if req_headers_map["origin"] == nil || req_headers_map["origin"] != "http://localhost:3000" do
      IO.inspect("no origin")
      user = Auth.get_user!(2)
      IO.puts("assigning this user to flutter =>")
      IO.inspect(user)

      conn
      |> assign(:user_signed_in?, true)
      |> assign(:current_user, user)
    else
      user_id = Plug.Conn.get_session(conn, :current_user_id)

      if user_id do
        user = Auth.get_user!(user_id)

        case user do
          %User{} ->
            conn
            |> assign(:user_signed_in?, true)
            |> assign(:current_user, user)

          _ ->
            conn
            |> assign(:user_signed_in?, false)
            |> assign(:current_user, nil)
        end
      else
        conn
        |> assign(:user_signed_in?, false)
        |> assign(:current_user, nil)
      end
    end
  end
end
