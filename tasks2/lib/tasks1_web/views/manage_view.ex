defmodule Tasks1Web.ManageView do
  use Tasks1Web, :view
  alias Tasks1Web.ManageView

  def render("index.json", %{manages: manages}) do
    %{data: render_many(manages, ManageView, "manage.json")}
  end

  def render("show.json", %{manage: manage}) do
    %{data: render_one(manage, ManageView, "manage.json")}
  end

  def render("manage.json", %{manage: manage}) do
    %{id: manage.id}
  end
end
