defmodule Tasks3Web.TaskController do
  use Tasks3Web, :controller

  alias Tasks3.Tasks
  alias Tasks3.Tasks.Task

  action_fallback Tasks3Web.FallbackController

  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  # Set the default time_spent or convert it to an integer
  defp convert_time(task_params) do
    if Map.get(task_params, "time_spent") == "", do:
      0,
    else:
      Map.get(task_params, "time_spent")
      |> String.to_integer()
  end

  # Taken from Nat's lecture notes
  def create(conn, %{"task" => task_params}) do
    # Make any necessary type conversions
    task_params = task_params
    |> Map.put("time_spent", convert_time(task_params))
    |> Map.put("completed", false)

    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", page_path(conn, :index))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"task" => task_params}) do
    # Get the task id and convert it to an int
    id = Map.get(task_params, "id")
    |> String.to_integer()

    # Get the task to be updated
    task = Tasks.get_task!(id)

    # Make any necessary type conversions
    task_params = task_params
    |> Map.put("time_spent", convert_time(task_params))
    |> Map.put("completed", false)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      conn
      |> put_status(:ok)
      |> put_resp_header("location", page_path(conn, :index))
      |> render("show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      conn
      |> put_status(:ok)
      |> put_resp_header("location", page_path(conn, :index))
      |> render("show.json", task: task)
    end
  end
end
