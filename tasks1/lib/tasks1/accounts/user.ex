defmodule Tasks1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasks1.Accounts.User


  schema "users" do
    field :email, :string
    field :name, :string

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
