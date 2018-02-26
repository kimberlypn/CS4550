defmodule Tasks1Web.UserView do
  use Tasks1Web, :view
  import Ecto.Query

  # Returns the manager of the current user
  def get_manager(current_user) do
    Tasks1.Assignments.list_manages()
  end
end
