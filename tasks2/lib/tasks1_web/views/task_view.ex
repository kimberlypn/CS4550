defmodule Tasks1Web.TaskView do
  use Tasks1Web, :view
  import Ecto.Query

  # Returns a map of names to ids for all of the current user's underlings
  def get_names(user_id) do
    underlings = Tasks1.Accounts.get_underlings(user_id)
    Enum.map underlings, fn u -> {elem(u, 1), elem(u, 0)} end
  end
end
