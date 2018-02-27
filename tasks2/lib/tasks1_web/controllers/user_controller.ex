defmodule Tasks1Web.UserController do
  use Tasks1Web, :controller

  alias Tasks1.Accounts
  alias Tasks1.Accounts.User

  def index(conn, _params) do
    # Get the current user
    current_user = conn.assigns[:current_user]
    # Get all of the users
    users = Accounts.list_users()
    manages = Tasks1.Assignments.follows_map_for(current_user.id)
    # Get the id of the manager of the current user
    manager_id = Tasks1.Accounts.get_manager(current_user.id)
    # Get the User corresponding to the manager id or nil if there is none
    manager =
      if Enum.empty?(manager_id),
      do: nil,
      else: Tasks1.Accounts.get_user!(Enum.at(manager_id, 0))
    underlings = Tasks1.Accounts.get_underlings(current_user.id)
    render(conn, "index.html", users: users, manages: manages, manager: manager, underlings: underlings)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully registered! You may now log in.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
