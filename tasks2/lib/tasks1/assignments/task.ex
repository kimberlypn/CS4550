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
    |> validate_time(:time_spent)
  end

  # Adapted from https://medium.com/@QuantLayer/writing-custom-validations-for-ecto-changesets-4971881c7684
  def validate_time(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, time ->
      case rem(time, 15) == 0 do
        true -> []
        false -> [{field, options[:message] || "Must be in increments of 15"}]
      end
    end)
  end
end
