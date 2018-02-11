defmodule MemoryWeb.GamesChannel do
  use MemoryWeb, :channel

  alias Memory.Game

  def join("games:" <> name, payload, socket) do
    if authorized?(payload) do
      # Get initial game on join
      game = Memory.GameBackup.load(name) || Game.new()
      # Add the game and name to socket assigns
      socket = socket
      |> assign(:game, game)
      |> assign(:name, name)
      # Send an ok message
      {:ok, %{"join" => name, "game" => Game.client_view(game)}, socket}
    else
      # Send an unauthorized error message
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client

  # Sends the clicked card to clicked()
  def handle_in("clicked", %{"card" => c}, socket) do
    # Call clicked() with the current state and card
    game = Game.clicked(socket.assigns[:game], c)
    # Update game in socket assigns
    socket = assign(socket, :game, game)
    # Save game after generating new state
    Memory.GameBackup.save(socket.assigns[:name], socket.assigns[:game])
    # Send an ok message
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Sends a request to unflip the two cards
  def handle_in("unflip", %{}, socket) do
    # Call unflip() with the current state
    game = Game.unflip(socket.assigns[:game])
    # Update game in socket assigns
    socket = assign(socket, :game, game)
    # Save game after generating new state
    Memory.GameBackup.save(socket.assigns[:name], socket.assigns[:game])
    # Send an ok message
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Sends a reset request
  def handle_in("reset", %{}, socket) do
    # Call new() to get a fresh state
    game = Game.new()
    # Update game in socket assigns
    socket = assign(socket, :game, game)
    # Save game after generating new state
    Memory.GameBackup.save(socket.assigns[:name], socket.assigns[:game])
    # Send an ok message
    {:reply, {:ok, %{ "game" => Game.client_view(game)}}, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
