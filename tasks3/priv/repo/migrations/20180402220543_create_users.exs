defmodule Tasks3.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :name, :string, null: false

      timestamps()
    end

    # Make sure that the email is unique since it is used for logging in
    create unique_index(:users, [:email])
  end
end
