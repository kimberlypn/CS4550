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
      flipped: 0,
      cards: [
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
      ]
    };
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

  matched(cards, cur) {
    var match = false;
    _.map(cards, (c) => {
      if (c.flipped && c.id != cur.id && c.letter == cur.letter) {
        match = true;
        return _.extend(c, {matched: true});
      }
    });
    return match;
  }

  // Increments the number of clicks each time a card is flipped by the user
  flip(card) {
    let xs = _.map(this.state.cards, (c) => {
      if (c.id == card.id) {
        return _.extend(c, {
          flipped: true,
          matched: this.matched(this.state.cards, c)
        });
      }
      else {
        return c;
      }
    });
    let click_count = this.state.clicks + 1;
    let flipped_count = this.state.flipped + 1;
    let st1 = _.extend(this.state, {
      clicks: click_count,
      flipped: flipped_count,
      cards: xs,
    });
    this.setState(st1);
  }

  render() {
    let cards = _.map(this.state.cards, (card, ii) => {
      return <RenderCards card={card} flip={this.flip.bind(this)} key={ii}/>;
    });
    return (
      <div>
        <div className="row">
          <p>Number of Clicks: {this.state.clicks}</p>
        </div>
        <div className="row">
          {cards}
        </div>
      </div>
    )
  }
}

function RenderCards(props) {
  let card = props.card;
  let text = (card.matched) ? card.letter : '?';
  return <div className="col-3 text-center" onClick={() => props.flip(card)}><div className="letter">{text}</div></div>
}
