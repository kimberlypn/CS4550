defmodule Tasks1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Accounts.User
  alias Tasks1.Assignments.Manage

  schema "users" do
    field :email, :string
    field :name, :string
    has_one :manager_manages, Manage, foreign_key: :manager_id
    has_many :underling_manages, Manage, foreign_key: :underling_id
    has_one :managers, through: [:manager_manages, :manager]
    has_many :underlings, through: [:underling_manages, :underling]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    # Regex taken from: https://gist.github.com/mgamini/4f3a8bc55bdcc96be2c6
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
  end
end
