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
      cards: shuffle()
    }
  end

  # Returns the current state of the game
  def client_view(game) do
    %{
      matches: game.matches,
      clicks: game.clicks,
      flipped: game.flipped,
      cur: game.cur,
      prev: game.prev,
      ready: game.ready,
      cards: game.cards
    }
  end

  # Sets the flipped flag of the card to true
  defp flip_card(cards, card) do
    idx = get_key(cards, card.id)
    List.replace_at(cards,
      idx,
      %{letter: Enum.at(cards, idx).letter,
        id: Enum.at(cards, idx).id,
        flipped: true,
        matched: Enum.at(cards, idx).matched})
  end

  # Determines if the current card is a match
  defp update_matched(game, card) do
    # If this is the second card in the turn and this card's letter matches
    # the previous card's letter
    if game.flipped != 0
      && Enum.at(game.cards, get_key(game.cards, game.prev)).letter == card.letter do
      # Set the matched flag of both to true
      card_idx = get_key(game.cards, card.id)
      prev_idx = get_key(game.cards, game.prev)
      new_cards =
        List.replace_at(game.cards,
          card_idx,
          %{letter: Enum.at(game.cards, card_idx).letter,
            id: Enum.at(game.cards, card_idx).id,
            flipped: Enum.at(game.cards, card_idx).flipped,
            matched: true})
        |> List.replace_at(prev_idx,
             %{letter: Enum.at(game.cards, prev_idx).letter,
               id: Enum.at(game.cards, prev_idx).id,
               flipped: Enum.at(game.cards, prev_idx).flipped,
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

  # Handles what happens when a turn is complete
  def unflip(game) do
    # If this is the second guess in the turn, flip back the two cards after 1
    # second and reset any other fields
    if game.flipped == 2 do
      cur_idx = get_key(game.cards, game.cur)
      prev_idx = get_key(game.cards, game.prev)
      new_cards =
        List.replace_at(game.cards,
          cur_idx,
          %{letter: Enum.at(game.cards, cur_idx).letter,
            id: Enum.at(game.cards, cur_idx).id,
            flipped: false,
            matched: Enum.at(game.cards, cur_idx).matched})
        |> List.replace_at(prev_idx,
             %{letter: Enum.at(game.cards, prev_idx).letter,
               id: Enum.at(game.cards, prev_idx).id,
               flipped: false,
               matched: Enum.at(game.cards, prev_idx).matched})
      # Update the cards
      Map.put(game, :cards, new_cards)
      # Reset the flipped count
      |> Map.put(:flipped, 0)
      # Change the ready flag back to true to indicate that the user can
      # start a new turn
      |> Map.put(:ready, true)
    # Else, don't do anything
    else
      game
    end
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
      new_game =
        game
        # Set the id to cur
        |> Map.put(:cur, new_card.id)
        # Set the flipped flag of this card to true
        |> Map.put(:cards, flip_card(game.cards, new_card))
      # Update new_card so that any subsequent calls to it will have the
      # updated flipped flag
      new_card = Enum.at(new_game.cards, get_key(new_game.cards, new_card.id))
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

  # Returns a shuffled cards array
  defp shuffle() do
    [
      %{letter: "A", id: 1, flipped: false, matched: false},
      %{letter: "A", id: 2, flipped: false, matched: false},
      %{letter: "B", id: 3, flipped: false, matched: false},
      %{letter: "B", id: 4, flipped: false, matched: false},
      %{letter: "C", id: 5, flipped: false, matched: false},
      %{letter: "C", id: 6, flipped: false, matched: false},
      %{letter: "D", id: 7, flipped: false, matched: false},
      %{letter: "D", id: 8, flipped: false, matched: false},
      %{letter: "E", id: 9, flipped: false, matched: false},
      %{letter: "E", id: 10, flipped: false, matched: false},
      %{letter: "F", id: 11, flipped: false, matched: false},
      %{letter: "F", id: 12, flipped: false, matched: false},
      %{letter: "G", id: 13, flipped: false, matched: false},
      %{letter: "G", id: 14, flipped: false, matched: false},
      %{letter: "H", id: 15, flipped: false, matched: false},
      %{letter: "H", id: 16, flipped: false, matched: false}
    ]
    |> Enum.shuffle()
  end

  # Converts the map keys from strings to atoms;
  # ATTRIBUTION:
  # https://stackoverflow.com/questions/31990134/how-to-convert-map-keys-from-strings-to-atoms-in-elixir
  defp string_to_atom(m) do
    for {key, val} <- m, into: %{}, do: {String.to_atom(key), val}
  end

  # Returns the key corresponding to the given card
  defp get_key(cards, id) do
    Enum.find_index(cards, fn(x) -> x.id == id end)
  end
end
