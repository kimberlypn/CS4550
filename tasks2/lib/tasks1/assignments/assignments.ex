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
    t = %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()

    # Create the timeblock
    if (elem(t, 0) != :error) do
      id = elem(t, 1).id
      time_block = %{}
        |> Map.put("start", attrs["start"])
        |> Map.put("end", attrs["end"])
        |> Map.put("task_id", id)
        |> Map.put("convert", false)
      create_time_block(time_block)
    end

    # Return the task
    t
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
    id = task.id
    time_block = %{}
      |> Map.put("start", attrs["start"])
      |> Map.put("end", attrs["end"])
      |> Map.put("task_id", id)
    create_time_block(time_block)

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

  alias Tasks1.Assignments.TimeBlock

  @doc """
  Returns the list of timeblocks.

  ## Examples

      iex> list_timeblocks()
      [%TimeBlock{}, ...]

  """
  def list_timeblocks do
    Repo.all(TimeBlock)
    |> Repo.preload(:task)
  end

  @doc """
  Gets a single time_block.

  Raises `Ecto.NoResultsError` if the Time block does not exist.

  ## Examples

      iex> get_time_block!(123)
      %TimeBlock{}

      iex> get_time_block!(456)
      ** (Ecto.NoResultsError)

  """
  def get_time_block!(id), do: Repo.get!(TimeBlock, id)

  @doc """
  Creates a time_block.

  ## Examples

      iex> create_time_block(%{field: value})
      {:ok, %TimeBlock{}}

      iex> create_time_block(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_time_block(attrs \\ %{}) do
    start_time = if (attrs["convert"] and attrs["start"] != nil),
      do: convert_time(attrs["start"]),
      else: attrs["start"]
    end_time = if (attrs["convert"] and attrs["end"] != nil),
      do: convert_time(attrs["end"]),
      else: attrs["end"]
    attrs = Map.put(attrs, "start", start_time)
    |> Map.put("end", end_time)
    
    %TimeBlock{}
    |> TimeBlock.changeset(attrs)
    |> Repo.insert()
  end

  def convert_time(time) do
    time = String.split(time, ["-", " ", ":", ".", "T"])
    new_time = %{}
      |> Map.put("day", Enum.at(time, 2))
      |> Map.put("hour", Enum.at(time, 3))
      |> Map.put("minute", Enum.at(time, 4))
      |> Map.put("month", Enum.at(time, 1))
      |> Map.put("year", Enum.at(time, 0))
  end

  @doc """
  Updates a time_block.

  ## Examples

      iex> update_time_block(time_block, %{field: new_value})
      {:ok, %TimeBlock{}}

      iex> update_time_block(time_block, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_time_block(%TimeBlock{} = time_block, attrs) do
    start_time = if (attrs["convert"] and attrs["start"] != nil),
      do: convert_time(attrs["start"]),
      else: attrs["start"]
    end_time = if (attrs["convert"] and attrs["end"] != nil),
      do: convert_time(attrs["end"]),
      else: attrs["end"]
    attrs = Map.put(attrs, "start", start_time)
    |> Map.put("end", end_time)

    time_block
    |> TimeBlock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TimeBlock.

  ## Examples

      iex> delete_time_block(time_block)
      {:ok, %TimeBlock{}}

      iex> delete_time_block(time_block)
      {:error, %Ecto.Changeset{}}

  """
  def delete_time_block(%TimeBlock{} = time_block) do
    Repo.delete(time_block)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking time_block changes.

  ## Examples

      iex> change_time_block(time_block)
      %Ecto.Changeset{source: %TimeBlock{}}

  """
  def change_time_block(%TimeBlock{} = time_block) do
    TimeBlock.changeset(time_block, %{})
  end

  def get_time_log(task_id) do
    # SELECT * FROM timeblocks
    # INNER JOIN tasks ON timeblocks.task_id = tasks.id
    # WHERE timeblocks.task_id = task_id

    Repo.all(from tb in TimeBlock,
      join: t in Task,
      where: tb.task_id == t.id,
      where: tb.task_id == ^task_id,
      select: {tb.start, tb.end, tb.id})
  end
end
