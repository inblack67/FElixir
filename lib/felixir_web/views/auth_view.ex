defmodule FelixirWeb.AuthView do
  use FelixirWeb, :view

  def render("acknowledge.json", %{message: message}) do
    %{success: true, message: message}
  end

  def render("errors.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end

  def render("getme.json", %{current_user: current_user}) do
    %{
      success: true,
      data: %{
        username: current_user.username,
        name: current_user.name,
        email: current_user.email,
        inserted_at: current_user.inserted_at
      }
    }
  end
end
