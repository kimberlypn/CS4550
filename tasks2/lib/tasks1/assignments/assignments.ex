defmodule Tasks1.Assignments do
  @moduledoc """
  The Assignments context.
  """

  import Ecto.Query, warn: false
  alias Tasks1.Repo
  alias Tasks1.Assignments.Task
  alias Tasks1.Assignments.Manage
  alias Tasks1.Accounts.User

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:user)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{source: %Task{}}

  """
  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

  alias Tasks1.Assignments.Manage

  @doc """
  Returns the list of manages.

  ## Examples

      iex> list_manages()
      [%Manage{}, ...]

  """
  def list_manages do
    Repo.all(Manage)
  end

  @doc """
  Gets a single manage.

  Raises `Ecto.NoResultsError` if the Manage does not exist.

  ## Examples

      iex> get_manage!(123)
      %Manage{}

      iex> get_manage!(456)
      ** (Ecto.NoResultsError)

  """
  def get_manage!(id), do: Repo.get!(Manage, id)

  @doc """
  Creates a manage.

  ## Examples

      iex> create_manage(%{field: value})
      {:ok, %Manage{}}

      iex> create_manage(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_manage(attrs \\ %{}) do
    %Manage{}
    |> Manage.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a manage.

  ## Examples

      iex> update_manage(manage, %{field: new_value})
      {:ok, %Manage{}}

      iex> update_manage(manage, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_manage(%Manage{} = manage, attrs) do
    manage
    |> Manage.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Manage.

  ## Examples

      iex> delete_manage(manage)
      {:ok, %Manage{}}

      iex> delete_manage(manage)
      {:error, %Ecto.Changeset{}}

  """
  def delete_manage(%Manage{} = manage) do
    Repo.delete(manage)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking manage changes.

  ## Examples

      iex> change_manage(manage)
      %Ecto.Changeset{source: %Manage{}}

  """
  def change_manage(%Manage{} = manage) do
    Manage.changeset(manage, %{})
  end

  # Taken and adapted from Nat's lecture notes
  def manages_map_for(user_id) do
    Repo.all(from m in Manage,
      where: m.manager_id == ^user_id)
    |> Enum.map(&({&1.underling_id, &1.id}))
    |> Enum.into(%{})
  end

  # Get all of the manager ids
  def get_manager_ids do
    Repo.all(from m in Manage,
      select: m.manager_id)
  end

  # Get the tasks for the current user's underlings and herself
  def get_underling_tasks(user_id) do
    underlings = Repo.all(from t in Task,
      join: m in Manage,
      where: t.user_id == m.underling_id,
      where: m.manager_id == ^user_id)
      |> Repo.preload(:user)

    own = Repo.all(from t in Task,
      where: t.user_id == ^user_id)
      |> Repo.preload(:user)

    Enum.concat(underlings, own)
    |> Enum.uniq()
  end
end