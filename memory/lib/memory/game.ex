defmodule Memory.Game do
  # Resets the state of the game
  def new do
    %{
      matches: 0,
      clicks: 0,
      flipped: 0,
      cur: nil,
      prev: nil,
      ready: true,
      cards: shuffle(),
    }
  end

  # Returns the current state of the game
  def client_view(game) do
    IO.puts("HELLOOOOOOOOOO")
    %{
      matches: game.matches,
      clicks: game.clicks,
      flipped: game.flipped,
      cur: game.cur,
      prev: game.prev,
      ready: game.ready,
      cards: game.cards,
    }
  end

  # Sets the flipped flag of the card to true
  defp flip_card(cards, card) do
    Map.put(cards,
      card.id,
      %{letter: card.letter,
        id: card.id,
        flipped: true,
        matched: card.matched})
  end

  # Determines if the current card is a match
  defp update_matched(game, card) do
    # If this is the second card in the turn and this card's letter matches
    # the previous card's letter
    if game.flipped != 0 && game.cards[game.prev].letter == card.letter do
      # Set the matched flag of both to true
      prev = game.cards[game.prev]
      new_cards =
        Map.put(game.cards,
          card.id,
          %{letter: card.letter,
            id: card.id,
            flipped: card.flipped,
            matched: true})
        |> Map.put(game.prev,
            %{letter: prev.letter,
              id: prev.id,
              flipped: prev.flipped,
              matched: true})
              # Update the cards and increment the matches count by 1
      Map.put(game, :cards, new_cards)
      |> Map.put(:matches, game.matches + 1)
    # Else, don't do anything
    else
      game
    end
  end

  # Updates prev if the current card is the first guess in the turn
  defp set_prev(game, card) do
    if(game.flipped == 0, do: card.id, else: game.prev)
  end

  def unflip(game) do
    # If this is the second guess in the turn, flip back the two cards after 1
    # second and reset any other fields
    if game.flipped == 2 do
        Map.put(game, :flipped, 0)
        # Change the ready flag back to true to indicate that the user can
        # start a new turn
        |> Map.put(:ready, true)
      # Else, don't do anything
      else
        game
      end
  end

  # Converts the map keys from strings to atoms;
  # ATTRIBUTION:
  # https://stackoverflow.com/questions/31990134/how-to-convert-map-keys-from-strings-to-atoms-in-elixir
  def string_to_atom(m) do
    for {key, val} <- m, into: %{}, do: {String.to_atom(key), val}
  end

  # Handles what happens when a card is clicked by the user
  def clicked(game, card) do
    # Convert the map keys in card from strings to atoms
    new_card = string_to_atom(card)
    # Only execute if the card has not been matched yet, another turn is not in
    # progress, and the card is the first card of the game or is different
    # from the previous card
    if not new_card.matched
      && game.ready
      && (game.flipped == 0 || game.prev != new_card.id) do
      new_game = game
        # Set the id to cur
        |> Map.put(:cur, new_card.id)
        # Set the flipped flag of this card to true
        |> Map.put(:cards, flip_card(game.cards, new_card))
      # Update new_card so that any subsequent calls to it will have the
      # updated flipped flag
      new_card = new_game.cards[new_card.id]
      # Check if the card is a match and update the matched flags
      # and matches count accordingly
      update_matched(new_game, new_card)
        # Update prev if applicable
        |> Map.put(:prev, set_prev(game, new_card))
        # Lock the next turn if this is the second guess so that the user
        # cannot start a new turn while the unflip logic is executing
        |> Map.put(:ready, game.flipped == 0)
        # Increment the click count by 1
        |> Map.put(:clicks, game.clicks + 1)
        # Increment the flipped count by 1
        |> Map.put(:flipped, game.flipped + 1)
    # Else, don't do anything
    else
      game
    end
  end

  # Randomizes the order of the cards array
  defp shuffle do
    %{
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
