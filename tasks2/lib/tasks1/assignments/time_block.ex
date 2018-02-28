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
    |> validate_required([:start, :end, :task_id])
  end
end
