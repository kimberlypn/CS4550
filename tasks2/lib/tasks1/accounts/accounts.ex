defmodule Tasks1.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Tasks1.Repo
  alias Tasks1.Accounts.User
  alias Tasks1.Assignments.Manage

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  # Non-bang variant of get_user()
  def get_user(id), do: Repo.get(User, id)

  # Returns a user found via email lookup
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  # Returns the current user's manager
  def get_manager(user_id) do
    # SELECT users.id, users.name, users.email
    # FROM users
    # INNER JOIN manages ON users.id = manages.manager_id
    # WERE manages.underling_id = user_id

    Repo.all(from u in User,
      join: m in Manage,
      where: u.id == m.manager_id,
      where: m.underling_id == ^user_id,
      select: {u.id, u.name, u.email})
  end

  # Returns the given user's underlings
  def get_underlings(user_id) do
    # SELECT users.id, users.name, users.email
    # FROM manages
    # INNER JOIN users ON manages.underling_id = users.id
    # WHERE manages.manager_id == user_id

    Repo.all(from m in Manage,
      join: u in User,
      where: m.underling_id == u.id,
      where: m.manager_id == ^user_id,
      select: {u.id, u.name, u.email})
  end

  # Returns the users who do not have a manager yet and the current user's
  # underlings
  def get_unmanaged(user_id) do
    # Get all of the ids from the Manage table
    ids = Repo.all(from m in Manage,
      select: m.underling_id)
    unmanaged = Repo.all(from u in User,
      where: not u.id in ^ids,
      select: {u.id, u.name, u.email})
    underlings = get_underlings(user_id)
    Enum.concat(unmanaged, underlings)
    |> Enum.uniq()
  end
end
