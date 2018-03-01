defmodule Tasks1.Assignments.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Assignments.TimeBlock


  schema "timeblocks" do
    field :end, :utc_datetime
    field :start, :utc_datetime
    belongs_to :task, Tasks1.Assignments.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:end, :start, :task_id])
    |> validate_required([:start, :task_id])
    |> validate_time
  end

  # Checks if the start time is before the end time
  defp validate_time(changeset) do
    start_time = get_field(changeset, :start)
    end_time = get_field(changeset, :end)
    if (DateTime.compare(start_time, end_time) == :gt) do
      changeset
    else
      add_error(changeset, :time_violation, "Start must be before end")
    end
  end
end
