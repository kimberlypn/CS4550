defmodule Tasks1Web.TaskView do
  use Tasks1Web, :view
  import Ecto.Query

  # Returns a map of user names to ids
  def get_names do
    Enum.map(Tasks1.Accounts.list_users(), &{&1.name, &1.id})
  end
end
