# Taken from Nat's lecture notes
defmodule Tasks3Web.TokenController do
  use Tasks3Web, :controller
  alias Tasks3.Users.User

  action_fallback Tasks3Web.FallbackController

  def create(conn, %{"email" => email, "pass" => pass}) do
    with {:ok, %User{} = user} <- Tasks3.Users.get_and_auth_user(email, pass) do
      token = Phoenix.Token.sign(conn, "auth token", user.id)
      conn
      |> put_status(:created)
      |> render("token.json", user: user, token: token)
    end
  end
end
