defmodule Tasks1.Assignments.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Assignments.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :time_spent, :integer
    field :title, :string
    belongs_to :user, Tasks1.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :completed, :time_spent, :user_id])
    |> validate_required([:title, :description, :completed, :user_id])
  end
end
