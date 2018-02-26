defmodule Tasks1.Assignments.Manage do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Assignments.Manage
  alias Tasks1.Accounts.User

  schema "manages" do
    belongs_to :manager, User
    belongs_to :underling, User

    timestamps()
  end

  @doc false
  def changeset(%Manage{} = manage, attrs) do
    manage
    |> cast(attrs, [:manager_id, :underling_id])
    |> validate_required([:manager_id, :underling_id])
  end
end
