defmodule Tasks3Web.TokenView do
  use Tasks3Web, :view

  # Taken from Nat's lecture notes
  def render("token.json", %{user: user, token: token}) do
    %{user_id: user.id, token: token}
  end
end
