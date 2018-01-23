import React from 'react';
import ReactDOM from 'react-dom';
import { Button } from 'reactstrap';

export default function run_demo(root) {
  ReactDOM.render(<MemoryGame />, root);
}

// App state for Memory is:
// {
// matches: int // number of matches so far
// clicks: int // number of clicks so far
// }
class MemoryGame extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      matches: 0,
      clicks: 0,
      cards: [
        {letter: 'A', matched: false, flipped: false},
        {letter: 'A', matched: false, flipped: false},
        {letter: 'B', matched: false, flipped: false},
        {letter: 'B', matched: false, flipped: false},
        {letter: 'C', matched: false, flipped: false},
        {letter: 'C', matched: false, flipped: false},
        {letter: 'D', matched: false, flipped: false},
        {letter: 'D', matched: false, flipped: false},
        {letter: 'E', matched: false, flipped: false},
        {letter: 'E', matched: false, flipped: false},
        {letter: 'F', matched: false, flipped: false},
        {letter: 'F', matched: false, flipped: false},
        {letter: 'G', matched: false, flipped: false},
        {letter: 'G', matched: false, flipped: false},
        {letter: 'H', matched: false, flipped: false},
        {letter: 'H', matched: false, flipped: false}
      ]
    };
  }

  // Increments the number of clicks each time a card is flipped by the user
  incrementClicks() {
    let count = this.state.clicks + 1;
    let st1 = _.extend(this.state, {
      clicks: count,
    });
    this.setState(st1);
  }

  // Randomizes the order of the cards array
  // Attribution of shuffling logic goes to:
  // https://stackoverflow.com/questions/6274339/how-can-i-shuffle-an-array
  shuffleCards() {
    let newCards = this.state.cards;
    var j, x, i;
    for (i = newCards.length - 1; i > 0; i--) {
      j = Math.floor(Math.random() * (i + 1));
      x = newCards[i];
      newCards[i] = newCards[j];
      newCards[j] = x;
    }
    let st1 = _.extend(this.state, {
      cards: newCards,
    });
    this.setState(st1);
  }

  renderCards(cards) {
    var row = [];
    var i, j;
    for (i = 0; i < 4; i++) {
      for (j = i * 4; j < (i * 4) + 4; j++) {
        row.push(
          <div class="col-3 text-center" onClick={this.incrementClicks.bind(this)}><div class="letter">{cards[j].letter}</div></div>);
      }
    }
    return row;
  }

  render() {
    // If this is a new game, shuffle the cards
    if (this.state.clicks == 0) {
      this.shuffleCards(this);
    }
    return (
      <div>
        <div class="row">
          {this.renderCards(this.state.cards)}
        </div>
        <div class="row">
          <div class="col-12">
            <p>Number of clicks: {this.state.clicks}</p>
          </div>
        </div>
      </div>
    );
  }
}
