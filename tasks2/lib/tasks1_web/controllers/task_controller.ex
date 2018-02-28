defmodule Tasks1Web.TaskController do
  use Tasks1Web, :controller

  alias Tasks1.Assignments
  alias Tasks1.Assignments.Task

  def index(conn, _params) do
    current_user = conn.assigns[:current_user]
    tasks = Assignments.get_underling_tasks(current_user.id)
    managers = Assignments.get_manager_ids()
    render(conn, "index.html", tasks: tasks, managers: managers)
  end

  def new(conn, _params) do
    changeset = Assignments.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Assignments.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Assignments.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Assignments.get_task!(id)
    changeset = Assignments.change_task(task)
    current_user = conn.assigns[:current_user]
    render(conn, "edit.html", task: task, changeset: changeset, current_user: current_user)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Assignments.get_task!(id)

    case Assignments.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Assignments.get_task!(id)
    {:ok, _task} = Assignments.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
