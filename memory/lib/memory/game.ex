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
    if game.flipped != 0 && game.prev.letter == card.letter do
      # Set the matched flag of both to true
      new_cards =
        Map.put(game.cards,
          card.id,
          %{letter: card.letter,
            id: card.id,
            flipped: card.flipped,
            matched: true})
        |> Map.put(game.prev.id,
            %{letter: game.prev.letter,
              id: game.prev.id,
              flipped: game.prev.flipped,
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
    if(game.flipped == 0, do: card, else: game.prev)
  end

  defp unflip(game, card) do

    # Update card and prev to match the state of card and prev in the deck
    new_card = game.cards[card.id]
    new_game = Map.put(game, :prev, game.cards[game.prev.id])
    # Change the flipped flag of the two cards back to false; does not
    # matter if they are a match because RenderCards() checks both flags
    new_cards =
      Map.put(new_game.cards,
        new_card.id,
        %{letter: new_card.letter,
          id: new_card.id,
          flipped: false,
          matched: new_card.matched})
      |> Map.put(new_game.prev.id,
          %{letter: new_game.prev.letter,
            id: new_game.prev.id,
            flipped: false,
            matched: new_game.prev.matched})
      new_game
      |> Map.put(:cards, new_cards)
      # Reset the flipped count
      |> Map.put(:flipped, 0)
      # Change the ready flag back to true to indicate that the user can
      # start a new turn
      |> Map.put(:ready, true)
  end

  # Converts the map keys from strings to atoms;
  # ATTRIBUTION:
  # https://stackoverflow.com/questions/31990134/how-to-convert-map-keys-from-strings-to-atoms-in-elixir
  def string_to_atom(m) do
    for {key, val} <- m, into: %{}, do: {String.to_atom(key), val}
  end

  # Handles what happens when a card is clicked by the user
  def clicked(game, card) do
    # Convert the map keys in card from strings to atoms;
    new_card = string_to_atom(card)
    # Only execute if the card has not been matched yet, another turn is not in
    # progress, and the card is the first card of the game or is different
    # from the previous card
    if not new_card.matched
      && game.ready
      && (game.flipped == 0 || game.prev.id != new_card.id) do
      # Save the old match count
      old_count = game.matches
      new_game = game
        # Set the flipped flag of this card to true
        |> Map.put(:cards, flip_card(game.cards, new_card))
        # Check if the card is a match and update the matched flags
        # and matches count accordingly
        |> update_matched(new_card)
        # Update prev if applicable
        |> Map.put(:prev, set_prev(game, new_card))
        # Lock the next turn if this is the second guess so that the user
        # cannot start a new turn while the unflip logic is executing
        |> Map.put(:ready, game.flipped == 0)
        # Increment the click count by 1
        |> Map.put(:clicks, game.clicks + 1)
        # Increment the flipped count by 1
        |> Map.put(:flipped, game.flipped + 1)
      # If this is the second guess in the turn, flip back the two cards after 1
      # second and reset any other fields
      if new_game.flipped == 2 do
        # If a match was found, let the user start the next turn immediately
        if new_game.matches > old_count do
          unflip(new_game, new_card)
        # Else, set a 1-second delay so that the user has a chance to
        # memorize the cards
        else
          unflip(new_game, new_card)
        end
      # Else, don't do anything
      else
        new_game
      end
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
