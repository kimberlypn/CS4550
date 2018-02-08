defmodule Memory.Game do
  # Resets the state of the game
  def new do
    %{
      matches: 0,
      clicks: 0,
      flipped: 0,
      prev: nil,
      ready: true,
      cards: shuffle(),
    }
  end

  # Returns the current state of the game
  def client_view(game) do
    %{
      matches: game.matches,
      clicks: game.clicks,
      flipped: game.flipped,
      prev: game.prev,
      ready: game.ready,
      cards: game.cards,
    }
  end

  # Returns the match count and a flag indicating if the match count increased
  defp matched(game, card) do
    # If this is the second card in the turn and this card's letter
    # matches the previous card's letter
    if game.flipped != 0 && game.prev["letter"] == card["letter"] do
      # Increment the number of matches by 1
      [game.matches + 1, true]
    else
      # Else, do not change anything
      [game.matches, false]
    end
  end

  # Updates prev if the current card is the first guess in the turn
  defp set_prev(game, card) do
    if game.flipped == 0 do
      card
    else
      game.prev
    end
  end

  # Updates the matched flag of the previous card
  defp update_prev(cards, game, flag) do
    # If there is a prev (i.e. if this is the second guess of the turn)
    if game.flipped != 0 do
      # Update prev's matched flag
      Map.put(cards,
        game.prev["id"],
        %{letter: game.prev["letter"],
          id: game.prev["id"],
          flipped: game.prev["flipped"],
          matched: flag})
    # Else, don't update prev
    else
      cards
    end
  end

  # Sets the flipped flag of the card to true and the matched flag of this card
  # and the previous card to true if applicable
  defp update_card(game, card, flag) do
    # Update this card's flipped and matched flag
    Map.put(game.cards,
    card["id"],
    %{letter: card["letter"], id: card["id"], flipped: true, matched: flag})
    # Update prev's matched flag if needed
    |> update_prev(game, flag)
  end

  # Handles what happens when a card is clicked by the user
  def clicked(game, card) do
    # Only execute if the card has not been matched yet, another turn is not in
    # progress, and the card is the first card of the game or is different
    # from the previous card
    if not card["flipped"]
      && game.ready
      && (game.flipped == 0 || game.prev["id"] != card["id"]) do
      # Check if this card is a match
      matched = matched(game, card)
      game
      # Increment the match count if applicable
      |> Map.put(:matches, Enum.at(matched, 0))
      # Increment the click count by 1
      |> Map.put(:clicks, game.clicks + 1)
      # Increment the flipped count by 1
      |> Map.put(:flipped, game.flipped + 1)
      # Update prev if applicable
      |> Map.put(:prev, set_prev(game, card))
      # Lock the next turn if this is the second guess so that the user
      # cannot start a new turn while the unflip logic is executing
      |> Map.put(:ready, game.flipped == 0)
      # Update any card flags
      |> Map.put(:cards, update_card(game, card, Enum.at(matched, 1)))
    else
      game
    end
  end

  # Randomizes the order of the cards array
  defp shuffle do
    cards = %{
      0 => %{letter: "A", id: 0, flipped: false, matched: false},
      1 => %{letter: "A", id: 1, flipped: false, matched: false},
      2 => %{letter: "B", id: 2, flipped: false, matched: false},
      3 => %{letter: "B", id: 3, flipped: false, matched: false},
      4 => %{letter: "C", id: 4, flipped: false, matched: false},
      5 => %{letter: "C", id: 5, flipped: false, matched: false},
      6 => %{letter: "D", id: 6, flipped: false, matched: false},
      7 => %{letter: "D", id: 7, flipped: false, matched: false},
      8 => %{letter: "E", id: 8, flipped: false, matched: false},
      9 => %{letter: "E", id: 9, flipped: false, matched: false},
      10 => %{letter: "F", id: 10, flipped: false, matched: false},
      11 => %{letter: "F", id: 11, flipped: false, matched: false},
      12 => %{letter: "G", id: 12, flipped: false, matched: false},
      13 => %{letter: "G", id: 13, flipped: false, matched: false},
      14 => %{letter: "H", id: 14, flipped: false, matched: false},
      15 => %{letter: "H", id: 15, flipped: false, matched: false}
    }
    #|> Enum.shuffle()
  end
end
