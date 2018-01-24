import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<MemoryGame />, root);
}

// Randomizes the order of the cards array
function ShuffleCards(c) {
  let newCards = c;
  var i, random_idx, old;
  for (var i = 0; i < newCards.length; i++) {
    // Grab a random index
    random_idx = Math.floor(Math.random() * newCards.length);
    // Save the card that was previously at i
    old = newCards[i];
    // Set the card at i to be the card at random_idx
    newCards[i] = newCards[random_idx];
    // Set the card at random_idx to be the card that used to be at i
    newCards[random_idx] = old;
  }
  return newCards;
}

class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      matches: 0,  // number of matches so far
      clicks: 0,   // number of clicks so far
      flipped: 0,  // number of cards currently flipped
      prev: null,  // previous card that was flipped
      ready: true, // false if a turn is still in progress
      cards: ShuffleCards([
        {letter: 'A', matched: false, flipped: false, id: 0},
        {letter: 'A', matched: false, flipped: false, id: 1},
        {letter: 'B', matched: false, flipped: false, id: 2},
        {letter: 'B', matched: false, flipped: false, id: 3},
        {letter: 'C', matched: false, flipped: false, id: 4},
        {letter: 'C', matched: false, flipped: false, id: 5},
        {letter: 'D', matched: false, flipped: false, id: 6},
        {letter: 'D', matched: false, flipped: false, id: 7},
        {letter: 'E', matched: false, flipped: false, id: 8},
        {letter: 'E', matched: false, flipped: false, id: 9},
        {letter: 'F', matched: false, flipped: false, id: 10},
        {letter: 'F', matched: false, flipped: false, id: 11},
        {letter: 'G', matched: false, flipped: false, id: 12},
        {letter: 'G', matched: false, flipped: false, id: 13},
        {letter: 'H', matched: false, flipped: false, id: 14},
        {letter: 'H', matched: false, flipped: false, id: 15}
      ]) // shuffled deck of cards
    };
  }

  // Determines if the current card is a match
  matched(card) {
    var match = false;
    // If this is the second card in the turn
    if (this.state.flipped != 0) {
      // Check if this card's letter matches the previous card's letter
      match = (this.state.prev.letter == card.letter);
    }
    // If there is a match
    if (match) {
      // Update the matches count
      var matches_count = this.state.matches + 1;
      _.extend(this.state, { matches: matches_count });
      // Update the matched flag of this card and the previous card
      _.extend(this.state.prev, { matched: true });
      _.extend(card, { matched: true });
    }
  }

  // Handles what happens when a turn is complete
  unflip(card) {
    // Change the flipped flag of the two cards back to false; does not matter
    // if they are a match because RenderCards() checks both flags
    _.extend(card, { flipped: false });
    _.extend(this.state.prev, { flipped: false });
    // Reset the flipped count and change the ready flag back to true to
    // indicate that the user can start a new turn
    let st1 = _.extend(this.state, {
      flipped: 0,
      ready: true,
    });
    // Set the new state
    this.setState(st1);
  }

  // Handles what happens when a card is clicked by the user
  clicked(card) {
    // Only execute if the card has not been matched yet, another turn is not in
    // progress, and the card is the first card of the game or is different
    // from the previous card
    if (!card.matched && this.state.ready && (this.state.flipped == 0 || this.state.prev.id != card.id)) {
      // Save the old count of matches
      let oldCount = this.state.matches;
      // Set the flipped flag of this card
      let xs = _.map(this.state.cards, (c) => {
        if (c.id == card.id) {
          return _.extend(c, {
            flipped: true,
          });
        }
        else {
          return c;
        }
      });
      // Check if the card is a match
      this.matched(card);
      // Only update prev if this is the first guess in the turn
      let p = (this.state.flipped == 0) ? card : this.state.prev;
      // Lock the next turn if this is the second guess so that the user
      // cannot start a new turn while the unflip logic is executing
      let r = (this.state.flipped == 0);
      // Increment the number of cards flipped
      let flipped_count = this.state.flipped + 1;
      // Increment the number of clicks
      let click_count = this.state.clicks + 1;
      // Update and set the new state
      let st1 = _.extend(this.state, {
        clicks: click_count,
        flipped: flipped_count,
        prev: p,
        ready: r,
        cards: xs,
      });
      this.setState(st1);
      // Get the new count of matches
      let newCount = this.state.matches;
      // If this is the second guess in the turn, flip back the two cards after
      // 1 second and reset any other fields
      if (this.state.flipped == 2) {
        // If a match was found, let the user start the next turn immediately
        if (newCount > oldCount) {
          this.unflip(card);
        }
        // Otherwise, set a 1 second delay so that the user has a chance to
        // memorize the cards
        else {
          setTimeout(() => {this.unflip(card)}, 1000);
        }
      }
    }
  }

  // Resets the state of the game
  reset() {
    let st1 = _.extend(this.state, {
      matches: 0,
      clicks: 0,
      flipped: 0,
      prev: null,
      ready: true,
      cards: ShuffleCards([
        {letter: 'A', matched: false, flipped: false, id: 0},
        {letter: 'A', matched: false, flipped: false, id: 1},
        {letter: 'B', matched: false, flipped: false, id: 2},
        {letter: 'B', matched: false, flipped: false, id: 3},
        {letter: 'C', matched: false, flipped: false, id: 4},
        {letter: 'C', matched: false, flipped: false, id: 5},
        {letter: 'D', matched: false, flipped: false, id: 6},
        {letter: 'D', matched: false, flipped: false, id: 7},
        {letter: 'E', matched: false, flipped: false, id: 8},
        {letter: 'E', matched: false, flipped: false, id: 9},
        {letter: 'F', matched: false, flipped: false, id: 10},
        {letter: 'F', matched: false, flipped: false, id: 11},
        {letter: 'G', matched: false, flipped: false, id: 12},
        {letter: 'G', matched: false, flipped: false, id: 13},
        {letter: 'H', matched: false, flipped: false, id: 14},
        {letter: 'H', matched: false, flipped: false, id: 15}
      ])
    });
    this.setState(st1);
  }

  // Renders the game board
  render() {
    let cards = _.map(this.state.cards, (card, ii) => {
      return <RenderCards card={card} clicked={this.clicked.bind(this)} key={ii}/>;
    });
    // If the player has won, display the "winner" message
    if (this.state.matches == 8) {
      console.log("win");
      return (
        <div id="winner">
          <div className="row">
            <div className="col-12 text-center">
              <p id="win-text">YOU WON!</p>
            </div>
          </div>
          <div className="row">
            <div className="col-12 text-center">
              <p>It took you {this.state.clicks} clicks.</p>
            </div>
          </div>
          <div className="row">
            <div className="col-12 text-center">
              <p>Press the 'Reset' button to play again.</p>
            </div>
          </div>
          <div className="row">
            <div className="col-12 text-center">
              <Reset reset={this.reset.bind(this)} />
            </div>
          </div>
        </div>
      )
    }
    // Else, render the game board
    else {
      return (
        <div>
          <div className="row">
            <div className="col-6">
              <p>NUMBER OF CLICKS: {this.state.clicks}</p>
            </div>
            <div className="col-6 text-right">
              <Reset reset={this.reset.bind(this)} />
            </div>
          </div>
          <div className="row">
            {cards}
          </div>
        </div>
      )
    }
  }
}

// Renders each individual card
function RenderCards(props) {
  let card = props.card;
  let text = "?";
  if (card.flipped) {
    text = card.letter;
  }
  if (card.matched) {
    text = (<span class="glyphicon glyphicon-thumbs-up"></span>);
  }
  return (
    <div className="col-3 text-center">
      <div className="letter" onClick={() => props.clicked(card)}>{text}
      </div>
    </div>
  )
}

function Reset(props) {
  return <Button id="reset-btn" onClick={() => props.reset()}>RESET</Button>
}

/*
function Winner(props) {
return (
<div className="row">
<div className="col-12 text-center">
<p id="win-text">YOU WON!</p>
</div>
</div>
<div className="row">
<div className="col-12 text-center">
<p>It took you {this.state.clicks} clicks.</p>
</div>
</div>
<div className="row">
<div className="col-12 text-center">
<p>Press the 'Reset' button to play again.</p>
</div>
</div>
)
}
*/
