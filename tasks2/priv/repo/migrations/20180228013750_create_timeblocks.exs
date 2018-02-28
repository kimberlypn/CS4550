defmodule Tasks1.Repo.Migrations.CreateTimeblocks do
  use Ecto.Migration

  def change do
    create table(:timeblocks) do
      add :start, :utc_datetime, null: false
      add :end, :utc_datetime
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:timeblocks, [:task_id])
    create constraint("timeblocks", "start_before_end", check: "end_time > start_time")

  end
end
