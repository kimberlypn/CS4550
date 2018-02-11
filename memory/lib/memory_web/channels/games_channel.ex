defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      # Get initial game on join
      game = Memory.GameBackup.load(name) || Game.new()

      # Save game after generating new state.
      Memory.GameBackup.save(socket.assigns[:name], game)

      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client

  # Sends the clicked card to clicked()
  def handle_in("clicked", %{"card" => c}, socket) do
    game = Game.clicked(socket.assigns[:game], c)
    socket = assign(socket, :game, game)
    if game.flipped < 2 do
      {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
    else
      {:reply, {:unflip, %{ "game" => Game.client_view(game)}}, socket}
    end
  end

  # Sends a request to unflip the two cards
  def handle_in("unflip", %{}, socket) do
    game = Game.unflip(socket.assigns[:game])
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Sends a reset request
  def handle_in("reset", %{}, socket) do
    game = Game.new()
    socket = assign(socket, :game, game)
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
