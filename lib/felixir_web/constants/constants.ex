defmodule FelixirWeb.Constants do
  @internal_server_error "Internal Server Error"
  @invalid_credentials "Invalid Credentials"
  @not_authenticated "Not Authenticated"
  @not_authorized "Not Authorized"
  @not_found "Not Found"

  def internal_server_error, do: @internal_server_error

  def invalid_credentials, do: @invalid_credentials

  def not_authenticated, do: @not_authenticated

  def not_authorized, do: @not_authorized

  def not_found, do: @not_found
end
