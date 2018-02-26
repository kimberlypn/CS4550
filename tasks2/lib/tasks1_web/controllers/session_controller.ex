# Adapted from Nat's lecture notes
defmodule Tasks1Web.SessionController do
  use Tasks1Web, :controller

  alias Tasks1.Accounts
  alias Tasks1.Accounts.User

  def create(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Welcome back, #{user.name}!")
      |> redirect(to: task_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Unable to log in. Please try again.")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: page_path(conn, :index))
  end
end
