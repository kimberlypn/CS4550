defmodule Tasks1.Assignments.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Assignments.TimeBlock


  schema "timeblocks" do
    field :end, :time
    field :start, :time
    belongs_to :task, Tasks1.Assignments.Task

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:start, :end, :task_id])
    |> validate_required([:start, :end, :task_id])
  end
end
